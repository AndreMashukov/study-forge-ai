# Coding Standards

ESLint 9 + Prettier + TypeScript strict mode. NX enforces module boundaries.

## Rules

**ESLint:**

- React Hooks rules enforced
- NX module boundary rules enforced (`@nx/enforce-module-boundaries`)
- Run via `yarn nx run web:lint` — never call eslint directly

**TypeScript:**

- `strict: true`
- Prefix unused params with underscore: `_unused`
- Prefer interfaces (prefix `I`) for props and data structures
- API response types suffix with `Api` when local to web

**Formatting:**

- 2-space indentation
- Run Prettier before committing

## Imports

No path aliases except `@shared-types`. Use relative imports within `web/src/`:

```typescript
// Shared types
import type { DocumentEnhanced } from '@shared-types';

// Internal (relative)
import { Button } from '../../components/ui/button';
import { useGetDocumentQuery } from '../../store/api/Documents/DocumentsApi';
```

## Import Order

```typescript
// 1. React/external
import { useState } from 'react';
import { useSelector } from 'react-redux';
import { useNavigate } from 'react-router-dom';

// 2. Shared types
import type { DocumentEnhanced } from '@shared-types';

// 3. Internal (components, store, hooks, utils)
import { Button } from '../../components/ui/button';
import { useGetDocumentQuery } from '../../store/api/Documents/DocumentsApi';

// 4. Local/relative (same feature)
import { DocumentCard } from './DocumentCard';
import type { IDocumentCard } from './IDocumentCard';
```

## File Naming

| Type       | Convention              | Example                    |
| ---------- | ----------------------- | -------------------------- |
| Components | PascalCase              | `DocumentCard.tsx`         |
| Hooks      | camelCase, `use` prefix | `useDocumentsPageHandlers.ts` |
| Utils      | camelCase               | `dateUtils.ts`             |
| Types      | PascalCase, `I` prefix  | `IDocumentCard.ts`         |
| API        | PascalCase + suffix     | `DocumentsApi.ts`          |
| Slices     | camelCase + Slice       | `authSlice.ts`             |

## Component Structure

```typescript
// 1. Imports (external → shared-types → internal → local)
// 2. Component: hooks → handlers → early returns → render
export const DocumentCard = ({ document }: IDocumentCard) => {
  const navigate = useNavigate();

  const handleClick = () => navigate(`/documents/${document.id}`);

  if (!document.title) return null;

  return (
    <Card onClick={handleClick}>
      <CardTitle>{document.title}</CardTitle>
    </Card>
  );
};
```

## NX Task Execution

Always run from workspace root via NX:

```bash
NX_DAEMON=false NX_ISOLATE_PLUGINS=false yarn nx run web:typecheck
NX_DAEMON=false NX_ISOLATE_PLUGINS=false yarn nx run web:lint
NX_DAEMON=false NX_ISOLATE_PLUGINS=false yarn nx run web:build
NX_DAEMON=false NX_ISOLATE_PLUGINS=false yarn nx run functions:lint
```

## Dependency Management

Install all packages at workspace root: `yarn add package-name`
