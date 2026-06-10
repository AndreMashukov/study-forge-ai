# Hooks Layer

Custom React hooks bridging API/state layers to components. Page-specific hooks live in the page's `context/hooks/` directory.

## Quick Reference

| Pattern                  | Example                      | Purpose        |
| ------------------------ | ---------------------------- | -------------- |
| `use{Entity}`            | `useDocumentsPageContext`    | Data/context   |
| `use{Feature}Handlers`   | `useDocumentsPageHandlers`   | Mutations/nav  |
| `use{Feature}Effects`    | `useDocumentsPageEffects`      | Side effects   |
| `useFetch{Feature}Data`  | `useFetchDocumentsPageData`    | RTK Query fetch|

**Locations:**

| Location                                      | When to Use                       |
| --------------------------------------------- | --------------------------------- |
| `web/src/hooks/`                              | Shared across multiple pages      |
| `web/src/pages/{Page}/context/hooks/`         | Page-specific                     |
| `web/src/pages/{Page}/context/hooks/api/`     | RTK Query + fetch `useEffect`     |

## Page Hook Architecture

Context-based pages split hooks by responsibility:

1. **API hooks** (`context/hooks/api/`) — RTK Query calls and fetch-related `useEffect`
2. **Handler hooks** (`use{Page}Handlers`) — mutations, navigation; no `useEffect`
3. **Effect hooks** (`use{Page}Effects`) — non-fetch `useEffect` only
4. **Context hook** (`use{Page}Context`) — typed context accessor

**Providers orchestrate hooks only — no business logic, no `useState`/`useSelector`/`useEffect` directly in providers.**

## Templates

### Context Hook

```typescript
import { useContext } from 'react';
import { DocumentsPageContext } from '../DocumentsPageContext';
import type { IDocumentsPageContext } from '../../types/IDocumentsPageContext';

export const useDocumentsPageContext = (): IDocumentsPageContext => {
  const context = useContext(DocumentsPageContext);
  if (!context) {
    throw new Error('useDocumentsPageContext must be used within DocumentsPageProvider');
  }
  return context;
};
```

### Handler Hook

```typescript
import { useNavigate } from 'react-router-dom';
import { useCreateDocumentMutation } from '../../../store/api/Documents/DocumentsApi';

export const useDocumentsPageHandlers = () => {
  const navigate = useNavigate();
  const [createDocument, { isLoading }] = useCreateDocumentMutation();

  const handleCreateDocument = async (data: CreateDocumentRequest) => {
    const result = await createDocument(data).unwrap();
    navigate(`/documents/${result.id}`);
  };

  return { handleCreateDocument, isCreating: isLoading };
};
```

### API Fetch Hook

```typescript
import { useEffect } from 'react';
import { useGetUserDocumentsQuery } from '../../../store/api/Documents/DocumentsApi';

export const useFetchDocumentsPageData = (userId: string | undefined) => {
  const { data, isLoading, error, refetch } = useGetUserDocumentsQuery(undefined, {
    skip: !userId,
  });

  useEffect(() => {
    if (userId) refetch();
  }, [userId, refetch]);

  return { documents: data?.documents ?? [], isLoading, error };
};
```

## Best Practices

- Never call hooks conditionally
- Use RTK Query `skip` option instead of conditional hook invocation
- Type return shapes explicitly in handler/context interfaces
- Handler hooks own mutations and navigation — not effects
- Shared hooks go in `web/src/hooks/`; page-specific hooks stay co-located
