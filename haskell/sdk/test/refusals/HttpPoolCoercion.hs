module HttpPoolCoercion where

import Data.Coerce (coerce)
import Network.HTTP.Client (Manager)
import Xynolog.Http (HttpClient)

unchecked :: Manager -> HttpClient
unchecked = coerce
