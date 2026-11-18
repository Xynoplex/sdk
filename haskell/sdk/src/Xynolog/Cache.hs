-- | Lazy read-through queries and their three observable outcomes.
module Xynolog.Cache
  ( Cache,
    Query,
    CacheState (..),
    CacheOptions (..),
    CachePersister (..),
    newCache,
    query,
    current,
    watch,
    fresh,
    invalidateQuery,
    observe,
    fetch,
    get,
    known,
    keys,
    invalidate,
    invalidateAll,
    remove,
    set,
    patch,
    persistencePending,
    dispose,
    isReady,
    readyValue,
  )
where

import Xynolog.Internal.Cache
