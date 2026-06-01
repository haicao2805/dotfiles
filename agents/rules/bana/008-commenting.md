# Commenting Style

## Rules

- Only comment when it adds value — skip obvious code
- **Write all code comments in English.** No Vietnamese (or other natural languages) in source files. This includes JSDoc blocks, inline `//` comments, TODO/FIXME notes, and header banners. User-facing strings (error messages, i18n keys, UI copy) follow their own localisation rules; this rule applies to developer-facing comments.
- **Field-level comments:** single-line → trailing `//` on the same line. Keep `/** */` JSDoc only when the comment needs multiple lines (3+ sentences, bullet lists, formulas). Avoid `/** */` just to describe one sentence on a type/interface/class-field.
- Use `-` divider lines to separate method blocks in services/controllers
- Never use `=` dividers — only `-`
- Two divider sizes: **80 dashes** for public methods, **50 dashes** for private methods

## Public Method Divider

Three-line block: divider, WHY comment, divider. Indented to class body (2 spaces).

```typescript
  // --------------------------------------------------------------------------------
  // Create reservation — validates units, persists rows, emits socket events.
  // --------------------------------------------------------------------------------
  @logged()
  async create(opts: { ... }) {
    ...
  }
```

- 85 chars total: `  // ` + 80 hyphens
- Middle comment states the WHY, not the WHAT (one line preferred, two at most)
- Place before every public method in a service or controller

## Private Method Divider

Single line, no wrapper comment. Directly above the method.

```typescript
  // --------------------------------------------------
  private async _assertFoo(opts: { ... }) {
    ...
  }
```

- 55 chars total: `  // ` + 50 hyphens
- Place before every private helper
- No comment on the divider line; if the private method needs explanation, put it as a normal `//` comment inside the body

## Method Ordering

- Private helpers **shared by multiple public methods** go immediately after the constructor, grouped under a `// Shared private methods` section header.
- Private helpers **used by only one public method** stay directly below that public method.

```typescript
export class MyService extends BaseService {
  constructor(...) { super(...); }

  // --------------------------------------------------------------------------------
  // Shared private methods
  // --------------------------------------------------------------------------------

  // --------------------------------------------------
  private _sharedHelper(opts: { ... }) { ... }

  // --------------------------------------------------------------------------------
  // Create entity — validates input, persists row, emits events.
  // --------------------------------------------------------------------------------
  @logged()
  async create(opts: { ... }) { ... }

  // --------------------------------------------------
  private async _assertCreateFoo(opts: { ... }) { ... }

  // --------------------------------------------------------------------------------
  // Update entity — validates ownership, applies patch, emits events.
  // --------------------------------------------------------------------------------
  @logged()
  async update(opts: { ... }) { ... }

  // --------------------------------------------------
  private async _assertUpdateFoo(opts: { ... }) { ... }
}
```

- The `// Shared private methods` section header uses the same 80-dash three-line format as public methods
- Only methods called from more than one public method belong in the shared section

### Thematic grouping (escape hatch)

When several private helpers form a tightly-related utility cluster (e.g. multiple Redis-key builders, multiple format helpers, multiple parsers), they may sit together under one thematic section header instead of being scattered by call site — even when only one public method calls each of them. The header uses the same 80-dash three-line block, with a middle line stating the group's shared purpose.

```typescript
  // --------------------------------------------------------------------------------
  // Redis key builders — namespaced lookup keys for OTP, lock, session, cooldown.
  // --------------------------------------------------------------------------------

  // --------------------------------------------------
  private _otpKey(opts: { ns: string; identifier: string }) { ... }

  // --------------------------------------------------
  private _lockKey(opts: { ns: string; identifier: string }) { ... }

  // --------------------------------------------------
  private _sessionKey(opts: { ns: string; token: string }) { ... }
```

Use this only when the group has a clear, single shared purpose. If the helpers are merely used in the same public method but unrelated in concept, place each one directly under its public method per the default rule.

## Valuable Comments

```typescript
// Priority 1: Try id field in Product table
// Fallback: retry with exponential backoff
// NOTE: This must run before transaction commit
```

## Field-level comments — inline vs JSDoc

Single-line comments go **after** the field, not before it. Only escalate to `/** */` when the comment genuinely needs multiple lines.

```typescript
// ✅ single-sentence field description — trailing inline
export type TInput = {
  traceId?: string;              // Distributed trace id for log correlation.
  productId: string;             // Product id used for TaxSet fallback.
  calculatingAt: string;         // ISO 8601 effective window anchor.
};

// ✅ class enum-style constants — trailing
export class PartyRoles {
  static readonly BUYER = '000_BUYER';   // Buyer in the transaction.
  static readonly SELLER = '100_SELLER'; // Seller in the transaction.
}

// ✅ Zod schema field — trailing
export const SnapshotSchema = z.object({
  v: z.literal(1),                        // Snapshot schema version.
  calculatedAt: z.iso.datetime(),         // ISO 8601 compute timestamp.
});

// ✅ multi-line → keep JSDoc
export const AppliedRuleSchema = z.object({
  /**
   * Parameter of the basis:
   *   basis=PERCENTAGE → percent value ("10" = 10%)
   *   basis=FIXED      → absolute amount
   *   basis=PER_UNIT   → per-unit amount
   */
  basisValue: MoneySchema,
});

// ❌ over-use of JSDoc for one-liner
export type TInput = {
  /** Trace id. */
  traceId?: string;
};
```

## Avoid

```typescript
// Get user by id          ← states the obvious
// Loop through items      ← describes syntax
// ======================== ← wrong divider (no `=`)
// ------------------------ ← wrong length (use 80 for public, 50 for private)
// Tính tổng tiền đơn hàng  ← wrong language (use English)
```
