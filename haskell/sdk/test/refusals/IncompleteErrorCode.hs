module IncompleteErrorCode where
import Xynoplex.ErrorCodes (BusRequestCode(..))
incomplete :: BusRequestCode -> Bool
incomplete BusRequestTimeout = True
