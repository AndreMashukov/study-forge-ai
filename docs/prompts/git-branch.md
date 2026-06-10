# Git Branch Creation

**Input:** `@/docs/prompts/git-branch.md [context]`

**Context:** Natural language description (e.g., "fix login bug", "add quiz filter")

**Developer:** Set your initials in `~/.claude/CLAUDE.md` (e.g., `am` for Andre Mashukov)

## Instructions

1. Checkout main and fetch latest changes
2. Analyze context to determine branch type
3. Generate branch name: `<type>/<description>/<developer>`
4. Create and checkout new branch

## ⚠️ LIMITATION: Branch creation only. No code changes.

## Branch Types

- `feat`: New features/enhancements
- `fix`: Bug fixes
- `chore`: Maintenance/updates
- `refactor`: Code restructuring
- `docs`: Documentation
- `test`: Testing
- `ci`: CI/CD

## Context Analysis

- **feat**: "add", "create", "implement", "new", "feature"
- **fix**: "fix", "bug", "issue", "error", "problem"
- **chore**: "update", "upgrade", "dependency", "config"
- **refactor**: "refactor", "optimize", "improve"
- **docs**: "docs", "documentation", "readme"
- **test**: "test", "testing", "spec"
- **ci**: "ci", "pipeline", "build", "deploy"

## Examples

- "fix login bug" → `fix/login-bug/am`
- "add quiz filter" → `feat/add-quiz-filter/am`
- "update nx dependencies" → `chore/update-nx-deps/am`

## Rules

- Kebab-case descriptions
- Imperative mood
- Strip prefixes ("please", "can you")
- Check branch doesn't exist

## Commands

```bash
git checkout main
git fetch origin
git checkout -b <branch-name>
```
