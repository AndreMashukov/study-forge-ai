# Cursor Rules Documentation

Project-wide Cursor AI rules organized by category. Claude Code reads `CLAUDE.md` at the root and auto-loads path-scoped rules from `.claude/rules/`. These `.mdc` files provide equivalent file-scoped context for Cursor.

## Organization

```
.cursor/rules/
├── README.md                   # This file
├── api-patterns.mdc            # RTK Query + Firebase callable patterns
├── component-structure.mdc     # Page/container/component organization
├── form-handling.mdc           # React Hook Form + Zod
└── styling.mdc                 # Tailwind CSS 3 + shadcn/ui tokens
```

## Rule Files

### api-patterns.mdc
**Scope**: `web/src/store/api/**/*.ts`, `web/src/store/slices/**/*.ts`

RTK Query over Firebase callable functions, tag invalidation, shared types.

### component-structure.mdc
**Scope**: `web/src/components/**/*.{ts,tsx}`, `web/src/pages/**/*.{ts,tsx}`

Context-based page pattern, container components, naming conventions.

### form-handling.mdc
**Scope**: `web/src/pages/**/*.{ts,tsx}`, `web/src/components/**/Form*.tsx`

React Hook Form + Zod validation, form instance named `form`.

### styling.mdc
**Scope**: `web/src/**/*.{ts,tsx}`, `web/src/styles.css`

shadcn/ui + Tailwind CSS 3, design tokens, no MUI.

## Claude Code Parity

| Cursor rule | Claude rule |
|-------------|-------------|
| `api-patterns.mdc` | `.claude/rules/api-patterns.md` |
| `component-structure.mdc` | `.claude/rules/component-structure.md` |
| `form-handling.mdc` | `.claude/rules/form-handling.md` |
| `styling.mdc` | `.claude/rules/styling.md` |

Additional Claude-only rules: `typescript.md`, `firebase-functions.md`, `production-infra.md`

## Related Documentation

- [CLAUDE.md](../../CLAUDE.md) — Claude Code entry point
- [.claude/skills/](../../.claude/skills/) — Tool and knowledge skills
- [AGENTS.md](../../AGENTS.md) — Full project conventions
- [docs/architecture/](../../docs/architecture/) — Layer pattern templates
- [docs/prompts/](../../docs/prompts/) — Git workflow prompts
