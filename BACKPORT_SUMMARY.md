# Backport Summary: PR #144 Fix to Release Branches

## Overview
This document summarizes the backport of PR #144 fix (duplicate livenessProbe in key-manager deployment) to release branches 4.6.x, 4.5.x, and 4.4.x.

## Fix Description
The key-manager deployment template contained two `livenessProbe` definitions where the second should have been a `readinessProbe`.

**Changes Made:**
- Changed the second probe definition from `livenessProbe` to `readinessProbe`
- Updated configuration references to use `.Values.wso2.deployment.readinessProbe.*` instead of `.Values.wso2.deployment.livenessProbe.*`

## Implementation Details

The fix has been prepared and tested for all three release branches. Local feature branches have been created with the necessary changes:

### Branch: 4.6.x
- **Local Feature Branch:** `copilot/backport-fix-to-4.6.x`
- **Base Branch:** `4.6.x` (commit: eb36edc)
- **Commit:** 358ce5a
- **File:** `distributed/key-manager/templates/key-manager/wso2am-km-deployment.yaml`
- **Lines Changed:** 163-169
- **Helm Lint:** ✅ Passed

### Branch: 4.5.x
- **Local Feature Branch:** `copilot/backport-fix-to-4.5.x`
- **Base Branch:** `4.5.x` (commit: a5ace5d)
- **Commit:** 086c5ce
- **File:** `distributed/key-manager/templates/key-manager/wso2am-km-deployment.yaml`
- **Lines Changed:** 120-126
- **Helm Lint:** ✅ Passed

### Branch: 4.4.x
- **Local Feature Branch:** `copilot/backport-fix-to-4.4.x`
- **Base Branch:** `4.4.x` (commit: 16c14e9)
- **Commit:** a296732
- **File:** `distributed/key-manager/templates/key-manager/wso2am-km-deployment.yaml`
- **Lines Changed:** 89-95
- **Helm Lint:** ✅ Passed

## Patch Files

To apply these changes, use the following patch commands for each branch:

### For 4.6.x:
```bash
git checkout 4.6.x
git cherry-pick 358ce5a
# Or apply the patch manually (see below)
```

### For 4.5.x:
```bash
git checkout 4.5.x
git cherry-pick 086c5ce
# Or apply the patch manually (see below)
```

### For 4.4.x:
```bash
git checkout 4.4.x
git cherry-pick a296732
# Or apply the patch manually (see below)
```

## Manual Patch (applicable to all branches)

In `distributed/key-manager/templates/key-manager/wso2am-km-deployment.yaml`, find the duplicate `livenessProbe` sections and change:

```yaml
        livenessProbe:
          httpGet:
              path: /services/Version
              port: {{ add 9763 .Values.wso2.apim.portOffset }}
          initialDelaySeconds: {{ .Values.wso2.deployment.livenessProbe.initialDelaySeconds }}
          periodSeconds: {{ .Values.wso2.deployment.livenessProbe.periodSeconds }}
          failureThreshold: {{ .Values.wso2.deployment.livenessProbe.failureThreshold }}
        livenessProbe:  # <-- This is the duplicate that needs to be changed
          httpGet:
              path: /services/Version
              port: {{ add 9763 .Values.wso2.apim.portOffset }}
          initialDelaySeconds: {{ .Values.wso2.deployment.livenessProbe.initialDelaySeconds }}
          periodSeconds: {{ .Values.wso2.deployment.livenessProbe.periodSeconds }}
          failureThreshold: {{ .Values.wso2.deployment.livenessProbe.failureThreshold }}
```

To:

```yaml
        livenessProbe:
          httpGet:
              path: /services/Version
              port: {{ add 9763 .Values.wso2.apim.portOffset }}
          initialDelaySeconds: {{ .Values.wso2.deployment.livenessProbe.initialDelaySeconds }}
          periodSeconds: {{ .Values.wso2.deployment.livenessProbe.periodSeconds }}
          failureThreshold: {{ .Values.wso2.deployment.livenessProbe.failureThreshold }}
        readinessProbe:  # <-- Changed from livenessProbe to readinessProbe
          httpGet:
              path: /services/Version
              port: {{ add 9763 .Values.wso2.apim.portOffset }}
          initialDelaySeconds: {{ .Values.wso2.deployment.readinessProbe.initialDelaySeconds }}  # <-- Changed reference
          periodSeconds: {{ .Values.wso2.deployment.readinessProbe.periodSeconds }}  # <-- Changed reference
          failureThreshold: {{ .Values.wso2.deployment.readinessProbe.failureThreshold }}  # <-- Changed reference
```

## Verification

All changes have been verified:
1. ✅ Syntax is correct (YAML formatting)
2. ✅ Helm lint passes for all branches
3. ✅ Changes match the original PR #144 fix
4. ✅ readinessProbe configuration references correct values
5. ✅ All three branches have been tested locally

## Next Steps

To complete the backport:
1. Push the local feature branches to remote (requires appropriate permissions)
2. Create pull requests for each branch:
   - `copilot/backport-fix-to-4.6.x` → `4.6.x`
   - `copilot/backport-fix-to-4.5.x` → `4.5.x`
   - `copilot/backport-fix-to-4.4.x` → `4.4.x`
3. Review and merge the PRs
