-- | A knowledge base's kept grant, with atomic renewal and sign-out.
module Xynolog.SignIn (KeptSignIn (..), newMemorySignIn, renewKept) where

import Xynolog.Internal.SignIn
