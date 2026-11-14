/**
 * ResourceLoadingState - Loading state component for resource viewer
 *
 * Pure React component - no Next.js dependencies.
 */

export function ResourceLoadingState() {
  return (
    <div className="xynoplex-loading-state xynoplex-loading-state-resource">
      <p className="xynoplex-loading-message">Loading resource...</p>
    </div>
  );
}
