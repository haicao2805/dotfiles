# Throwing Errors

Use `getError` from `@nx/core` for every thrown HTTP error. The `messageCode` carries the i18n key the FE uses to localise the error.

## Key format

```
server.<service>.<domain>.<action>.<reason>
```

- `service` — package name (`identity`, `sale`, `pricing`, …)
- `domain` — functional area within the package (`auth`, `otp`, `order`, …)
- `action` — operation (`sign_in`, `find`, `create`, …)
- `reason` — failure cause (`not_found`, `invalid_credential`, …)
- `reason` may contain additional dots; everything after the 4th dot is the reason.

Example: `server.identity.auth.sign_in.identifier_not_found`

## File structure

Each package defines its errors under:

```
packages/<pkg>/src/errors/
  ├── <domain>.errors.ts   # one file per domain
  └── index.ts             # barrel
```

## Definition file

```typescript
// packages/identity/src/errors/auth.errors.ts
import { ErrorCategories, type TErrorDefinition } from '@nx/core';
import { HTTP } from '@venizia/ignis-helpers';

export const AuthErrors = {
  SIGN_IN_IDENTIFIER_NOT_FOUND: {
    key: 'server.identity.auth.sign_in.identifier_not_found',
    statusCode: HTTP.ResultCodes.RS_4.NotFound,
    category: ErrorCategories.AUTH,
    message: 'Account not found with the given identifier.',
    description: 'Sign-in attempt with an identifier that does not exist.',
  },
  // ...
} as const satisfies Record<string, TErrorDefinition>;

declare module '@nx/core' {
  // eslint-disable-next-line @typescript-eslint/no-empty-object-type
  interface IErrorKeyRegistry
    extends Record<(typeof AuthErrors)[keyof typeof AuthErrors]['key'], true> {}
}
```

### `TErrorDefinition` fields

| Field | Required | Notes |
|-------|----------|-------|
| `key` | ✔ | Full dot-notated key. |
| `statusCode` | ✔ | Default HTTP status. |
| `message` | ✔ | English default — used when call site doesn't override. |
| `messageArgs` | — | Key-value args for message templating. |
| `category` | — | `AUTH` / `VALIDATION` / `BUSINESS` / `SYSTEM` / `INTEGRATION`. |
| `description` | — | Context for the translator; surfaced in the CSV export. |

### Module augmentation

The `declare module '@nx/core'` block feeds every key into the global `IErrorKeyRegistry` interface, which powers LSP autocomplete on `messageCode`. The block must appear in the same file as the `as const` map so both ship together.

## Call sites — two overload shapes

`getError` is imported from `@nx/core` (not `@venizia/ignis-helpers`). It has two overloads:

### 1. Definition form (preferred)

Reads `key`, `statusCode`, and `message` from the registered definition. `message` and `messageArgs` optionally override at the call site.

```typescript
import { getError } from '@nx/core';
import { AuthErrors } from '@/errors';

throw getError({ error: AuthErrors.SIGN_IN_IDENTIFIER_NOT_FOUND });

// override message at runtime:
throw getError({
  error: AuthErrors.SIGN_IN_UNSUPPORTED_SCHEME,
  message: `Unsupported credential scheme: ${scheme}`,
});

// with template args:
throw getError({
  error: AuthErrors.ORDER_ITEM_QUANTITY_EXCEEDED,
  messageArgs: { max: limit, actual: qty },
});
```

### 2. Free-form (use only when statusCode differs from the definition)

```typescript
throw getError({
  messageCode: 'server.identity.auth.sign_in.invalid_credential', // typed — LSP autocompletes
  statusCode: HTTP.ResultCodes.RS_4.Unauthorized,
  message: 'Invalid login details provided.',
});
```

`messageCode` is typed as `TErrorKey` — a union of all keys registered via `IErrorKeyRegistry`. Unknown keys are rejected at compile time.

## Rules

- Every throw goes through `getError` from `@nx/core`. Never call the raw `getError` from `@venizia/ignis-helpers` directly.
- Every `messageCode` must exist in an `*.errors.ts` registration — otherwise the FE cannot translate it.
- Prefer the definition form. Use free-form only when you genuinely need a different `statusCode` or `message` from the canonical definition.
- `key` in the definition must match the key used at call sites; the compiler enforces this via the augmentation.
- Don't reuse a key across definitions. The CSV exporter (`bun scripts/export-error-keys.ts`) warns on duplicates.

## Translation export

`bun scripts/export-error-keys.ts` walks every `packages/*/src/errors/*.errors.ts`, diffs against prior exports in the output directory, and writes:

- `<timestamp>_error-keys.csv` — full snapshot (all keys)
- `<timestamp>_error-keys_duplicated.csv` — only keys whose `en` changed since the previous run

Columns: `translate, module, service, domain, action, reason, en, vi` (header row included). The translator fills `vi` in Google Sheets.
