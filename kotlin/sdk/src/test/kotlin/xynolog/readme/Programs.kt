package xynolog.readme

import kotlinx.coroutines.flow.MutableStateFlow
import xynolog.JobCompleted
import xynolog.JobProgressed
import xynolog.XynologClient
import xynolog.cache.CacheState
import xynolog.channels.BRIDGED_CHANNELS
import xynolog.http.HttpContentTransport
import xynolog.http.HttpTransport
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.ResourceId
import xynolog.types.GenerationJobParams

/*
 * The README's Kotlin programs. Each region between `// readme: <name>` and
 * `// readme: end` is a block of README.md, word for word once its indent is
 * taken off (ReadmeTest holds the two together), and each is run there.
 */

/** Open a client of the knowledge base at `baseUrl`, signed in with `token`. */
internal fun connect(baseUrl: String, token: String): XynologClient {
    // readme: connect
    val transport = HttpTransport(baseUrl, MutableStateFlow(token), BRIDGED_CHANNELS)
    val client = XynologClient(transport, HttpContentTransport(transport), transport)
    // readme: end
    return client
}

/** Gather the context around an annotation, and delegate a summary of it as a `yield` job, following the job. */
internal suspend fun gatherThenDelegate(client: XynologClient, resource: ResourceId, annotation: AnnotationId) {
    // readme: gather-then-delegate
    val context = client.gather.annotation(resource, annotation).await().response
    val params = GenerationJobParams(title = "A summary", storageUri = "file://summary.md", context = context)
    client.yield.delegate(params).collect { event ->
        when (event) {
            is JobProgressed -> println("${event.data.percentage}%")
            is JobCompleted -> println("made ${event.data.result}")
            else -> {}
        }
    }
    // readme: end
}

/** Watch a resource's annotations: each state of the live query, until whoever runs this stops it. */
internal suspend fun watchingLive(client: XynologClient, resource: ResourceId) {
    // readme: watching-live
    client.browse.annotations(resource).collect { state ->
        when (state) {
            is CacheState.Pending -> {}
            is CacheState.Ready -> println("${state.value.size} annotations")
            is CacheState.Failed -> println("not read: ${state.error.message}")
        }
    }
    // readme: end
}
