module ClientRecordUpdate where

import qualified Xynolog.Bus as Bus
import qualified Xynolog.Client as Client

replace :: Client.Client -> Bus.Bus -> Client.Client
replace client wire = client {Client.wire = wire}
