# Sale Package Refactoring Plan

Deviations found in `packages/sale/` vs canonical style (commerce, identity, finance, inventory).

## Tasks (priority order)

### 🔴 CRITICAL

1. **application.ts method ordering** — move `configureComponents()` BEFORE `configureDatasources()` (currently at end, should be after `getAuthorizationRedisConnection`)
2. **Missing @logged() on services** — add `@logged()` to all public async business methods across 20 service files (sale has 1/99, commerce has 18/78, identity has 48/105)

### 🟠 MAJOR

3. **Model file naming** — rename `.model.ts` → `.request.ts`/`.response.ts` in `models/requests/` and `models/responses/`:
   - `requests/customer.model.ts` → `customer.request.ts`
   - `requests/sale.model.ts` → `sale.request.ts`
   - `requests/shift.model.ts` → `shift.request.ts`
   - `responses/sale.model.ts` → `sale.response.ts`
4. **Dead code removal**:
   - Delete `common/response.helper.ts` (3 unused functions)
   - Remove `export * from './response.helper'` from `common/index.ts`
   - Remove dead types (`TCountedResponse`, `TSingleResponse`, `TArrayResponse`) from `models/responses/sale.model.ts`
   - Delete empty `models/websocket.model.ts`

### 🟡 MODERATE

5. **Import ordering** — fix `shift.service.ts` and `components/websocket/socket-event.service.ts` (`@/` → `@nx` → `@venizia` → third-party)
6. **Private field naming** — rename `idGenerator` → `_idGenerator` in `sale.service.ts`

### ⏭️ SKIP

7. `index.ts export default` — monorepo-wide inconsistency, not sale-specific
