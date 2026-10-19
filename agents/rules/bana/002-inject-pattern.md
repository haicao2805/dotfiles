# @inject Pattern

Use `@inject({ target: X })` — the class itself — as the **default** for application
repositories / services / components. The container resolves the binding from the class, so no
`BindingKeys`/`BindingNamespaces` aliases are needed for application bindings.

```typescript
import { inject } from '@venizia/ignis';
```

## Old rule vs new rule

| | Old (legacy) | New (current) |
|---|---|---|
| Shape | `@inject({ key: BK.build({ namespace: BNS.X, key: X.name }) })` | `@inject({ target: X })` |
| Imports | `BindingKeys as BK`, `BindingNamespaces as BNS` from `@venizia/ignis` | just `inject` — no aliases |
| Key source | string key built from namespace + class name | the class itself |
| Reference | `packages/sale/src/services/sale/sale-cart.service.ts` | `packages/sale/src/services/checkout.service.ts` |

**New code MUST use the new (`target`) form.** Legacy code keeps compiling and is not broken —
do not rewrite an old file purely for the DI change, but when a file is already being touched,
convert its injections to `target` in the same change. The old form remains valid only where a
class cannot be the key (see "When `key` is still required" below).

## Syntax — application bindings (prefer `target`)

Keep the whole `@inject({ target: ... })` on **one line** when it fits the 100-char width, and
group constructor params with `// repositories`, `// services`, `// components` block comments.

```typescript
constructor(
  // repositories
  @inject({ target: MyRepository })
  private readonly _myRepo: MyRepository,
  @inject({ target: OtherRepository })
  private readonly _otherRepo: OtherRepository,

  // services
  @inject({ target: MyService })
  private readonly _myService: MyService,
) {
  super(_myRepo); // controller passes main repo to super
}
```

`target` accepts the imported class; the field type carries the same class, so imports stay
normal (no aliasing). Reference example: `packages/sale/src/services/checkout.service.ts`.

## When `key` is still required

`@inject({ key: ... })` stays for things that have **no injectable class to target**:

- Framework singletons (`BindingKeys` / `CoreBindings` constants). Import `BindingKeys as BK`
  and `BindingNamespaces as BNS` **aliased** only in files that still need them; `CoreBindings`
  is a separate import and is **not** aliased.
- Any string key built via `BK.build({ namespace, key })` when the value is bound under a
  non-class key (e.g. a queue, a provider, a conditional binding).

```typescript
constructor(
  // framework singletons
  @inject({ key: BK.APPLICATION_EVENT_BUS })
  private readonly _events: SaleEventBus,
  @inject({ key: BK.APPLICATION_REDIS_CACHE })
  private readonly _redis: DefaultRedisHelper,
  @inject({ key: CoreBindings.APPLICATION_INSTANCE })
  protected readonly _application: BaseApplication,
) {
  super({ scope: MyService.name });
}
```

## Rules

- Default: `@inject({ target: X })` for anything bound by class — repositories, services,
  components. Do not reach for `BK.build()` when the class name alone resolves the binding.
- Use `@inject({ key: ... })` only when there is no class to target (framework constants,
  non-class string keys). When you must use `key` with an application namespace, build it as
  `BK.build({ namespace: BNS.X, key: X.name })` — always `.name` (e.g. `MyRepository.name`),
  never hardcode strings; Bun compile may mangle class names, `.name` stays in sync.
- Framework singletons (`BK.APPLICATION_*`, `BK.OTP_SENDER`, `CoreBindings.APPLICATION_INSTANCE`,
  etc.) → inject by the direct constant. `CoreBindings` is a separate import, not aliased.
- Keep each `@inject` on **one line** when it fits the 100-char print width; only wrap when it
  genuinely overflows.
- Common application namespaces (only when a string `key` is unavoidable): `REPOSITORY`,
  `SERVICE`, `COMPONENT`, `DATASOURCE`.
- Parameter order: repositories first, then services, then components, then framework singletons
  last. Divide the groups with lightweight `// repositories`, `// services`, `// components`,
  `// framework singletons` block comments.
- Controller passes primary repository to `super()`; services call `super({ scope: X.name })`.
- Field names use `_` prefix (see 003-private-naming).
- Abbreviate `Repository` to `Repo` in the field name for shorter code — `_myRepo`, not
  `_myRepository`. The injected **type** keeps its full name (`MyRepository`) and a `key`-based
  injection still uses `MyRepository.name`; only the variable is shortened.
