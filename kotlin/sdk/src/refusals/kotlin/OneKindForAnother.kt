// refused: argument type mismatch: actual type is 'ResourceId', but 'AnnotationId' was expected
// One kind of id is not another.
import xynolog.identifiers.ResourceId
import xynolog.types.MarkDeleteCommand

val command = MarkDeleteCommand(annotationId = ResourceId("res-1"))
