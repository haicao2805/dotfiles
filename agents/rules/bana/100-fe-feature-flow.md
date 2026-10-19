# FE Feature Implementation Flow

The order of operations when building a feature across the FE apps (`client`, `bo`,
`sale-renderer`) and the shared libraries (`@nx-app/core`, `@nx-app/admin-ui-kit`). Do the
layers in this order — skipping ahead (e.g. UI before the contract) causes type churn and rework.

## Steps

### 1. Contract first — `apps/core` (`@nx-app/core`)
Define the data shapes before any UI:
- Interfaces → `src/interfaces/<domain>/` (`I*` entities, `T*Payload` / `T*Response`).
- Zod schemas → `src/schemas/<domain>/` (form schemas `*FormClientSchema`, request validation).
- Constants / enums → `src/constants/<domain>/`.

Then **rebuild** so consuming apps resolve the new exports:
```bash
bun run --filter=@nx-app/core rebuild
```
Transient `Cannot find module '@nx-app/core'` (or `--jsx is not set`) diagnostics during a
rebuild are noise — `tsc --noEmit` is authoritative. Same for `@nx-app/admin-ui-kit` after
adding a component: `bun run gen:index` → rebuild.

### 2. API service — `application/services/apis/<domain>/`
Extend `BaseCrudApiService<TEntity, TPayload>`; decorate methods with `@api()`; add custom
endpoints as methods (e.g. `createAggregate`). Guard optional query params so `undefined`
isn't serialized: `...(maxDepth !== undefined && { query: { maxDepth } })`. Bind any new
service in the app's `application.ts` DI container.

### 3. Data hooks
- Read: `useGetData<T>({ apiKey, queryParams, queryFn, queryOptions })`.
- Write: `useMutationData()`, and invalidate the related query keys in `onSettled`.
- Resolve services with `useInjectable<TApi>({ key: 'services.XApi' })`.

### 4. Form (if the feature has one)
- `useForm({ resolver: zodResolver(schema), defaultValues })`.
- Edit screens: load via `reset(mapServerDataToForm(...))` in an effect once data has arrived.
- Submit a **diff**, not the whole form — only changed fields / entities. Thread entity `id`s
  through the form when the BE matches by id (edit = `{ id, ...changed }`, delete = `{ id }`,
  create = `{ ...fields }` with no id). See 104 for the array-dirty pitfall.

### 5. UI
- Page components are `*.screen.tsx`, lazy-loaded with `<Suspense fallback={<PageLoading />}>`.
- Compose from `@nx-app/admin-ui-kit`; merge classes with `cn()`.
- RHF field paths come from constants (e.g. `ProductPaths.*`), never inline string literals.

### 6. i18n
- All user-facing copy via `useTranslate()` with **typed** keys — reference an existing key or
  have one generated; `tsc` fails on unknown keys.
- **Never hand-edit `apps/core/src/locales/*.ts`** — they are generated.

### 7. Verify (gate — all must pass)
```bash
bun run lint:fix                 # in the touched app
bunx tsc --noEmit -p tsconfig.json
```
Zero errors, zero warnings. If `@nx-app/core` or `@nx-app/admin-ui-kit` exports changed,
rebuild them first, then re-check the consuming app.

## Rules
- Contract (`apps/core`) before UI; rebuild the shared lib before relying on new exports.
- Never hand-edit generated files — `apps/core` locales, and the `admin-ui-kit` `index.ts`
  barrel (run `bun run gen:index` instead).
- Submit diffs, not whole forms; carry `id`s for BE matching.
- `tsc --noEmit` is the source of truth during cross-package rebuilds — ignore transient
  module-resolution / JSX diagnostics from the editor mid-rebuild.
- Use `bun`, never `pnpm`/`npm`.
- Cross-cutting rules [003 private naming](./003-private-naming.md),
  [008 commenting](./008-commenting.md), and [011 eslint quality](./011-eslint-quality.md)
  apply to FE code too.
