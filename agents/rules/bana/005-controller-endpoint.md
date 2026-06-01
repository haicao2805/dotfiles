# Controller Endpoint Definition

Controllers use `ControllerFactory.defineCrudController()` for CRUD and `bindRoute().to()` for custom endpoints.

## File Structure

```
controllers/<entity>/
  ├── definitions.ts    # permissions + route configs
  └── <entity>.controller.ts
```

## Permissions (definitions.ts)

```typescript
export const MyEntityPermissions = {
  ...crudPermissions(MyEntity.AUTHORIZATION_SUBJECT!, {
    en: 'my entities',
    vi: 'thực thể',
  }),
  CUSTOM_ACTION: {
    code: 'MyEntity.customAction',
    name: { en: 'Custom action', vi: 'Hành động tùy chỉnh' },
    description: { en: 'Custom action', vi: 'Hành động tùy chỉnh' },
    subject: MyEntity.AUTHORIZATION_SUBJECT!,
    action: AuthorizationActions.CREATE,
    scope: PolicyDomains.SYSTEM,
    parentId: null,
  } satisfies TSystemPermission,
};
```

## Route Config (definitions.ts)

The `MyEntityRoute` object is a typed registry of endpoint configs. Cast the whole map `as const` so TypeScript preserves literal types — this powers IDE autocomplete on `MyEntityRoute.X` at the call site.

```typescript
export const MyEntityRoute = {
  CUSTOM: {
    method: 'post',
    path: '/custom',
    authenticate: { strategies: ['jwt', 'basic'] },
    authorize: {
      action: AuthorizationActions.CREATE,
      resource: MyEntityPermissions.CUSTOM_ACTION.code,
    },
    request: {
      body: jsonContent({ description: 'CUSTOM | Request body', schema: MyRequestSchema }),
    },
    responses: jsonResponse({ schema: MyResponseSchema }),
  } satisfies IAuthRouteConfig,
} as const;
```

- Each entry uses `satisfies IAuthRouteConfig` for shape validation.
- The outer object ends with `as const` for literal-type preservation and IDE autocomplete.

## Controller

```typescript
const _Controller = ControllerFactory.defineCrudController({
  repository: { name: MyRepository.name },
  authenticate: { strategies: ['jwt', 'basic'] },
  authorize: { action: AuthorizationActions.READ, resource: MyEntityPermissions.FIND.code },
  controller: {
    name: 'MyEntityController',
    basePath: RestPaths.MY_ENTITIES,
    isStrict: { path: true, requestSchema: true },
  },
  entity: () => MyEntity,
  routes: { /* per-route authorize overrides */ },
});

@controller({ name: 'MyEntityController' })
export class MyEntityController extends _Controller {
  constructor(/* @inject params */) {
    super(_myRepository);
  }

  override binding(): ValueOrPromise<void> {
    // POST - /my-entities/custom
    this.bindRoute({ configs: MyEntityRoute.CUSTOM }).to({
      handler: async context => {
        const body = context.req.valid<TMyRequest>('json');
        const rs = await this._myService.customAction({ data: body });
        return useRequestContext(context, { rs });
      },
    });
  }
}
```

## Rules

- Pass `MyEntityRoute.X` **directly** to `configs:` — never spread (`{ ...MyEntityRoute.X }`). Spreading widens types to `IAuthRouteConfig` and breaks autocomplete on `path`/`method`.
- Above every `bindRoute(...)` call, write a one-line comment in the form `// METHOD - /full/path` (uppercase HTTP verb, full path including the controller's `basePath`). This makes the file scannable as an endpoint index.
- Cast each `MyEntityRoute` registry `as const` so the literal types of `method`, `path`, etc. survive into call sites.
- Every endpoint config must use `satisfies IAuthRouteConfig` to enforce the shape without losing literal types.
