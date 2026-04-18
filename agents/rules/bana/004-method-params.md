# Method Parameters

Use `opts: {}` object pattern for method parameters.

## Examples

```typescript
// Service method
async updateById(opts: {
  id: IdType;
  data: Partial<TProduct>;
  transaction?: ITransaction<TAnyDataSourceSchema>;
}) {
  const { id, data, transaction } = opts;
  // ...
}

// Private method
private async _createItems(opts: {
  parentId: IdType;
  items: TItem[];
  transaction: ITransaction<TAnyDataSourceSchema>;
}) {
  const { parentId, items, transaction } = opts;
  // ...
}

// Simple single-purpose method — opts still preferred
async findByIdentifier(opts: { identifier: string; filter?: TFilter }) {
  const { identifier, filter } = opts;
  // ...
}
```

## Rules

- Name the parameter `opts` (not `params`, `args`, `input`)
- Destructure `opts` at function body start
- Inline the type (no separate interface unless reused)
- Optional fields use `?`
- `transaction?: ITransaction<TAnyDataSourceSchema>` is common optional field
