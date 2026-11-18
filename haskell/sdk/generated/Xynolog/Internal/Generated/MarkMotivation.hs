-- Generated from protocol/specs/src/components/schemas/MarkJobParams.json and protocol/specs/src/components/schemas/Motivation.json; do not edit.
-- Regenerate: make generate (codegen/lib/job_storage/job_storage.ml)
module Xynolog.Internal.Generated.MarkMotivation (markMotivation) where

import Xynolog.Types (MarkJobParams (..), Motivation (..))

markMotivation :: MarkJobParams -> Motivation
markMotivation (MarkJobParamsBranch1 _) = MotivationHighlighting
markMotivation (MarkJobParamsBranch2 _) = MotivationCommenting
markMotivation (MarkJobParamsBranch3 _) = MotivationAssessing
markMotivation (MarkJobParamsBranch4 _) = MotivationLinking
markMotivation (MarkJobParamsBranch5 _) = MotivationTagging
