using Xynolog.Errors;
using Xynolog.Identifiers;
using Xynolog.Types;

namespace Xynolog.State;

public sealed class GatherStateUnit : IStateUnit
{
    private readonly XynologClient client;
    private readonly ResourceId annotationResource;
    private readonly UnitWork work;
    private readonly GatherSlot annotation = new();
    private readonly GatherSlot resource = new();

    public StateValue<GatheredContext?> Context => annotation.Context;
    public StateValue<bool> Loading => annotation.Loading;
    public StateValue<XynologError?> Error => annotation.Error;
    public StateValue<AnnotationId?> AnnotationId { get; } = new(null);
    public StateValue<GatheredContext?> ResourceContext => resource.Context;
    public StateValue<bool> ResourceLoading => resource.Loading;
    public StateValue<XynologError?> ResourceError => resource.Error;

    public GatherStateUnit(XynologClient client, ResourceId resourceId)
    {
        this.client = client;
        annotationResource = resourceId;
        work = new UnitWork(client.Transport.Closed);
    }

    public void GatherAnnotation(AnnotationId annotationId, GatherAnnotationOptions? options = null)
    {
        lock (work.Gate)
        {
            if (!work.Active) return;
            AnnotationId.Set(annotationId);
            Start(annotation, async token => (await client.Gather.Annotation(annotationResource, annotationId, options)
                .CompleteAsync(token).ConfigureAwait(Spawning.Captures)).Response);
        }
    }

    public void GatherResource(ResourceId resourceId, long depth = 2, long maxResources = 10, bool includeContent = true,
        bool includeSummary = false, IReadOnlyList<string>? excludeEntityTypes = null)
    {
        lock (work.Gate)
        {
            if (!work.Active) return;
            Start(resource, token => client.Gather.ResourceAsync(resourceId, depth, maxResources, includeContent,
                includeSummary, excludeEntityTypes, token));
        }
    }

    private void Start(GatherSlot slot, Func<CancellationToken, Task<GatheredContext>> gather)
    {
        slot.Loading.Set(true);
        slot.Context.Set(null);
        slot.Error.Set(null);
        work.Run(token => LandAsync(slot, gather, token));
    }

    private async Task LandAsync(GatherSlot slot, Func<CancellationToken, Task<GatheredContext>> gather, CancellationToken token)
    {
        GatheredContext? context = null;
        XynologError? failure = null;
        try { context = await gather(token).ConfigureAwait(Spawning.Captures); }
        catch (XynologError error) { failure = error; }
        lock (work.Gate)
        {
            if (!work.Active) return;
            slot.Context.Set(context);
            slot.Error.Set(failure);
            slot.Loading.Set(false);
        }
    }

    public void Dispose()
    {
        lock (work.Gate)
        {
            work.Dispose();
            annotation.Close();
            resource.Close();
            AnnotationId.Close();
        }
    }

    private sealed class GatherSlot
    {
        internal StateValue<GatheredContext?> Context { get; } = new(null);
        internal StateValue<bool> Loading { get; } = new(false);
        internal StateValue<XynologError?> Error { get; } = new(null);

        internal void Close()
        {
            Context.Close();
            Loading.Close();
            Error.Close();
        }
    }
}
