package xynoplex.state

import xynoplex.errors.JobError
import xynoplex.errors.JobErrorCode
import xynoplex.errors.XynoplexError

/** Whether a job ended because it was cancelled: its commits stand, and its display stays to say so. */
internal fun cancelled(failure: XynoplexError): Boolean = failure is JobError && failure.reason == JobErrorCode.Cancelled
