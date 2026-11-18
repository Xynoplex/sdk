/**
 * ResourceErrorState - Error state component for resource viewer
 *
 * Pure React component - no Next.js dependencies.
 */

export interface ResourceErrorStateProps {
  error: unknown;
  onRetry: () => void;
}

export function ResourceErrorState({
  error,
  onRetry,
}: ResourceErrorStateProps) {
  return (
    <div className="xynolog-error-state xynolog-error-state-resource">
      <p className="xynolog-error-message">
        {error instanceof Error ? error.message : 'Failed to load resource'}
      </p>
      <button
        onClick={onRetry}
        className="xynolog-button"
        data-variant="secondary"
      >
        Try Again
      </button>
    </div>
  );
}
