module ClientRecordUpdate where
import qualified Xynoplex.Client as Client
import qualified Xynoplex.Bus as Bus

replace :: Client.Client -> Bus.Bus -> Client.Client
replace client wire = client { Client.wire = wire }
