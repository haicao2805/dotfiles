# Model Definition

Entity models use **three files**: `constants.ts` (enums/status classes), `schema.ts` (Drizzle table), and `model.ts` (entity class + types).
Location: `packages/core/src/models/schemas/<domain>/<entity>/`

## constants.ts — Enums & Status Classes

All domain-specific constants live here. Never define them inline in `schema.ts` or `model.ts`.

```typescript
import { Statuses, TConstValue } from '@venizia/ignis';

// -----------------------------------------------------------------------------
export class MyEntityStatuses {
  static readonly ACTIVATED = Statuses.ACTIVATED;
  static readonly DEACTIVATED = Statuses.DEACTIVATED;
  static readonly ARCHIVED = Statuses.ARCHIVED;

  static readonly SCHEME_SET = new Set([this.ACTIVATED, this.DEACTIVATED, this.ARCHIVED]);

  static isValid(scheme: string): boolean {
    return this.SCHEME_SET.has(scheme);
  }
}
export type TMyEntityStatus = TConstValue<typeof MyEntityStatuses>;

// -----------------------------------------------------------------------------
export class MyEntityTypes {
  static readonly TYPE_A = 'TYPE_A';
  static readonly TYPE_B = 'TYPE_B';

  static readonly SCHEME_SET = new Set([this.TYPE_A, this.TYPE_B]);

  static isValid(opts: { type: string }): boolean {
    return this.SCHEME_SET.has(opts.type);
  }
}
export type TMyEntityType = TConstValue<typeof MyEntityTypes>;
```

- Each constant class has a `SCHEME_SET` + `isValid()` method
- Each class exports a companion `T*` type via `TConstValue<typeof ...>`
- Use `Statuses.*` from `@venizia/ignis` for standard lifecycle values
- Separate classes by responsibility, divide with `// ---` comments

## schema.ts — Drizzle Table

```typescript
import { generateCommonColumnDefs, typed } from '../../common';
import { pgTable, text, unique, index } from 'drizzle-orm/pg-core';
import { MyEntityStatuses, TMyEntityStatus } from './constants';

const TABLE_NAME = 'MyEntity';

export const MyEntitySchema = pgTable(
  TABLE_NAME,
  {
    ...generateCommonColumnDefs(),
    name: text('name').notNull(),
    status: typed<TMyEntityStatus>({ name: 'status', default: MyEntityStatuses.ACTIVATED }),
  },
  def => [
    unique('UQ_MyEntity_name').on(def.name),
    index('IDX_MyEntity_status').on(def.status),
  ],
);
```

- Import constants from `./constants`, never define inline
- Use `typed<T>()` helper for constrained string columns

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

- Three files per entity: `constants.ts` → `schema.ts` → `model.ts`
- All enums/status values go in `constants.ts` — never inline in schema or model
- Each constant class must have `SCHEME_SET` + `isValid()` and a companion `TConstValue` type
- `@model()` decorator with `type: 'entity'`
- `hiddenProperties` always includes audit fields
- `defaultFilter` with `deletedAt: null` for soft-delete
- Export order: class → `T*Schema` → `T*PgRow` → `T*` → `T*Persist` → Zod schemas
- `TMyEntityPgRow = TSnakeCaseKeys<TTableObject<T*Schema>>` — raw PostgreSQL row type with snake_case keys
- `TMyEntity` extends with optional relation types when entity has relations
- Relations use `RelationTypes.ONE` / `RelationTypes.MANY` with schema references
