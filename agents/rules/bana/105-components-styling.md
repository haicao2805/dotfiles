# Components & Styling

FE UI is built from the shared `@nx-app/admin-ui-kit` (Radix + shadcn/ui, "New York" style) and
Tailwind CSS v4. Pages are lazy-loaded `*.screen.tsx` files.

## File roles

- `*.screen.tsx` — page component, lazy-loaded behind `<Suspense fallback={<PageLoading />}>`.
- `*.route.tsx` — route wrapper / metadata.
- `*.slice.ts` — Redux slice (UI / workspace state only — server state belongs to React Query).

## Components

- Compose from `@nx-app/admin-ui-kit` (`Button`, `Dialog`, `Command`, `Card`, …) rather than
  hand-rolling primitives; it wraps Radix for accessibility.
- Merge class names with `cn()` (clsx + tailwind-merge) — never string-concat `className`.
- Use Radix `asChild` / `Slot` for polymorphism; CVA for variant definitions; `data-slot` for
  styling hooks.
- After adding/removing a component in `admin-ui-kit`, run `bun run gen:index` then rebuild — the
  barrel `index.ts` is generated, never hand-edited.

## Styling

- Tailwind v4 with OKLch theme variables (CSS custom properties); prefer theme tokens
  (`text-muted-foreground`, `bg-primary`) over raw colors.
- `prettier-plugin-tailwindcss` sorts classes — let `lint:fix` order them; don't fight it.
- Responsive via the project breakpoints + `useIsMobile()`.

## Rules
- Pages are `*.screen.tsx`, lazy + `Suspense`; slices hold only UI/workspace state.
- Build from `admin-ui-kit`; merge classes with `cn()`; never concat `className`.
- Regenerate the `admin-ui-kit` barrel with `gen:index` after component changes — never hand-edit it.
- Use theme tokens, not raw colors; let prettier sort Tailwind classes.
