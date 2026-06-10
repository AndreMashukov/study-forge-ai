---
name: check
description: Run typecheck and lint without modifying files. Use when validating changes, before commits, or when the user asks to check code quality.
allowed-tools: Bash
effort: high
argument-hint: [project or path]
---

# Check Skill

## Usage

- `/check` — typecheck + lint all affected projects (matches CI)
- `/check web` — web project only
- `/check functions` — functions project only

## Instructions

When invoked, always use NX with daemon/plugin isolation disabled:

```bash
NX_DAEMON=false NX_ISOLATE_PLUGINS=false
```

1. **TypeScript type check** (always run first):
   ```bash
   NX_DAEMON=false NX_ISOLATE_PLUGINS=false yarn nx run web:typecheck
   ```
   If `$ARGUMENTS` is `functions`, run `functions:build` instead (no dedicated typecheck target).

2. **ESLint:**
   - With `web` argument: `yarn nx run web:lint`
   - With `functions` argument: `yarn nx run functions:lint`
   - Without arguments: `yarn nx run web:lint` then `yarn nx run functions:lint`

3. **Report results:**
   - All pass → confirm ready for commit/PR
   - Failures → list errors with file paths; stop on first failure when running full suite

## CI Parity

Production deploy workflow also runs `web:build`. For PR-ready validation:

```bash
NX_DAEMON=false NX_ISOLATE_PLUGINS=false yarn nx run web:build
```
