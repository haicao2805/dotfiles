# Model Definition

Entity models use two files: `schema.ts` (Drizzle table) and `model.ts` (entity class + types).
Location: `packages/core/src/models/schemas/<domain>/<entity>/`

## schema.ts — Drizzle Table

```typescript
import { generateCommonColumnDefs } from '../../common';
import { Statuses, TConstValue } from '@venizia/ignis';
import { pgTable, text, unique, index } from 'drizzle-orm/pg-core';

const TABLE_NAME = 'MyEntity';

export const MyEntitySchema = pgTable(
  TABLE_NAME,
  {
    ...generateCommonColumnDefs(),
    name: text('name').notNull(),
    status: text('status').notNull().default(Statuses.ACTIVATED),
  },
  def => [
    unique('UQ_MyEntity_name').on(def.name),
    index('IDX_MyEntity_status').on(def.status),
  ],
);
```

## model.ts — Entity Class + Types

```typescript
import { BaseEntity, model, TRelationConfig, TTableInsert, TTableObject } from '@venizia/ignis';
import { createInsertSchema, createSelectSchema, createUpdateSchema } from 'drizzle-zod';
import { TSnakeCaseKeys } from '@/utilities';
import { MyEntitySchema } from './schema';

@model({
  type: 'entity',
  settings: {
    hiddenProperties: ['createdAt', 'modifiedAt', 'deletedAt'],
    defaultFilter: { where: { deletedAt: null } },
    authorize: { principal: 'MyEntity' },
  },
})
export class MyEntity extends BaseEntity<typeof MyEntitySchema> {
  static override TABLE_NAME = 'MyEntity';
  static override schema = MyEntitySchema;
  static override relations = (): TRelationConfig[] => [];
}

export type TMyEntitySchema = typeof MyEntitySchema;
export type TMyEntityPgRow = TSnakeCaseKeys<TTableObject<TMyEntitySchema>>;
export type TMyEntity = TTableObject<TMyEntitySchema>;
export type TMyEntityPersist = TTableInsert<TMyEntitySchema>;

export const MyEntitySelectSchema = createSelectSchema(MyEntitySchema);
export const MyEntityInsertSchema = createInsertSchema(MyEntitySchema).omit({
  id: true, createdAt: true, modifiedAt: true, deletedAt: true,
});
export const MyEntityUpdateSchema = createUpdateSchema(MyEntitySchema).omit({
  id: true, createdAt: true, modifiedAt: true, deletedAt: true,
});
```

## Rules

- `@model()` decorator with `type: 'entity'`
- `hiddenProperties` always includes audit fields
- `defaultFilter` with `deletedAt: null` for soft-delete
- Export order: class → `T*Schema` → `T*PgRow` → `T*` → `T*Persist` → Zod schemas
- `TMyEntityPgRow = TSnakeCaseKeys<TTableObject<T*Schema>>` — raw PostgreSQL row type with snake_case keys
- `TMyEntity` extends with optional relation types when entity has relations
- Relations use `RelationTypes.ONE` / `RelationTypes.MANY` with schema references
