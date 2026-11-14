module WritableState where
import qualified Xynoplex.StateValue as State
wrong :: State.StateValue value -> value -> IO ()
wrong state value = State.update state value
