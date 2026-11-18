package xynolog.session

import xynolog.StateUnit
import xynolog.transport.Variable
import xynolog.transport.Watched
import xynolog.types.KbIdentityConflict
import xynolog.types.PermissionDenied
import xynolog.types.SessionEndReason
import xynolog.types.SessionEnded

/**
 * What a host shows about a session, apart from the session: that it ended,
 * that a request was refused for lack of permission, that a different
 * knowledge base is answering at a registered address. A session is headless
 * and raises none of these itself: a host that shows them builds one of these
 * beside each live session and wires the session's failures into it. Each
 * signal is null while nothing is raised and the notice while something is.
 * Raising it again is a new occurrence, told to every reader even when the
 * notice equals the last. A signal says and decides nothing, and a notice
 * says what happened, never a sentence: what a person reads is the host's to
 * write, in their language.
 */
public class SessionSignals : StateUnit {
    private val ended = Variable<SessionEnded?>(null)
    private val denied = Variable<PermissionDenied?>(null)
    private val conflict = Variable<KbIdentityConflict?>(null)

    /** The session ended: it expired, or its credential was refused. */
    public val sessionEnded: Watched<SessionEnded?> = ended.reading()

    /** A request was refused for lack of permission. */
    public val permissionDenied: Watched<PermissionDenied?> = denied.reading()

    /** A different knowledge base is answering at the entry's address. */
    public val kbIdentityConflict: Watched<KbIdentityConflict?> = conflict.reading()

    public fun notifySessionEnded(reason: SessionEndReason): Unit = ended.raise(SessionEnded(reason))

    public fun notifyPermissionDenied(detail: String?): Unit = denied.raise(PermissionDenied(detail))

    public fun notifyKbIdentityConflict(conflict: KbIdentityConflict): Unit = this.conflict.raise(conflict)

    public fun acknowledgeSessionEnded(): Unit = ended.raise(null)

    public fun acknowledgePermissionDenied(): Unit = denied.raise(null)

    public fun acknowledgeKbIdentityConflict(): Unit = conflict.raise(null)

    override fun close() {
        ended.end()
        denied.end()
        conflict.end()
    }
}
