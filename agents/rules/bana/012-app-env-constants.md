# Application Environment Constants

Access env vars only through `applicationEnvironment` (aliased `AppEnv`) from
`@venizia/ignis-helpers`, keyed by a predefined `EnvironmentKeys` constant (aliased `EnvKeys`) —
never a raw string literal.

Import the two helpers **aliased**, same spirit as the [002 @inject pattern](./002-inject-pattern.md):

```typescript
import { EnvironmentKeys as EnvKeys } from '@nx/core'; // or '@/common' for a package-local extension
import { applicationEnvironment as AppEnv } from '@venizia/ignis-helpers';
```

## Where keys live

`packages/core/src/common/environments.ts` defines the base `EnvironmentKeys` class (extending
`@venizia/ignis`'s own `EnvironmentKeys`) with every **common / cross-package** env key. Check
here first before adding a new one.

```typescript
// packages/core/src/common/environments.ts
import { EnvironmentKeys as BaseEnvironmentKeys } from '@venizia/ignis';

export class EnvironmentKeys extends BaseEnvironmentKeys {
  // Application
  static readonly APP_ENV_NODE_ENV = 'APP_ENV_NODE_ENV';

  // License Certificate (Ed25519)
  static readonly APP_ENV_LICENSING_ED25519_PRIVATE_KEY = 'APP_ENV_LICENSING_ED25519_PRIVATE_KEY';
}
```

If a package needs **additional package-specific** vars, add a local
`packages/<pkg>/src/common/environments.ts` that extends `@nx/core`'s `EnvironmentKeys`, and
re-export it from the package's `common` barrel (`src/common/index.ts`, or wherever that
package's shared constants barrel lives — e.g. `src/shared/common/index.ts`):

```typescript
// packages/identity/src/common/environments.ts
import { EnvironmentKeys as BaseEnvironmentKeys } from '@nx/core';

export class EnvironmentKeys extends BaseEnvironmentKeys {
  static readonly APP_ENV_CODE_BY_PASS_SMS_OTP = 'APP_ENV_CODE_BY_PASS_SMS_OTP';
  static readonly APP_ENV_ENABLE_BY_PASS_SMS_OTP = 'APP_ENV_ENABLE_BY_PASS_SMS_OTP';
}
```

A package that only ever consumes keys already declared in core does **not** need a local
`environments.ts` — import `EnvironmentKeys` straight from `@nx/core`.

## Usage

```typescript
import { EnvironmentKeys as EnvKeys } from '@nx/core'; // or '@/common' for a package-local extension
import { applicationEnvironment as AppEnv } from '@venizia/ignis-helpers';

const appSecret = AppEnv.get<string>(EnvKeys.APP_ENV_APPLICATION_SECRET);
const certTtl = int(AppEnv.get<string>(EnvKeys.APP_ENV_LICENSING_CERT_TTL_SECONDS) ?? '86400');
```

```typescript
// ❌ raw string literal — no compile-time safety, no discoverability, easy to typo
const appSecret = AppEnv.get<string>('APP_ENV_APPLICATION_SECRET');

// ❌ unaliased import — inconsistent with the rest of the codebase
import { EnvironmentKeys } from '@nx/core';
const appSecret = AppEnv.get<string>(EnvironmentKeys.APP_ENV_APPLICATION_SECRET);
```

## Rules

- Import aliased: `applicationEnvironment as AppEnv`, `EnvironmentKeys as EnvKeys`. Use the
  aliases at every call site — never the unaliased names.
- Never pass a raw string literal to `AppEnv.get()` / `.set()` — always an `EnvKeys.APP_ENV_*` member.
- Check `packages/core/src/common/environments.ts` first; add common/cross-package vars there.
- Package-specific vars go in that package's own `environments.ts` (under its `common` constants
  directory), extending `@nx/core`'s `EnvironmentKeys` (`extends BaseEnvironmentKeys` — the base
  class import keeps its full name since it's not the call-site alias), and are re-exported via
  that directory's barrel `index.ts`.
- A package with no additional vars beyond core's does not need a local `environments.ts` —
  import `EnvironmentKeys as EnvKeys` straight from `@nx/core`.
- New env vars must also be documented in the package's `.env.example`.
