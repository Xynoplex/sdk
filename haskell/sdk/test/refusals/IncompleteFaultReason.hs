module IncompleteFaultReason where
import Xynoplex.Bus (FaultReason(..))

missing :: FaultReason -> Bool
missing Lacks = True
