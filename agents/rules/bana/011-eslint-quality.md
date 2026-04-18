# ESLint & Code Quality

Run `bun run lint:fix` after every change. Zero errors and zero warnings required — no exceptions.

## Naming Conventions (enforced by `@typescript-eslint/naming-convention`)

| Symbol | Format | Notes |
|---|---|---|
| Types (`type T*`) | `PascalCase` | Must start with `T` prefix — e.g. `TMyType` |
| Interfaces | `PascalCase` | Must start with `I` prefix — e.g. `IMyInterface` |
| Classes, Enums | `PascalCase` | — |
| Variables, params | `camelCase` | `UPPER_CASE` allowed for constants |
| Private/protected members | `camelCase` | `_` leading underscore allowed (see 003-private-naming) |
| Static members | `camelCase` or `UPPER_CASE` | — |
| Boolean variables | `PascalCase` with prefix | Must use: `is`, `has`, `can`, `should`, `will`, `did`, `do`, `use`, `with`, `force`, `auto`, `rs`, `re`, `error`, `success`, `enable/d`, `disable/d`, `activate/d`, `deactivate/d`, `ignore`, `require` |

```typescript
// ✅
const isActive = true;
const hasPermission = false;
const shouldRetry = false;
const rsData = result;

// ❌
const active = true;
const valid = false;
const result_data = rs;
```

## Banned Patterns

```typescript
// ❌ use let/const, never var
var x = 1;

// ❌ always use curly braces
if (x) doThing();

// ❌ use === not ==
if (x == null) {}

// ❌ no unused variables (all vars: "all", args: "none")
const unused = 'x';

// ❌ no void operator
void somePromise();

// ❌ no throw literals — always throw Error objects
throw 'something went wrong';
throw { message: 'error' };

// ❌ no unused expressions
x > 0; // expression result ignored

// ❌ import all of lodash — import individual functions
import _ from 'lodash';       // banned
import get from 'lodash/get'; // ✅

// ❌ use node: protocol for Node builtins
import fs from 'fs';          // banned
import fs from 'node:fs';     // ✅

// ❌ no floating (unhandled) promises
someAsyncFn(); // must await or void-handle intentionally

// ❌ use optional chaining
if (obj && obj.prop) {}       // use obj?.prop
// ❌ use nullish coalescing
const x = val !== null && val !== undefined ? val : 'default'; // use val ?? 'default'

// ❌ prefer for-of over indexed array loops when index unused
for (let i = 0; i < arr.length; i++) { use(arr[i]); }
```

## Prettier (auto-fixed by lint:fix)

```
singleQuote: true        → use ' not "
printWidth: 100          → max line length 100
tabWidth: 2              → 2-space indent
trailingComma: "all"     → trailing commas everywhere
arrowParens: "avoid"     → x => x, not (x) => x
semi: true               → always end statements with ;
bracketSpacing: true     → { x } not {x}
```

## Workflow

```bash
bun run lint:fix    # auto-fix everything possible
bun run lint        # check remaining issues
bun run rebuild     # confirm clean build
```

All three must pass before a change is considered complete.
