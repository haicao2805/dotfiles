# Forms — React Hook Form + Zod

Forms use `react-hook-form` with a `zodResolver` over a schema from `@nx-app/core`. Edit screens
**load via `reset`** and **submit a diff**, not the whole form.

## Setup & load

```typescript
const methods = useForm<TProductFormValueClient>({
  resolver: zodResolver(productFormClientSchema),   // schema lives in @nx-app/core
  defaultValues: defaultProductFormValueClient,
});
const { control, handleSubmit, reset, formState: { dirtyFields, defaultValues } } = methods;

useWarnUnsavedChanges({ control });

// Edit: hydrate once the server data arrives. reset() also resets dirty state + defaultValues.
React.useEffect(() => {
  if (isLoading || !data) return;
  reset(mapServerToForm(data));
}, [isLoading, data, reset]);
```

- Map server → form in the `reset` payload; carry entity **`id`s** into the form values when the
  BE matches by id on save (so the submit diff can emit them).
- Dynamic lists use `useFieldArray` (with `keyName`); reference field paths through constants
  (e.g. `ProductPaths.VARIANTS`), never inline template strings scattered across components.
- Numeric inputs: normalise with `cleanNumericString` before sending.

## Submit a diff (not the whole form)

```typescript
const onSubmit = (data: TFormValue) => {
  const diff = getDirtyValues({ data, dirtyFields });   // object fields only — see pitfall
  const payload = { ...(diff.basicInfo && { ...mapBasic(diff.basicInfo) }) };
  // build child-entity ops explicitly (edit { id, ...changed } / delete { id } / create no id)
};
```

### Pitfall — `getDirtyValues` and arrays
`getDirtyValues` (`apps/core/src/helpers/react-hook-form.helper.ts`) returns the **entire array**
for any array-typed dirty field (`Array.isArray(value) → data[key]`) — it does **not** diff array
items. So:
- Use it for scalar/object fields.
- For arrays (variants, options, bundlers, …) diff each item **explicitly** against
  `formState.defaultValues` (the loaded snapshot), and push only changed items. Match items by
  `id`. Don't infer "changed" from `dirtyFields.<array>` truthiness.

## Rules
- `useForm` + `zodResolver(<*FormClientSchema from @nx-app/core>)`; `useWarnUnsavedChanges`.
- Edit screens hydrate with `reset(mapServerToForm(...))` in an effect; thread `id`s into form values.
- Submit a diff — only changed scalars/objects, and explicitly-diffed array items.
- Never trust `getDirtyValues` for arrays; diff array items against `defaultValues` by `id`.
- Field paths come from constants, not inline strings.
