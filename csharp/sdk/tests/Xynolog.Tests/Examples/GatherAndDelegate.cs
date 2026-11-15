using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using Xynolog;
using Xynolog.Identifiers;
using Xynolog.Types;

public static class GatherAndDelegate
{
    public static async Task<YieldJobCompleteCommand> RunAsync(
        string endpoint, string token, ResourceId source, string storageUri,
        HttpClient? http = null, CancellationToken cancellation = default)
    {
        using var client = new XynologClient(endpoint, token, http);
        var context = await client.Gather.ResourceAsync(source, cancellation: cancellation);
        var generation = client.Yield.Delegate(new GenerationJobParams
        {
            Context = context,
            Title = "Notes",
            StorageUri = storageUri,
        });
        return await generation.CompleteAsync(cancellation);
    }
}
