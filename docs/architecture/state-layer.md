# State Layer

Redux Toolkit slices for UI state, page state, and auth. RTK Query manages server data — do not duplicate API data in slices.

## Quick Reference

| Pattern            | Example                  | Purpose          |
| ------------------ | ------------------------ | ---------------- |
| `{feature}Slice`   | `authSlice`              | Slice definition |
| `select{Field}`    | `selectIsAuthenticated`  | Selector         |
| `set{Feature}`     | `setUser`                | Action creator   |

**Slice categories:**

| Category     | Examples                          | Persisted |
| ------------ | --------------------------------- | --------- |
| Auth         | `authSlice`                       | Yes       |
| UI           | `uiSlice`                         | Partial   |
| Page-level   | `documentsPageSlice`, etc.        | No        |

## Templates

### Basic Slice

```typescript
import { createSlice, type PayloadAction } from '@reduxjs/toolkit';
import type { RootState } from '../index';

interface I{Feature}State {
  data: {DataType} | null;
  isLoaded: boolean;
}

const initialState: I{Feature}State = {
  data: null,
  isLoaded: false,
};

const {feature}Slice = createSlice({
  name: '{feature}',
  initialState,
  reducers: {
    set{Feature}: (state, action: PayloadAction<{DataType}>) => {
      state.data = action.payload;
      state.isLoaded = true;
    },
    clear{Feature}: (state) => {
      state.data = null;
      state.isLoaded = false;
    },
  },
});

export const { set{Feature}, clear{Feature} } = {feature}Slice.actions;
export default {feature}Slice.reducer;
```

### Selectors

```typescript
export const select{Feature} = (state: RootState) => state.{feature}.data;
export const selectIs{Feature}Loaded = (state: RootState) => state.{feature}.isLoaded;
```

### Syncing RTK Query into Slice (when needed)

```typescript
extraReducers: (builder) => {
  builder.addMatcher(
    documentsApi.endpoints.getDocument.matchFulfilled,
    (state, action) => {
      state.activeDocumentId = action.payload.id;
    },
  );
},
```

## File Organization

```
web/src/store/
├── index.ts           # configureStore + persist config
├── api/               # RTK Query (see api-layer.md)
└── slices/
    ├── authSlice.ts
    ├── uiSlice.ts
    └── {feature}PageSlice.ts
```

## Best Practices

- Redux slices hold UI/domain state only — not fetched API payloads
- Access state with `useSelector` in components/hooks, not via prop drilling
- Page slices live alongside their feature (`documentsPageSlice` for DocumentsPage)
- Guard `localStorage` access: `typeof window !== 'undefined'`
- Only serializable values in Redux (no `Date`, `Map`, `Set`, class instances)
- Auth state syncs from Firebase via `react-firebase-hooks` + `authSlice`
