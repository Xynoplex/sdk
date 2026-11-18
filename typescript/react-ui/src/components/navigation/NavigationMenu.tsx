'use client';

import React from 'react';
import type {
  RouteBuilder,
  LinkComponentProps,
} from '../../contexts/RoutingContext';
import type { TranslateFn } from '../../types/translation';
import './NavigationMenu.css';

interface NavigationMenuProps {
  Link: React.ComponentType<LinkComponentProps>;
  routes: Partial<RouteBuilder>;
  t: TranslateFn;
  brandingLink?: string;
  onItemClick?: () => void;
  className?: string;
  currentPath?: string;
}

export function NavigationMenu({
  Link,
  routes,
  t,
  onItemClick,
  className = '',
  currentPath,
}: NavigationMenuProps) {
  const navClassName = className
    ? `xynolog-navigation-menu ${className}`
    : 'xynolog-navigation-menu';

  // Helper to check if a path is current
  const isCurrentPage = (path: string) => {
    if (!currentPath) return false;
    // Exact match or starts with path followed by /
    return currentPath === path || currentPath.startsWith(path + '/');
  };

  return (
    <nav className={navClassName} aria-label="Main navigation">
      <Link
        href={routes.knowledge?.() || '/know'}
        {...(onItemClick && { onClick: onItemClick })}
        className="xynolog-navigation-menu__link"
        aria-current={
          isCurrentPage(routes.knowledge?.() || '/know') ? 'page' : undefined
        }
      >
        {t('know')}
      </Link>

      <hr className="xynolog-navigation-menu__divider" />
      <Link
        href={routes.moderate?.() || '/moderate'}
        {...(onItemClick && { onClick: onItemClick })}
        className="xynolog-navigation-menu__link"
        aria-current={
          isCurrentPage(routes.moderate?.() || '/moderate') ? 'page' : undefined
        }
      >
        {t('moderate')}
      </Link>
    </nav>
  );
}
