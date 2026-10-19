# Shared Contract Layer — `@nx-app/core`

`apps/core` (`@nx-app/core`) is the **shared FE library**: domain types, Zod schemas, constants,
helpers, hooks, i18n, and socket infra consumed by every FE app (`client`, `bo`, `sale-renderer`).
It has no UI and no dev server — it's a pure library built with `tsc`.

## Where things go

```
apps/core/src/
├── interfaces/<domain>/     # I* entity interfaces, T* payload/response types
├── schemas/<domain>/        # Zod schemas — *FormClientSchema, request validation
├── constants/<domain>/      # enums / constant classes (PascalCase)
├── helpers/                 # pure business logic (react-hook-form.helper, fare.helper, ...)
├── hooks/                   # shared hooks (useFormatCurrency, ...)
├── utilities/               # format, currency, number, slugify, ...
├── locales/                 # en.ts / vi.ts — GENERATED, never hand-edit
└── index.ts                 # GENERATED barrel — never hand-edit
```

- Interfaces use `I` prefix (`IProduct`), types use `T` prefix (`TProductUpdateAggregate`).
- A domain owns its interfaces **and** Zod schemas — keep the inferred `z.infer<>` type and the
  hand-written interface in sync, or derive one from the other.
- React / RHF / Redux / lodash etc. are **peer deps** provided by the consuming app. Do not add
  app-only runtime deps to `core`.

## Build & rebuild discipline

`core` is precompiled to `dist/`; consumers import from the built output, so **new exports are
invisible until you rebuild**:
```bash
bun run --filter=@nx-app/core rebuild   # gen:index + clean + build
```
- After adding/removing any export, the barrel must be regenerated — `rebuild` runs `gen:index`;
  never hand-edit `src/index.ts`.
- During a rebuild, consuming apps briefly show `Cannot find module '@nx-app/core'` /
  `--jsx is not set` / "excessively deep" diagnostics. These are **transient** — `tsc --noEmit`
  on the consumer after the rebuild is the source of truth.

`@nx-app/admin-ui-kit` follows the same rules (component library, generated barrel): run
`bun run gen:index` then `bun run build`/`rebuild` after adding a component.

## Rules
- Define the contract here **before** writing UI (see [100](./100-fe-feature-flow.md)).
- Never hand-edit generated files: `src/locales/*.ts` and `src/index.ts`.
- Rebuild `core` before relying on new exports; trust `tsc --noEmit`, not mid-rebuild editor noise.
- Keep `core` UI-free and use only peer-provided deps.
