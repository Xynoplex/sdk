module IncompleteCacheState where
import Xynoplex.Cache (CacheState(..))

value :: CacheState Int -> Maybe Int
value Pending = Nothing
value (Ready answer) = Just answer
