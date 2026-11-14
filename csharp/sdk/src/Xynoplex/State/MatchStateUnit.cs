using Xynoplex.Errors;
using Xynoplex.Types;

namespace Xynoplex.State;

public sealed class MatchStateUnit : IStateUnit
{
    private readonly XynoplexClient client;
    private readonly UnitWork work;
    private readonly EventBus.Subscription events;

    public MatchStateUnit(XynoplexClient client)
    {
        this.client = client;
        work = new UnitWork(client.Transport.Closed);
        events = client.Bus.Listen([BusChannels.MatchSearchRequested.Name]);
        work.Run(ReadAsync);
    }

    private async Task ReadAsync(CancellationToken cancellation)
    {
        await foreach (var carried in Spawning.ReadAll(events.Reader, cancellation).ConfigureAwait(Spawning.Captures))
        {
            lock (work.Gate)
            {
                if (!work.Active) return;
                // A request that is not a search's names nothing to search for.
                if (Bus.HeardOf<MatchSearchRequest>(carried) is Heard<MatchSearchRequest>.Delivered asked)
                    work.Run(token => SearchAsync(asked.Payload, asked.Received.CorrelationId, token));
            }
        }
    }

    private async Task SearchAsync(MatchSearchRequest request, string? correlationId, CancellationToken cancellation)
    {
        try
        {
            var found = await client.Match.Search(request.ResourceId, request.ReferenceId, request.Context,
                request.Limit ?? 10, request.UseSemanticScoring ?? true).CompleteAsync(cancellation).ConfigureAwait(Spawning.Captures);
            lock (work.Gate)
                if (work.Active) client.Bus.Emit(BusChannels.MatchSearchResults, found, correlationId: correlationId);
        }
        catch (XynoplexError error)
        {
            lock (work.Gate)
                if (work.Active) client.Bus.Emit(BusChannels.MatchSearchFailed,
                    new MatchSearchFailed { ReferenceId = request.ReferenceId, Message = error.Message }, correlationId: correlationId);
        }
    }

    public void Dispose()
    {
        lock (work.Gate) { work.Dispose(); events.Dispose(); }
    }
}
