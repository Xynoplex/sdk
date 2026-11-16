/**
 * SVG Utility Functions
 *
 * Utilities for creating, parsing, and manipulating W3C-compliant SVG selectors
 * for image annotation.
 */

export interface Point {
  x: number;
  y: number;
}

/**
 * Create W3C-compliant SVG rectangle selector
 */
export function createRectangleSvg(start: Point, end: Point): string {
  const x = Math.min(start.x, end.x);
  const y = Math.min(start.y, end.y);
  const width = Math.abs(end.x - start.x);
  const height = Math.abs(end.y - start.y);

  return `<svg xmlns="http://www.w3.org/2000/svg"><rect x="${x}" y="${y}" width="${width}" height="${height}"/></svg>`;
}

/**
 * Create W3C-compliant SVG polygon selector
 */
export function createPolygonSvg(points: Point[]): string {
  if (points.length < 3) {
    throw new Error('Polygon requires at least 3 points');
  }

  const pointsStr = points.map(p => `${p.x},${p.y}`).join(' ');
  return `<svg xmlns="http://www.w3.org/2000/svg"><polygon points="${pointsStr}"/></svg>`;
}

/**
 * Create W3C-compliant SVG circle selector
 */
export function createCircleSvg(center: Point, radius: number): string {
  if (radius <= 0) {
    throw new Error('Circle radius must be positive');
  }

  return `<svg xmlns="http://www.w3.org/2000/svg"><circle cx="${center.x}" cy="${center.y}" r="${radius}"/></svg>`;
}

/**
 * The attributes of the first `<name …/>` element in `svg`: white space after
 * the name, at least one more character, and `/>` at the first `>`. Found by
 * index, in one pass, where a regular expression would backtrack quadratically.
 */
function selfClosingElementAttributes(svg: string, name: string): string | undefined {
  const opener = `<${name}`;
  let close = -1;
  for (let start = svg.indexOf(opener); start !== -1; start = svg.indexOf(opener, start + 1)) {
    const attributesStart = start + opener.length;
    if (close < attributesStart) close = svg.indexOf('>', attributesStart);
    if (close === -1) return undefined;
    const attributes = svg.slice(attributesStart, close - 1);
    if (attributes.length >= 2 && /\s/.test(attributes.charAt(0)) && svg.charAt(close - 1) === '/') {
      return attributes;
    }
  }
  return undefined;
}

/**
 * Parse SVG selector to extract shape type and data
 */
export function parseSvgSelector(svg: string):
  | { type: 'rect'; data: { x: number; y: number; width: number; height: number } }
  | { type: 'polygon'; data: { points: Point[] } }
  | { type: 'circle'; data: { cx: number; cy: number; r: number } }
  | null {
  // Extract rectangle
  const rectAttributes = selfClosingElementAttributes(svg, 'rect');
  if (rectAttributes !== undefined) {
    const attrs = rectAttributes;
    const x = parseFloat(attrs.match(/x="([^"]+)"/)?.[1] || '0');
    const y = parseFloat(attrs.match(/y="([^"]+)"/)?.[1] || '0');
    const width = parseFloat(attrs.match(/width="([^"]+)"/)?.[1] || '0');
    const height = parseFloat(attrs.match(/height="([^"]+)"/)?.[1] || '0');

    return {
      type: 'rect',
      data: { x, y, width, height }
    };
  }

  // Extract polygon
  const polygonMatch = svg.match(/<polygon\s+points="([^"]+)"/);
  if (polygonMatch && polygonMatch[1]) {
    const pointsStr = polygonMatch[1];
    const points = pointsStr.split(/\s+/).map(pair => {
      const [x, y] = pair.split(',').map(parseFloat);
      return { x, y };
    });

    return {
      type: 'polygon',
      data: { points }
    };
  }

  // Extract circle
  const circleAttributes = selfClosingElementAttributes(svg, 'circle');
  if (circleAttributes !== undefined) {
    const attrs = circleAttributes;
    const cx = parseFloat(attrs.match(/cx="([^"]+)"/)?.[1] || '0');
    const cy = parseFloat(attrs.match(/cy="([^"]+)"/)?.[1] || '0');
    const r = parseFloat(attrs.match(/r="([^"]+)"/)?.[1] || '0');

    return {
      type: 'circle',
      data: { cx, cy, r }
    };
  }

  return null;
}

/**
 * Scale entire SVG selector from display space to image native resolution
 */
export function scaleSvgToNative(
  svg: string,
  displayWidth: number,
  displayHeight: number,
  imageWidth: number,
  imageHeight: number
): string {
  const parsed = parseSvgSelector(svg);
  if (!parsed) return svg;

  const scaleX = imageWidth / displayWidth;
  const scaleY = imageHeight / displayHeight;

  switch (parsed.type) {
    case 'rect': {
      const { x, y, width, height } = parsed.data;
      return createRectangleSvg(
        { x: x * scaleX, y: y * scaleY },
        { x: (x + width) * scaleX, y: (y + height) * scaleY }
      );
    }

    case 'circle': {
      const { cx, cy, r } = parsed.data;
      return createCircleSvg(
        { x: cx * scaleX, y: cy * scaleY },
        r * Math.min(scaleX, scaleY)
      );
    }

    case 'polygon': {
      const points = parsed.data.points.map((p: Point) => ({
        x: p.x * scaleX,
        y: p.y * scaleY
      }));
      return createPolygonSvg(points);
    }
  }
}
