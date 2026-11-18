module TransportInputCoercion where

import Data.Coerce (coerce)
import Xynolog.Transport (Transport, TransportInput)

wrong :: Transport -> TransportInput
wrong = coerce
