# Commenting Style

## Rules

- Only comment when it adds value — skip obvious code
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

## Valuable Comments

```typescript
// Priority 1: Try id field in Product table
// Fallback: retry with exponential backoff
// NOTE: This must run before transaction commit
```

## Avoid

```typescript
// Get user by id          ← states the obvious
// Loop through items      ← describes syntax
// ======================== ← wrong divider (no `=`)
// ------------------------ ← wrong length (use 80 for public, 50 for private)
```
