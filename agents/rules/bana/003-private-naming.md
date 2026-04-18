# Private Naming Convention

All private and protected class members use `_` prefix.

## Examples

```typescript
// Fields
private readonly _repository: MyRepository;
private _cachedValue: string;
protected _logger: ILogger;

// Methods
private async _processItem(opts: { item: TItem }) { ... }
private _validateInput(opts: { data: TData }) { ... }
protected _buildQuery(opts: { filter: TFilter }) { ... }
```

## Rules

- `_` prefix on all `private` and `protected` fields and methods
- `public` members never use `_` prefix
- Injected constructor params follow same rule: `private readonly _myService`
