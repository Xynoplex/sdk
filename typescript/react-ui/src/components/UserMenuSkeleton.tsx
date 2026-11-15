'use client';

export function UserMenuSkeleton() {
  return (
    <div
      className="xynolog-user-menu-skeleton"
      aria-label="Loading user menu"
      role="status"
    >
      <span className="xynolog-sr-only">Loading user menu...</span>
    </div>
  );
}