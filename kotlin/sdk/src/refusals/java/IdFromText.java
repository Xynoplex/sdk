// refused: incompatible types: String cannot be converted to AnnotationId
// From Java too, text is no id.
import xynolog.types.MarkDeleteCommand;

class IdFromText {
    MarkDeleteCommand command = MarkDeleteCommand.builder("ann-1").build();
}
