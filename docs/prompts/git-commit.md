# Commit Message Generation and Execution

## Input Format

`@/docs/prompts/git-commit.md [optional-params]`

## Autonomous Context Detection

1. **Branch Context Detection**:
   - Extract branch type from current branch name (`<type>/<description>/<developer>`)
   - Use branch type as commit type prefix

2. **Scope Detection**:
   - Default to `staged` changes if available
   - Fall back to `modified` if no staged changes
   - Use operator-provided scope if specified

## Instructions

1. Detect branch context and scope autonomously
2. Check git diff for the determined scope
3. Analyze changed file names and diff content
4. Generate commit message using conventional commits format
5. Execute `git commit` with the generated message

## Commit Message Format

### REQUIRED: Detailed Multi-line Format (NEVER use 1-liner messages)

**❌ WRONG - Never use single line commits:**

```bash
git commit -m "fix: login issue"
```

**✅ CORRECT - Always use detailed multi-line format:**

```bash
git commit -m "fix: resolve login authentication failure

- Fix Firebase auth token sync in authSlice
- Add proper error handling for expired sessions
- Update login form to show specific error messages
- Run web:typecheck and web:lint before commit"
```

### REQUIRED: Clean World Standard Prefixes

**❌ WRONG - Never add anything to the prefix:**

```bash
git commit -m "fix(auth): authentication issue"
git commit -m "feat(web): new document filter"
```

**✅ CORRECT - Use clean standard prefixes only:**

```bash
git commit -m "fix: resolve login authentication failure"
git commit -m "feat: implement document directory filter"
```

### Branch to Commit Type Mapping

- `feat/*` branches → `feat:` commits
- `fix/*` branches → `fix:` commits
- `chore/*` branches → `chore:` commits
- `refactor/*` branches → `refactor:` commits
- `docs/*` branches → `docs:` commits
- `test/*` branches → `test:` commits
- `ci/*` branches → `ci:` commits
