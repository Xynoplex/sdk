package xynolog.state

import xynolog.errors.JobError
import xynolog.errors.JobErrorCode
import xynolog.errors.XynologError

/** Whether a job ended because it was cancelled: its commits stand, and its display stays to say so. */
internal fun cancelled(failure: XynologError): Boolean = failure is JobError && failure.reason == JobErrorCode.Cancelled
