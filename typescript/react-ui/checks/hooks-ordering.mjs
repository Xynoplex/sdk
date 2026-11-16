/**
 * React hooks are called where React's rules allow, read off the TypeScript
 * syntax tree.
 *
 * 1. No hook called inline as a JSX prop inside a conditional render: the
 *    pattern behind the ResourceViewer bug.
 * 2. No hook called inside the function a `useCallback` or `useMemo` is
 *    given: that function need not run on every render, so the hook inside it
 *    is called conditionally (the clone and archive bug).
 * 3. At most one `useEventSubscriptions` call per file: a file's subscriptions
 *    are combined into one.
 *
 * Test files are not read. The tree is parsed with the `typescript` package,
 * resolved from where this package is installed: the host's own.
 */
export const name = "hooks are called where React's rules allow";

const MEMOIZING_HOOKS = new Set(['useCallback', 'useMemo']);

export async function check(tree) {
  const { default: ts } = await import('typescript');

  const hookName = (node) => ts.isCallExpression(node) && ts.isIdentifier(node.expression)
    && /^use[A-Z]/.test(node.expression.text) ? node.expression.text : undefined;

  /** Whether some ancestor is a ternary or a `&&`. */
  const inConditional = (node) => {
    for (let current = node; current; current = current.parent) {
      if (ts.isConditionalExpression(current)) return true;
      if (ts.isBinaryExpression(current) && current.operatorToken.kind === ts.SyntaxKind.AmpersandAmpersandToken) return true;
    }
    return false;
  };

  /** Whether some ancestor is the `{…}` of a JSX attribute. */
  const inJsxProp = (node) => {
    for (let current = node; current; current = current.parent) {
      if (ts.isJsxExpression(current) && current.parent && ts.isJsxAttribute(current.parent)) return true;
    }
    return false;
  };

  /** The memoizing hook whose function argument holds `node`, if one does. */
  const memoizedIn = (node) => {
    for (let current = node.parent; current; current = current.parent) {
      if (!ts.isArrowFunction(current) && !ts.isFunctionExpression(current)) continue;
      const call = current.parent;
      if (call && ts.isCallExpression(call) && ts.isIdentifier(call.expression)
        && MEMOIZING_HOOKS.has(call.expression.text) && call.arguments[0] === current) {
        return call.expression.text;
      }
    }
    return undefined;
  };

  const failures = [];
  const read = tree.files.filter((file) => /\.tsx?$/.test(file) && !/\.(test|spec)\.tsx?$/.test(file));
  for (const file of read) {
    const source = ts.createSourceFile(file, tree.read(file), ts.ScriptTarget.Latest, true);
    const at = (node) => {
      const { line, character } = source.getLineAndCharacterOfPosition(node.getStart(source));
      return `${tree.show(file)}:${line + 1}:${character + 1}`;
    };
    let subscriptions = 0;
    const visit = (node) => {
      const hook = hookName(node);
      if (hook) {
        if (hook === 'useEventSubscriptions') subscriptions += 1;
        if (inJsxProp(node) && inConditional(node)) {
          failures.push(`${at(node)}: ${hook} is called inline as a prop inside a conditional render; call it before the condition and use its result`);
        }
        const memoizing = memoizedIn(node);
        if (memoizing) {
          failures.push(`${at(node)}: ${hook} is called inside ${memoizing}()'s function; call it at the component's top level and use its result there`);
        }
      }
      ts.forEachChild(node, visit);
    };
    visit(source);
    if (subscriptions > 1) {
      failures.push(`${tree.show(file)}: ${subscriptions} useEventSubscriptions calls; combine them into one`);
    }
  }
  return { failures, notes: [] };
}
