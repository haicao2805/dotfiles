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
};
```

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
    this.bindRoute({
      configs: { ...MyEntityRoute.CUSTOM },
    }).to({
      handler: async context => {
        const body = context.req.valid<TMyRequest>('json');
        const rs = await this._myService.customAction({ data: body });
        return useRequestContext(context, { rs });
      },
    });
  }
}
```
