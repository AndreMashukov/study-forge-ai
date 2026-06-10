# Code Insights AI

AI-powered study platform for documents, quizzes, flashcards, slide decks, and directory-centric learning workflows.

## Tech Stack

- NX monorepo: `web` (React 19 + Vite), `functions` (Firebase Functions v2), `shared-types`
- Redux Toolkit + RTK Query (Firebase callable functions)
- shadcn/ui + Radix UI + Tailwind CSS 3
- React Router DOM v6, React Hook Form + Zod
- Firebase Auth, Firestore, Storage, Functions emulators for local dev

> **Never use MUI.** Use shadcn/ui + Tailwind for all UI.

## Directory Structure

```
web/src/
├── components/    # Shared UI (ui/ = shadcn primitives)
├── pages/         # Feature pages (context-based pattern)
├── store/         # Redux slices + RTK Query APIs
├── types/         # Shared TypeScript types
├── hooks/         # Shared custom hooks
├── config/        # Firebase and app config
└── utils/         # Helpers (dateUtils, ProtectedRoute, etc.)

functions/src/     # Firebase callable functions
libs/shared-types/ # Shared types between web and functions

docs/
├── architecture/  # Layer patterns (API, state, hooks, components)
├── development-workflows/coding/  # Coding standards
└── prompts/       # Git workflow and review prompts
```

## Coding Guidelines

- Write senior-level code: maintainable, readable, not over-engineered
- Reuse existing patterns — read `AGENTS.md` and `docs/architecture/` before inventing new ones
- All web source lives in `web/src/`; run tasks via NX from workspace root
- Redux state: only serializable data (no Dates, Maps, Sets, class instances)
- Prefix unused variables with underscore

## Code Quality Rules (MUST follow on every task)

**Type Safety — avoid type assertions:**

- ❌ NEVER: `as any`, `as unknown`, `as Record<string, unknown>` — use type guards instead
- ❌ NEVER: `@ts-ignore`, `@ts-expect-error` — fix the actual type error
- ✅ USE: Type guards, discriminated unions, `z.infer` from Zod schemas

**UI — shadcn/ui only:**

- ❌ NEVER: MUI components or inline `<svg>` when Lucide icons exist
- ✅ USE: `web/src/components/ui/` primitives and Lucide React icons

**Tailwind — use design tokens:**

- ❌ NEVER: arbitrary values when a token exists (`text-[#8b5cf6]`)
- ✅ USE: CSS variable tokens from `web/src/styles.css` (`bg-primary`, `text-muted-foreground`)

**Before Writing Code — CHECK existing patterns:**

- Check `web/src/types/` and `@shared-types` before creating new types
- Check `web/src/components/` for similar components to reuse or extend
- Check `web/src/store/api/` for existing RTK Query endpoints

## Commands

```bash
# Web (always via NX from workspace root)
NX_DAEMON=false NX_ISOLATE_PLUGINS=false yarn nx run web:dev        # Dev server :4200
NX_DAEMON=false NX_ISOLATE_PLUGINS=false yarn nx run web:typecheck  # Type check
NX_DAEMON=false NX_ISOLATE_PLUGINS=false yarn nx run web:lint         # ESLint
NX_DAEMON=false NX_ISOLATE_PLUGINS=false yarn nx run web:build        # Production build

# Functions + emulators
NX_DAEMON=false NX_ISOLATE_PLUGINS=false yarn nx run functions:serve

# Seed test data (emulators must be running)
npx tsx scripts/seed-setup/setup-seed-data.ts
```

## Documentation

| Topic            | Location                                                                                                       |
| ---------------- | -------------------------------------------------------------------------------------------------------------- |
| Full conventions | [AGENTS.md](AGENTS.md)                                                                                         |
| API patterns     | [docs/architecture/api-layer.md](docs/architecture/api-layer.md)                                               |
| Redux state      | [docs/architecture/state-layer.md](docs/architecture/state-layer.md)                                           |
| Custom hooks     | [docs/architecture/hooks-layer.md](docs/architecture/hooks-layer.md)                                           |
| Components       | [docs/architecture/components-layer.md](docs/architecture/components-layer.md)                                 |
| Coding standards | [docs/development-workflows/coding/coding-standards.md](docs/development-workflows/coding/coding-standards.md) |

## Git Workflow

**Branch naming:** `<type>/<description>/<initials>`

- Types: feat, fix, docs, chore, refactor, test, ci
- Example: `feat/add-quiz-filter/am`
- Set your initials in `~/.claude/CLAUDE.md`

**Commits:** Multi-line conventional commits — see [docs/prompts/git-commit.md](docs/prompts/git-commit.md)

**PRs:** See [docs/prompts/github-pr.md](docs/prompts/github-pr.md)

**Code review:** See [docs/prompts/code-review.md](docs/prompts/code-review.md)

## Code Patterns

**Shared types:**

```typescript
import type { DocumentEnhanced } from '@shared-types';
```

**API naming:** `use<Action><Entity>Query/Mutation`

```typescript
useGetUserDocumentsQuery();
useCreateDocumentMutation();
```

**Page structure:** Page → Provider → Container (see AGENTS.md)

```typescript
export const DocumentsPage = () => (
  <ProtectedRoute>
    <DocumentsPageProvider>
      <DocumentsPageContainer />
    </DocumentsPageProvider>
  </ProtectedRoute>
);
```

## Environment

- Root `.env` — `NX_PUBLIC_*` vars for Vite (copy from `.env.example`)
- `web/.env` — Vite `import.meta.env` exposure
- `functions/.env` — `GEMINI_API_KEY`, `STORAGE_BUCKET` (copy from `functions/.env.example`)
- Local dev: set `NX_PUBLIC_USE_FIREBASE_EMULATOR=true`

**CRITICAL:** Emulator `--project` must match `NX_PUBLIC_FIREBASE_PROJECT_ID`.

## Post-Change Validation

Run in order, stop on first failure:

```bash
NX_DAEMON=false NX_ISOLATE_PLUGINS=false yarn nx run web:typecheck
NX_DAEMON=false NX_ISOLATE_PLUGINS=false yarn nx run web:lint
```

Run `web:build` for PRs and merges.
