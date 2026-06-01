# @inject Pattern

Use `@inject` with `BindingKeys.build()` for application repositories / services / components, and the direct framework constant for framework-level singletons.

## Syntax — application bindings (use `BindingKeys.build()`)

```typescript
constructor(
  @inject({
    key: BindingKeys.build({
      key: MyRepository.name,
      namespace: BindingNamespaces.REPOSITORY,
    }),
  })
  private readonly _myRepository: MyRepository,

  @inject({
    key: BindingKeys.build({
      key: MyService.name,
      namespace: BindingNamespaces.SERVICE,
    }),
  })
  private readonly _myService: MyService,
) {
  super(_myRepository); // controller passes main repo to super
}
```

## Syntax — framework singletons (use the direct constant)

Pre-defined singletons exposed by `BindingKeys` / `CoreBindings` are injected by their constant directly — no `.build()` wrapper.

```typescript
constructor(
  @inject({ key: BindingKeys.APPLICATION_REDIS_CACHE })
  private readonly _redis: DefaultRedisHelper,

  @inject({ key: BindingKeys.OTP_SENDER })
  private readonly _otpSender: IOTPSender,

  @inject({ key: CoreBindings.APPLICATION_INSTANCE })
  protected readonly _application: BaseApplication,
) {
  super({ scope: MyService.name });
}
```

These keys are framework-defined string constants (not class-name + namespace pairs), so `BindingKeys.build()` is not the right shape for them.

## Rules

- Application repositories / services / components → `BindingKeys.build({ key: X.name, namespace: BindingNamespaces.X })`. Always use `.name` (e.g. `MyRepository.name`) — never hardcode strings; Bun compile may mangle class names, `.name` stays in sync.
- Framework singletons (`BindingKeys.APPLICATION_*`, `BindingKeys.OTP_SENDER`, `CoreBindings.APPLICATION_INSTANCE`, etc.) → inject by the direct constant.
- Common application namespaces: `REPOSITORY`, `SERVICE`, `COMPONENT`, `DATASOURCE`.
- Parameter order: repositories first, then services, then components, then framework singletons last.
- Controller passes primary repository to `super()`.
- Field names use `_` prefix (see 003-private-naming).
