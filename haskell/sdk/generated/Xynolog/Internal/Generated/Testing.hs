-- Generated from protocol/specs/src/client/testing.json; do not edit.
-- Regenerate: make generate (codegen/lib/testing/testing.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Testing (FaultAction(..), faultKind, DeliveryOp(..), deliveryOpName, faultActions, scheduleLength, slack, Respond, RequestLogEntry(..), FaultyTransport(..), LivenessScenario(..), LivenessSpec(..)) where
import Data.Aeson (Object, Value)
import Data.Text (Text)
import Xynolog.Retry (RetryOptions)
import Xynolog.Transport (Transport, Carried)
import Test.QuickCheck (Gen, oneof, chooseInteger)
data FaultAction = Deliver | DropReply | Delay Integer | DuplicateReply | RejectEmit deriving (Eq, Show)
faultKind :: FaultAction -> Text
faultKind Deliver = "deliver"
faultKind DropReply = "drop-reply"
faultKind (Delay _) = "delay"
faultKind DuplicateReply = "duplicate-reply"
faultKind RejectEmit = "reject-emit"
-- | One step of an interleaving: a write, or a client-initiated transition.
data DeliveryOp = Write | Transition deriving (Eq, Ord, Show, Enum, Bounded)
deliveryOpName :: DeliveryOp -> Text
deliveryOpName Write = "write"
deliveryOpName Transition = "transition"
faultActions :: Gen FaultAction
faultActions = oneof [pure Deliver, pure DropReply, Delay <$> chooseInteger (0, 5), pure DuplicateReply, pure RejectEmit]
-- | How many faults a drawn schedule is of.
scheduleLength :: (Int, Int)
scheduleLength = (1, 8)
-- | How many times its reckoned bound a case is given: the room a scheduler's jitter takes.
slack :: Integer
slack = 4
type Respond = Text -> Object -> IO (Maybe Value)
-- | One request the transport was sent.
data RequestLogEntry = RequestLogEntry
  { requestLogEntryChannel :: Text
  , requestLogEntryAction :: FaultAction
  , requestLogEntryCorrelationId :: Maybe Text
  , requestLogEntryRetryKey :: Text
  , requestLogEntryPayload :: Object
  }
-- | The transport owner fills this with its real carrier and its native controls.
data FaultyTransport = FaultyTransport
  { carrier :: Transport
  , queueReply :: Text -> [Maybe Value] -> IO ()
  , refuseWhen :: (Text -> Object -> IO (Maybe Object)) -> IO ()
  , requestLog :: IO [RequestLogEntry]
  , deliver :: Carried -> IO ()
  }
-- | What one fresh run of a composition exposes to the axioms.
data LivenessScenario = LivenessScenario
  { livenessScenarioOutputs :: [IO ()]
  , livenessScenarioSettlements :: [IO ()]
  }
-- | A composition, and the schedules it is run under.
data LivenessSpec = LivenessSpec
  { livenessSpecSetup :: FaultyTransport -> (LivenessScenario -> IO ()) -> IO ()
  , livenessSpecTimeoutMs :: Integer
  , livenessSpecRetryBudget :: Integer
  , livenessSpecCases :: Int
  , livenessSpecSchedules :: Gen [FaultAction]
  , livenessSpecMakeResponse :: Respond
  , livenessClock :: RetryOptions
  }
