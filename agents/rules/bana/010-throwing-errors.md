# Throwing Errors

Use `getError` for every thrown HTTP error. The `messageCode` carries the i18n key the FE uses to localise the error.

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
  ├── <domain>.error.ts    # one file per domain
  └── index.ts             # barrel
```

## Definition file

```typescript
// packages/identity/src/errors/auth.error.ts
import { type TLocalizedErrorDefinition } from '@nx/core';
import { ErrorScopes, HTTP, type TRegisterErrors } from '@venizia/ignis-helpers';

export const AuthErrors = {
  SIGN_IN_ACCOUNT_LOCKED: {
    message: {
      code: 'server.identity.auth.sign_in.account_locked',
      text: 'Account is temporarily locked. Please try again in %{retryAfterMinutes} minutes.',
    },
    locale: {
      en: 'Account is temporarily locked. Please try again in %{retryAfterMinutes} minutes.',
      vi: 'Tài khoản tạm thời bị khoá. Vui lòng thử lại sau %{retryAfterMinutes} phút.',
    },
    statusCode: HTTP.ResultCodes.RS_4.TooManyRequests,
    category: ErrorScopes.BUSINESS,
    description: 'Too many consecutive wrong-password attempts - lockout record still active.',
  },
} as const satisfies Record<string, TLocalizedErrorDefinition>;

declare module '@venizia/ignis-helpers' {
  interface IErrorKeyRegistry extends TRegisterErrors<typeof AuthErrors> {}
}
```

Files are `<domain>.error.ts` (singular). A new error is one edit: code + `text` + `locale.en`
+ `locale.vi`.

### Fields

| Field | Required | Notes |
|-------|----------|-------|
| `message.code` | ✔ | Full dot-notated key. |
| `message.text` | ✔ | English default used at runtime. |
| `locale.en` / `locale.vi` | ✔ in `packages/*` | `en` must equal `text`; `vi` is the user-facing copy. |
| `statusCode` | ✔ | Default HTTP status. |
| `category` | — | `ErrorScopes.*`. |
| `description` | — | Context for translators and reviewers. |

`third-parties/*` cannot import `@nx/core`: keep `TErrorDefinition` from
`@venizia/ignis-helpers` and no `locale`.

### Syncing copy to the FE

Run after adding or editing an error, then commit the locale diff:

```bash
make i18n-errors-write-<pkg>        # or: bun scripts/i18n/errors-sync.ts --write --service <pkg>
```

- Insert-only: the FE `en.ts` / `vi.ts` wins on conflict. To make the server text replace it, pass
  `ARGS="--override <key>"` (also `--override-prefix`, `--override-all`).
- `vi` may drop a placeholder that `en` has, but must not use one `en` lacks.
- Never hand-edit `auroras/kits/core/src/locales/*.ts` for `server.*` keys; use the script.

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
