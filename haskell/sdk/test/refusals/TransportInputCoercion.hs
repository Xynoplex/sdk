module TransportInputCoercion where
import Data.Coerce (coerce)
import Xynoplex.Transport (Transport, TransportInput)
wrong :: Transport -> TransportInput
wrong = coerce
