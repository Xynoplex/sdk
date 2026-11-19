using System.Reflection;
using System.Text.Json;
using Xunit;
using Xynolog.State;

namespace Xynolog.Tests;

// SearchState and JobEvent, generic and written by hand, held to their schemas in protocol/specs/src/client/types: a
// member or a branch either side gains or loses fails.
public sealed partial class TransportTests
{
    private static string[] Members(Type type) =>
        type.GetProperties(BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly)
            .Select(property => JsonNamingPolicy.CamelCase.ConvertName(property.Name)).Order().ToArray();

    private static string[] Properties(JsonElement schema) =>
        schema.GetProperty("properties").EnumerateObject().Select(property => property.Name).Order().ToArray();

    [Fact]
    public void SearchStateHasTheSchemasMembers()
    {
        using var schema = ReadSpec("client/types/SearchState.json");
        Assert.Equal(Properties(schema.RootElement), Members(typeof(SearchState<>)));
    }

    [Fact]
    public void JobEventHasTheSchemasBranchesEachOfOneDatum()
    {
        using var schema = ReadSpec("client/types/JobEvent.json");
        var branches = schema.RootElement.GetProperty("oneOf").EnumerateArray().ToDictionary(
            branch => branch.GetProperty("properties").GetProperty("kind").GetProperty("enum")[0].GetString()
                ?? throw new InvalidOperationException("A branch's kind is no string."));
        var cases = typeof(JobEvent<>).GetNestedTypes().ToDictionary(type => JsonNamingPolicy.CamelCase.ConvertName(type.Name));
        Assert.Equal(branches.Keys.Order(), cases.Keys.Order());
        foreach (var (kind, branch) in branches)
        {
            Assert.Equal(["data", "kind"], Properties(branch));
            var data = branch.GetProperty("properties").GetProperty("data");
            if (kind == "refused") Assert.Equal(Properties(data), Members(cases[kind]));
            else Assert.Equal(["value"], Members(cases[kind]));
        }
    }
}
