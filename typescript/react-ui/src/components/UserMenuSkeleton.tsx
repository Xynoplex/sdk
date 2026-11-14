'use client';

export function UserMenuSkeleton() {
  return (
    <div
      className="xynoplex-user-menu-skeleton"
      aria-label="Loading user menu"
      role="status"
    >
      <span className="xynoplex-sr-only">Loading user menu...</span>
    </div>
  );
}