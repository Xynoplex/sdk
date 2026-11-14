-- | Typed job lifecycle reports and job-following failures.
module Xynoplex.Delegation (JobEvent(..), UploadEvent(..), JobError(..), deriveStallDeadlineMs) where
import Xynoplex.Internal.Delegation
