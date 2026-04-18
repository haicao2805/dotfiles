# @inject Pattern

Use `@inject` with `BindingKeys.build()` for all DI constructor parameters.

## Syntax

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

## Rules

- Always use `BindingKeys.build()` with explicit `namespace`
- Always use `.name` for key (e.g. `MyRepository.name`) — never hardcode strings like `'MyRepository'`. Bun compile may mangle class names; `.name` stays in sync.
- Common namespaces: `REPOSITORY`, `SERVICE`, `COMPONENT`, `DATASOURCE`
- Parameter order: repositories first, then services, then components
- Controller passes primary repository to `super()`
- Field names use `_` prefix (see 003-private-naming)
