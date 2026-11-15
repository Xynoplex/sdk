/**
 * ResourceLoadingState - Loading state component for resource viewer
 *
 * Pure React component - no Next.js dependencies.
 */

export function ResourceLoadingState() {
  return (
    <div className="xynolog-loading-state xynolog-loading-state-resource">
      <p className="xynolog-loading-message">Loading resource...</p>
    </div>
  );
}
