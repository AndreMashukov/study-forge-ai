---
name: firebase-hosting
description: Firebase Hosting production deployment — GitHub Actions, secrets, troubleshooting
---

# Firebase Hosting Deploy

## Workflow

`.github/workflows/firebase-hosting-merge.yml` runs on push to `main`:

1. Lint/test/typecheck affected projects
2. Build web with `NX_PUBLIC_*` secrets injected
3. Deploy via `FirebaseExtended/action-hosting-deploy@v0`

## Required GitHub Secrets

```
FIREBASE_SERVICE_ACCOUNT_CODE_INSIGHTS_QUIZ_AI
NX_PUBLIC_FIREBASE_API_KEY
NX_PUBLIC_FIREBASE_APP_ID
NX_PUBLIC_FIREBASE_AUTH_DOMAIN
NX_PUBLIC_FIREBASE_MESSAGING_SENDER_ID
NX_PUBLIC_FIREBASE_PROJECT_ID
NX_PUBLIC_FIREBASE_STORAGE_BUCKET
NX_PUBLIC_GEMINI_API_KEY
```

Verify with: `gh secret list`

## Common Errors

### `Input required: firebaseServiceAccount`

The workflow references a secret that doesn't exist. Must be exactly `FIREBASE_SERVICE_ACCOUNT_CODE_INSIGHTS_QUIZ_AI`.

### Build works locally but not in CI

CI injects secrets at build time. Missing `NX_PUBLIC_*` secrets → app falls back to demo Firebase config in `web/src/config/firebase.ts`.

### Wrong project deployed

`projectId` in the deploy step must use `secrets.NX_PUBLIC_FIREBASE_PROJECT_ID`, not a hardcoded value.

## Local Production Build Test

```bash
NX_DAEMON=false NX_ISOLATE_PLUGINS=false yarn nx run web:build --configuration=production
# Output: dist/web
```

## Reference

- `.claude/rules/production-infra.md`
- `.env.example`
