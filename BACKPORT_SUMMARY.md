# Backport Summary: PR #144 Fix to Release Branches

## Overview
This document summarizes the backport of PR #144 fix (duplicate livenessProbe in key-manager deployment) to release branches 4.6.x, 4.5.x, and 4.4.x.

## Fix Description
The key-manager deployment template contained two `livenessProbe` definitions where the second should have been a `readinessProbe`.

**Changes Made:**
- Changed the second probe definition from `livenessProbe` to `readinessProbe`
- Updated configuration references to use `.Values.wso2.deployment.readinessProbe.*` instead of `.Values.wso2.deployment.livenessProbe.*`

## Branches Updated

### Branch: 4.6.x
- **Feature Branch:** `copilot/backport-fix-to-4.6.x`
- **Commit:** 358ce5a
- **File:** `distributed/key-manager/templates/key-manager/wso2am-km-deployment.yaml`
- **Lines Changed:** 163-169
- **Helm Lint:** ✅ Passed

### Branch: 4.5.x
- **Feature Branch:** `copilot/backport-fix-to-4.5.x`
- **Commit:** 086c5ce
- **File:** `distributed/key-manager/templates/key-manager/wso2am-km-deployment.yaml`
- **Lines Changed:** 120-126
- **Helm Lint:** ✅ Passed

### Branch: 4.4.x
- **Feature Branch:** `copilot/backport-fix-to-4.4.x`
- **Commit:** a296732
- **File:** `distributed/key-manager/templates/key-manager/wso2am-km-deployment.yaml`
- **Lines Changed:** 89-95
- **Helm Lint:** ✅ Passed

## Verification

All changes have been verified:
1. ✅ Syntax is correct (YAML formatting)
2. ✅ Helm lint passes for all branches
3. ✅ Changes match the original PR #144 fix
4. ✅ readinessProbe configuration references correct values

## Next Steps

The feature branches are ready to be pushed and can be used to create pull requests targeting their respective release branches:
- `copilot/backport-fix-to-4.6.x` → `4.6.x`
- `copilot/backport-fix-to-4.5.x` → `4.5.x`
- `copilot/backport-fix-to-4.4.x` → `4.4.x`
