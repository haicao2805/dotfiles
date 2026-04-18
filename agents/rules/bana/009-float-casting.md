# Float Casting

Use `float()` from `@venizia/ignis-helpers` for all numeric precision.

## Usage

```typescript
import { float } from '@venizia/ignis-helpers';

// 4-decimal precision for monetary/quantity calculations
const total = float(price * quantity, 4);
const discount = float(originalPrice, 4) - float(discountedPrice, 4);
const tax = float(subtotal * taxRate, 4);
```

## Rules

- Always use `float(value, 4)` — 4 decimals is the standard precision
- Apply on arithmetic results, not raw reads
- Never use raw `Number()`, `parseFloat()`, or `+value` for business calculations
- Wrap both operands when doing subtraction/comparison to avoid drift
