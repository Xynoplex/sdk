module ClientRecordUpdate where
import qualified Xynolog.Client as Client
import qualified Xynolog.Bus as Bus

replace :: Client.Client -> Bus.Bus -> Client.Client
replace client wire = client { Client.wire = wire }
