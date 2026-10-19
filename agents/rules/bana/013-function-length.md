# Function Length

A function or method stays under 200 lines. Longer bodies are split into named helpers before they ship.

## Rules

- Hard limit: 200 lines per function or method body
- Extract each coherent step into a named private helper — one responsibility per helper
- Helpers keep the reading order of the original body; name them after what they do, not where they came from
- When a body genuinely cannot be split without losing clarity, raise the exception with the human instead of shipping it oversized

## Examples

```typescript
// ❌ one 300-line body doing validation, calculation and persistence
async upsertOrder(opts: UpsertOrderOpts) {
  // 300 lines ...
}

// ✅ same work, each step a named unit
async upsertOrder(opts: UpsertOrderOpts) {
  const order = await this._validateOrder(opts);
  const totals = this._calculateTotals(order);
  return this._persistOrder({ order, totals, transaction: opts.transaction });
}
```
