/**
 * ResourceErrorState - Error state component for resource viewer
 *
 * Pure React component - no Next.js dependencies.
 */

export interface ResourceErrorStateProps {
  error: unknown;
  onRetry: () => void;
}

export function ResourceErrorState({ error, onRetry }: ResourceErrorStateProps) {
  return (
    <div className="xynoplex-error-state xynoplex-error-state-resource">
      <p className="xynoplex-error-message">
        {error instanceof Error ? error.message : 'Failed to load resource'}
      </p>
      <button
        onClick={onRetry}
        className="xynoplex-button"
        data-variant="secondary"
      >
        Try Again
      </button>
    </div>
  );
}
