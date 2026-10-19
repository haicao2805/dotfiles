# API Service Pattern

REST access on the FE goes through a per-domain service class that extends
`BaseCrudApiService<TEntity, TPayload>`. Services live in the app under
`application/services/apis/<domain>/` and are bound as DI singletons in `application.ts`.

## Service class

```typescript
export class ProductApi extends BaseCrudApiService<IProduct, TProductPayload> {
  constructor(
    @inject({ key: CoreBindings.DEFAULT_REST_DATA_PROVIDER })
    protected dataProvider: IDataProvider,
  ) {
    super({ scope: ProductApi.name, dataProvider, resource: RestEndpoints.PRODUCT });
  }

  // --------------------------------------------------
  @api()
  async findAggregate(opts: { id: IdType; maxDepth?: number }): Promise<AnyType> {
    const { id, maxDepth } = opts;
    const resource = `${this.resource}/${id}/${RestEndpoints.AGGREGATE}`;
    const params: ISendParams = {
      method: RequestMethods.GET,
      // Guard optional query params so `undefined` is not serialized.
      ...(maxDepth !== undefined && { query: { maxDepth } }),
    };
    const response = await this.dataProvider.send<AnyType>({ resource, params });
    return response.data;
  }
}
```

- The base class already provides `find`, `findById`, `create`, `updateById`, `deleteById`,
  `search`, `count` — only add methods for custom endpoints.
- Every method is decorated with `@api()` (try/catch + error normalisation + tracking).
- Method params follow the `opts: {}` object pattern (see [004](./004-method-params.md)).
- Build the endpoint path from `this.resource` + `RestEndpoints.*` constants, never hardcode.
- Pass query params via `ISendParams.query`, body via `ISendParams.body`.

## Binding & resolving

- Bind new services in the app's `application.ts` DI container.
- Resolve in components with `useInjectable<ProductApi>({ key: 'services.ProductApi' })` — the
  key string `services.<ClassName>` is also the prefix of its React-Query cache keys.

## Rules
- One service class per domain, extending `BaseCrudApiService`; reuse base CRUD, don't reimplement.
- Every method `@api()`-decorated and `opts`-shaped.
- Guard optional query params (`...(x !== undefined && { query: { x } })`).
- Endpoint paths from `RestEndpoints.*`; never inline URL strings.
- Bind in `application.ts`; resolve via `useInjectable` by `services.<ClassName>`.
