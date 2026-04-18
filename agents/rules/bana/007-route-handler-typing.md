# Route Handler Typing

Applies **only** to methods bound via decorators (`@get`, `@post`, `@patch`, `@delete`).
Does **not** apply to inline handlers inside `bindRoute().to({ handler: async context => {...} })`.

## Decorator-bound method (correct)

```typescript
import { Env } from 'hono';
import { TypedResponse } from 'hono';
import { type TRouteContext } from '@venizia/ignis';

@get({ configs: MyRoutes.FIND })
async findItems(context: TRouteContext<Env>): Promise<Response & TypedResponse> {
  const data = await this._myService.findAll();
  const { formatArrayResponse } = useRequestContext();
  return formatArrayResponse({ data, count: data.length });
}

@post({ configs: MyRoutes.CREATE })
async createItem(context: TRouteContext<Env>): Promise<Response & TypedResponse> {
  const body = context.req.valid<TCreateMyRequest>('json');
  const rs = await this._myService.create({ data: body });
  return context.json(rs, HTTP.ResultCodes.RS_2.Created);
}
```

## bindRoute().to() handler (no annotation needed)

```typescript
override binding(): ValueOrPromise<void> {
  this.bindRoute({
    configs: { ...MyRoutes.CUSTOM },
  }).to({
    handler: async context => {
      const body = context.req.valid<TMyRequest>('json');
      const rs = await this._myService.customAction({ data: body });
      return useRequestContext(context, { rs });
    },
  });
}
```

## Rules

- Decorator methods: always type as `context: TRouteContext<Env>` and return `Promise<Response & TypedResponse>`
- `bindRoute().to()` inline handlers: plain arrow function, no explicit typing required
- Import `Env` from `'hono'` and `TypedResponse` from `'hono'`
