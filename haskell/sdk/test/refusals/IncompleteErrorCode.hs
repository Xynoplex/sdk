module IncompleteErrorCode where
import Xynolog.ErrorCodes (BusRequestCode(..))
incomplete :: BusRequestCode -> Bool
incomplete BusRequestTimeout = True
