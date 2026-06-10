# Components Layer

Reusable UI built with shadcn/ui (Radix primitives), styled with Tailwind CSS 3 and `cn()` from `web/src/lib/utils.ts`.

## Quick Reference

| Category | Examples                          | Location                              |
| -------- | --------------------------------- | ------------------------------------- |
| Primitives | Button, Card, Input, Dialog     | `web/src/components/ui/`              |
| Shared   | Sidebar, ErrorBoundary            | `web/src/components/`                 |
| Page     | DocumentsList, QuizQuestion       | `web/src/pages/{Page}/{Container}/`   |

**Styling stack:**

| Technology   | Purpose               |
| ------------ | --------------------- |
| Radix UI     | Accessible primitives |
| Tailwind CSS | Utility styling       |
| `cn()`       | Class merging         |
| Lucide React | Icons                 |

## Folder Structure

### Shared Component

```
web/src/components/ComponentName/
├── index.ts
├── ComponentName.tsx
├── IComponentName.ts          # Props interface (prefix with I)
└── ComponentName.styles.ts    # Tailwind/CVA style constants (when needed)
```

### Page Container Component

```
web/src/pages/FeaturePage/FeaturePageContainer/
├── index.ts
├── FeaturePagePageContainer.tsx
└── SubComponent/
    ├── index.ts
    ├── SubComponent.tsx
    └── ISubComponent.ts
```

## Templates

### Component with Props

```typescript
import { cn } from '../../lib/utils';
import type { IComponentName } from './IComponentName';

export const ComponentName = ({ title, className }: IComponentName) => {
  return (
    <div className={cn('rounded-lg bg-card p-4', className)}>
      {title}
    </div>
  );
};
```

### shadcn/ui Usage

```typescript
import { Button } from '../ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '../ui/card';

export const ExampleCard = () => (
  <Card>
    <CardHeader>
      <CardTitle>Title</CardTitle>
    </CardHeader>
    <CardContent>
      <Button variant="default" size="sm">Action</Button>
    </CardContent>
  </Card>
);
```

## Page Structure

```typescript
// FeaturePage.tsx
export const FeaturePage = () => (
  <ProtectedRoute>
    <FeaturePageProvider>
      <FeaturePageContainer />
    </FeaturePageProvider>
  </ProtectedRoute>
);
```

## Best Practices

- Named exports for all components
- Functional components only (except `ErrorBoundary`)
- Props interfaces in `I{Component}.ts` for complex types
- Use early returns for loading/error states in containers
- Access Redux with `useSelector` directly — do not thread via props
- Write accessible markup with proper ARIA labels
- Date formatting via `web/src/utils/dateUtils.ts` only
- Never use MUI — use shadcn/ui + Tailwind

## Design Tokens

CSS custom properties in `web/src/styles.css`:

```css
--background: 0 0 0;
--foreground: 255 255 255;
--primary: 139 92 246;
--accent: 34 197 94;
--muted: 39 39 42;
--destructive: 239 68 68;
--border: 39 39 42;
--radius: 0.75rem;
```

Use Tailwind classes that map to tokens: `bg-background`, `text-foreground`, `bg-primary`, etc.
