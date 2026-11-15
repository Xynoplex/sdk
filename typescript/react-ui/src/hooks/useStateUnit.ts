'use client';

import { useState, useEffect } from 'react';
import type { StateUnit } from '@xynolog/core';

export function useStateUnit<T extends StateUnit>(factory: () => T): T {
  const [unit] = useState(factory);
  useEffect(() => () => unit.dispose(), [unit]);
  return unit;
}
