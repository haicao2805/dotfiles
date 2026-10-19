# Data Fetching & Mutations

Server state is owned by **TanStack React Query** via the app hooks `useGetData`,
`useInfiniteGetData`, and `useMutationData` — never call an API service directly in a component
or hold server data in Redux. Redux is for UI/workspace state only.

## Read

```typescript
const { data: product, isLoading } = useGetData<IProduct>({
  apiKey: `services.ProductApi.findById`,         // cache-key base = service method
  queryParams: { id, filter: { include: [...] } }, // scopes the cache key
  queryFn: (params) => productApi.findById(params),
  queryOptions: { enabled: !!id },                 // gate until inputs are ready
});
```

- `apiKey` is the React-Query key base; `queryParams` are folded into the key, so two different
  param sets cache separately. Trim `queryParams` to what the call actually needs (smaller payload
  + tighter cache).
- Always gate dependent queries with `queryOptions.enabled`.

## Write

```typescript
const [update, { isLoading }] = useMutationData();

update({
  fn: () => productApi.editAggregate({ id, data: payload }),
  options: {
    onSuccess: () => { notify('ra.notification.updated', { type: 'success' }); reset(); },
    onSettled: () => {
      queryClient.invalidateQueries({ queryKey: ['services.ProductApi.find'] });
      queryClient.invalidateQueries({ queryKey: ['services.ProductApi.findById'] });
    },
  },
});
```

- Invalidate every affected query key in `onSettled` (list, count, detail, sub-resources).
- Chain dependent mutations (upload → delete → update) via nested callbacks rather than awaiting
  in series inside the component.

## Rules
- Read via `useGetData` / `useInfiniteGetData`, write via `useMutationData` — never call services
  ad-hoc in render, never store server data in Redux.
- Gate queries with `enabled`; keep `queryParams` minimal.
- Invalidate all impacted query keys in `onSettled` after a mutation.
- Client config is `gcTime: 0`, `staleTime: 10s`, no retry — don't rely on long caching.
