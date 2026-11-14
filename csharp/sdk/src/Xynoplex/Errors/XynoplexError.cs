using Xynoplex.Identifiers;
using Xynoplex.Protocol;
using Xynoplex.Types;

namespace Xynoplex.Errors;

public abstract class XynoplexError : Exception
{
    /// <summary>How many of what a stream says before anyone reads it are kept for its first reader: a session's errors, a
    /// transport's failures, a registry's own errors, and a worker's claim refusals and stalls.</summary>
    internal static readonly int KeptForFirstReader = ProtocolFacts.Timing("errorsKeptForFirstReaderCount").GetInt32();

    private protected XynoplexError(string code, string message, int? status = null, Exception? inner = null) : base(message, inner)
    {
        Code = code;
        Status = status;
    }

    public string Code { get; }
    public int? Status { get; }
}

public sealed class BusRequestError(string code, string message) : XynoplexError(code, message);

public sealed class TransportError(string code, string message, int? status = null, Exception? inner = null) : XynoplexError(code, message, status, inner);

public sealed class SignInError(string code, string message, int? status = null, Exception? inner = null) : XynoplexError(code, message, status, inner);

public sealed class SessionError(string code, string message, Exception? inner = null) : XynoplexError(code, message, inner: inner);

public sealed class JobError : XynoplexError
{
    internal JobError(string code, string message, JobId? jobId, FailureClass? failureClass = null) : base(code, message)
    {
        JobId = jobId;
        FailureClass = failureClass;
    }

    public JobId? JobId { get; }
    public FailureClass? FailureClass { get; }
}
