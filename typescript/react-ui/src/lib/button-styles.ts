/**
 * Centralized button styles matching Figma design
 * Two primary styles from authenticated home page:
 * 1. Primary (cyan/blue gradient) - for main CTAs
 * 2. Secondary (gray with black outline) - for secondary actions
 */

export const buttonStyles = {
  // Primary button - cyan/blue gradient (used for main CTAs like "New Document", "Sign In", "Sign Up")
  primary: {
    base: "xynolog-button xynolog-button--primary",
    large: "xynolog-button xynolog-button--primary xynolog-button--large",
  },

  // Secondary button - gray with subtle outline (used for "Search", "Cancel", etc.)
  secondary: {
    base: "xynolog-button xynolog-button--secondary",
    withScale: "xynolog-button xynolog-button--secondary xynolog-button--scale",
  },

  // Tertiary button - minimal style for less important actions
  tertiary: {
    base: "xynolog-button xynolog-button--tertiary",
  },

  // Danger button - for destructive actions
  danger: {
    base: "xynolog-button xynolog-button--danger",
  },

  // Warning/Yellow button - for highlight actions
  warning: {
    base: "xynolog-button xynolog-button--warning",
  },

  // Utility function to combine classes
  combine: (...classes: string[]) => classes.filter(Boolean).join(' '),
} as const;