// refused: 'val' cannot be reassigned
// A model is what was read or made: it is not changed in place.
import xynoplex.identifiers.AnnotationId
import xynoplex.types.MarkDeleteCommand

fun reassign(command: MarkDeleteCommand) {
    command.annotationId = AnnotationId("ann-2")
}
