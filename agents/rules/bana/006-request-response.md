# Request & Response Schemas

Request and response schemas live in dedicated files — never defined inline with `z` in `definitions.ts`.

## File Structure

```
models/
  requests/<entity>.request.ts
  responses/<entity>.response.ts
```

## request.ts

```typescript
import { z } from '@hono/zod-openapi';
import { MyEntityInsertSchema, MyEntityUpdateSchema } from '@nx/core';

// --------------------------------------------------------------------------------
export const CreateMyEntityRequest = MyEntityInsertSchema.omit({
  id: true, createdAt: true, modifiedAt: true, deletedAt: true,
}).extend({
  name: z.string().min(1).max(255).openapi({ example: 'My Entity' }),
  code: z.string().min(1).max(50).openapi({ example: 'ENT-001' }),
  tags: z.array(z.string()).min(1).max(20).optional(),
});
export type TCreateMyEntityRequest = z.infer<typeof CreateMyEntityRequest>;

// --------------------------------------------------------------------------------
export const UpdateMyEntityRequest = MyEntityUpdateSchema.omit({
  id: true,
}).extend({
  name: z.string().min(1).max(255).optional().openapi({ example: 'Updated Name' }),
});
export type TUpdateMyEntityRequest = z.infer<typeof UpdateMyEntityRequest>;
```

## response.ts

```typescript
import { z } from '@hono/zod-openapi';
import { MyEntitySelectSchema, RelatedEntitySelectSchema } from '@nx/core';

// --------------------------------------------------------------------------------
export const MyEntityResponse = MyEntitySelectSchema.partial().extend({
  relatedEntity: RelatedEntitySelectSchema.optional(),
});
export type TMyEntityResponse = z.infer<typeof MyEntityResponse>;

// - count-data compatible response (used with useCountData header)
export const MyEntityCountResponse = z.object({
  count: z.number(),
  data: MyEntityResponse,
});
```

## Usage in definitions.ts

```typescript
import { CreateMyEntityRequest } from '@/models/requests';
import { MyEntityResponse } from '@/models/responses';

// In route config:
request: {
  body: jsonContent({ description: 'CREATE | Request body', schema: CreateMyEntityRequest }),
},
responses: jsonResponse({
  schema: MyEntityResponse.or(z.object({ count: z.number(), data: MyEntityResponse })),
}),
```

## Controller handler (useCountData)

```typescript
handler: async context => {
  const body = context.req.valid<TCreateMyEntityRequest>('json');
  const requestCountData = context.req.header(HTTP.Headers.REQUEST_COUNT_DATA) ?? 'true';
  const useCountData = toBoolean(requestCountData);
  const rs = await this._myService.create({ data: body });
  if (useCountData) {
    return context.json({ data: rs, count: 1 }, HTTP.ResultCodes.RS_2.Ok);
  }
  return context.json(rs, HTTP.ResultCodes.RS_2.Ok);
},
```

## Rules

- Never define `z.object(...)` inline in `definitions.ts` — always import from `.request.ts` / `.response.ts`
- Request fields must have validation: `.min()`, `.max()`, `.nonempty()`, `.email()`, etc. as appropriate
- Request fields should have `.openapi({ example: '...' })` on non-obvious fields
- Response schema must support `useCountData` by using `.or(z.object({ count: z.number(), data: MySchema }))` in `jsonResponse()`
- Export a named type `T*Request` / `T*Response` via `z.infer<>` for every schema
