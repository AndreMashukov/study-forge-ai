# GitHub PR Creation

**Input:** `@/docs/prompts/github-pr.md [optional-params]`

## Context Detection

1. **Branch Analysis**: Extract type and description from `<type>/<description>/<developer>` pattern
2. **Changes Analysis**: Review git diff for key modifications
3. **Target Branch**: Default to `main`

## Instructions

1. Analyze current branch and changes
2. Generate PR title and description
3. Push branch to remote
4. Create GitHub pull request
5. Return clickable PR link

## PR Title Format

`<type>: <description>`

Examples:

- `feat: add directory-centric document filter`
- `fix: resolve Firebase emulator CORS mismatch`
- `chore: update nx dependencies`

## PR Body Structure

- **What**: 1–2 sentences describing the change
- **Changes**: Key modifications made
- **Test plan**: Validation steps (typecheck, lint, manual emulator testing)

## Guidelines

- Use conventional commit types: feat, fix, chore, refactor, docs, test, ci
- Keep concise and focused
- Include NX validation commands run
- Link to relevant documentation in `docs/`

## Validation Checklist

```bash
NX_DAEMON=false NX_ISOLATE_PLUGINS=false yarn nx run web:typecheck
NX_DAEMON=false NX_ISOLATE_PLUGINS=false yarn nx run web:lint
NX_DAEMON=false NX_ISOLATE_PLUGINS=false yarn nx run web:build  # for merges
```
