module IncompleteFaultReason where

import Xynolog.Bus (FaultReason (..))

missing :: FaultReason -> Bool
missing Lacks = True
