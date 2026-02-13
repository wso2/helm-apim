# How to Apply the Backport Fixes

This directory contains patch files for backporting the PR #144 fix to release branches 4.6.x, 4.5.x, and 4.4.x.

## Option 1: Using Local Branches (Recommended)

If you have access to the repository with the local branches still available:

```bash
# For 4.6.x
git push origin copilot/backport-fix-to-4.6.x

# For 4.5.x
git push origin copilot/backport-fix-to-4.5.x

# For 4.4.x
git push origin copilot/backport-fix-to-4.4.x
```

Then create PRs through the GitHub interface:
- `copilot/backport-fix-to-4.6.x` → `4.6.x`
- `copilot/backport-fix-to-4.5.x` → `4.5.x`
- `copilot/backport-fix-to-4.4.x` → `4.4.x`

## Option 2: Using Patch Files

If the local branches are not available, you can apply the patches directly:

### For 4.6.x:
```bash
git checkout 4.6.x
git checkout -b fix/backport-pr144-to-4.6.x
git apply patches/fix-duplicate-livenessprobe-4.6.x.patch
git add .
git commit -m "Fix duplicate livenessProbe in key-manager deployment

Backport of PR #144 fix to 4.6.x branch"
git push origin fix/backport-pr144-to-4.6.x
```

### For 4.5.x:
```bash
git checkout 4.5.x
git checkout -b fix/backport-pr144-to-4.5.x
git apply patches/fix-duplicate-livenessprobe-4.5.x.patch
git add .
git commit -m "Fix duplicate livenessProbe in key-manager deployment

Backport of PR #144 fix to 4.5.x branch"
git push origin fix/backport-pr144-to-4.5.x
```

### For 4.4.x:
```bash
git checkout 4.4.x
git checkout -b fix/backport-pr144-to-4.4.x
git apply patches/fix-duplicate-livenessprobe-4.4.x.patch
git add .
git commit -m "Fix duplicate livenessProbe in key-manager deployment

Backport of PR #144 fix to 4.4.x branch"
git push origin fix/backport-pr144-to-4.4.x
```

## Option 3: Manual Application

See [BACKPORT_SUMMARY.md](../BACKPORT_SUMMARY.md) for detailed instructions on manually applying the fix.

## Verification

After applying the patches, verify with:
```bash
helm lint distributed/key-manager
```

All patches have been pre-verified and pass helm lint checks.
