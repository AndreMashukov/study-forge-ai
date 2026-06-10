# API Layer

RTK Query over Firebase callable functions. All endpoints inject into `baseApi` and share a common `firebaseCallableBaseQuery`.

## Quick Reference

| Pattern                       | Example                        | Purpose          |
| ----------------------------- | ------------------------------ | ---------------- |
| `{domain}Api`                 | `documentsApi`                 | Injected endpoints |
| `I{Domain}Api.ts`             | `IDocumentsApi.ts`             | Request/response types |
| `use{Action}{Entity}Query`    | `useGetDocumentQuery`          | Query hook       |
| `use{Action}{Entity}Mutation` | `useCreateDocumentMutation`    | Mutation hook    |

**Data flow:**

```
Web (RTK Query) → httpsCallable(functionName, data) → Firebase Function → Firestore/Storage/Gemini
```

## Templates

### Base API

All domain APIs inject into `web/src/store/api/baseApi.ts`:

```typescript
import { baseApi } from '../baseApi';

export const documentsApi = baseApi.injectEndpoints({
  endpoints: (builder) => ({
    // endpoints here
  }),
});

export const { useGetDocumentQuery, useCreateDocumentMutation } = documentsApi;
```

### Query Endpoint (callable GET)

```typescript
get{Entity}: builder.query<{Entity}, string>({
  query: (entityId) => ({
    functionName: 'get{Entity}',
    data: { entityId },
  }),
  transformResponse: (response: { success: boolean; {entity}: {Entity} }) => {
    return response.{entity};
  },
  providesTags: (_result, _error, entityId) => [
    { type: '{Entity}', id: entityId },
  ],
}),
```

### List Query Endpoint

```typescript
get{Entities}: builder.query<{Entities}ListResponse, void>({
  query: () => ({
    functionName: 'getUser{Entities}',
    data: { limit: 100 },
  }),
  transformResponse: (response: { success: boolean; {entities}: {Entity}[]; total: number }) => ({
    {entities}: response.{entities},
    total: response.total,
  }),
  providesTags: (result) =>
    result
      ? [
          ...result.{entities}.map(({ id }) => ({ type: '{Entity}' as const, id })),
          { type: '{Entity}', id: 'LIST' },
        ]
      : [{ type: '{Entity}', id: 'LIST' }],
}),
```

### Mutation Endpoint

```typescript
create{Entity}: builder.mutation<{Entity}, Create{Entity}Request>({
  query: (data) => ({
    functionName: 'create{Entity}',
    data,
  }),
  transformResponse: (response: { success: boolean; {entity}: {Entity} }) => {
    return response.{entity};
  },
  invalidatesTags: ['{Entity}', { type: '{Entity}', id: 'LIST' }],
}),
```

### Long-Running Functions

Pass a custom timeout for functions that exceed the default 70s deadline:

```typescript
generateContent: builder.mutation<GenerateResponse, GenerateRequest>({
  query: (data) => ({
    functionName: 'generateFromPrompt',
    data,
    timeout: 300_000,
  }),
  // ...
}),
```

## File Organization

```
web/src/store/api/
├── baseApi.ts              # createApi + firebaseCallableBaseQuery
├── {Domain}/
│   ├── {Domain}Api.ts      # injectEndpoints
│   └── I{Domain}Api.ts     # Local request/response interfaces (if needed)
└── utils/                  # Shared query helpers (onQueryStarted, etc.)
```

## Shared Types

Prefer types from `@shared-types` for cross-boundary contracts:

```typescript
import type { DocumentEnhanced, CreateDocumentRequest } from '@shared-types';
```

Add new shared types in `libs/shared-types/src/` when both `web` and `functions` need them.

## Best Practices

- One API file per domain (`DocumentsApi.ts`, `DirectoriesApi.ts`)
- Use `providesTags` / `invalidatesTags` for cache invalidation
- Keep `transformResponse` focused — unwrap `{ success, data }` envelopes
- Mutations belong in handler hooks, not in `useEffect`
- Never call `httpsCallable` directly from components — always go through RTK Query
