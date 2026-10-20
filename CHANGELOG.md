# Changelog

All notable changes to the WSO2 API Manager Helm charts are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
All charts in this repository (`all-in-one` and the `distributed` charts: control-plane,
gateway, key-manager, traffic-manager) share a single version. Versions follow the
`<apimVersion>-<chartRevision>` scheme (e.g. `4.7.0-1`).

## [Unreleased]

### Added
- `oauth_config.authHeader`, `oauth_config.enableOutboundAuthHeader`, and `cors` configurations
  to the distributed control-plane chart, aligning it with the all-in-one and gateway charts
  and the 4.7.0 control-plane pack defaults ([#270]).
- `wso2.apim.configurations.internalHostname` to the all-in-one, control-plane and key-manager
  charts. It sets `[server] internal_hostname` and, when `wso2.apim.mountFrontendConfig` is enabled,
  `app.origin.host` of the Publisher, Developer Portal and Admin Portal `settings.json` files, so
  internal (loopback) calls work when the TLS certificate is not valid for `localhost`.
- `kubernetes.hostAliases` to all charts to add Pod `hostAliases` entries, e.g. to resolve the
  internal hostname to the pod itself.
- `wso2.apim.configurations.security.clientAuth.appPassword` / `appPasswordHash` and
  `wso2.apim.configurations.existingSecret.appPasswordKey` / `appPasswordHashKey` to all charts to
  replace the default internal client authentication credentials, which removes the
  WSO2-2023-2617 default credentials warning at startup. The hash is derived from a plain-text
  password. The chart fails to render when a plain-text password and hash do not match, when
  only one of them is provided, or when `extraConfigs` also defines the generated tables.

### Docs
- Regenerated helm-docs for all charts.

## [4.7.0-2]

### Added
- `runAsGroup` to distributed chart security contexts ([#243]).
- `automountServiceAccountToken` to deployments ([#241]).
- `imagePullSecrets.name` to reference existing registry secrets, with inline docs in default_values.
- `authType` and `azureUmiScope` fields to the `embeddingProvider` section ([#240]).

### Changed
- Updated default values for OpenShift ([#232]).
- `server_role` set to `default` for gateway and traffic-manager distributed
  configs, aligning with the product distribution ([#247]).

### Docs
- Regenerated helm-docs for all-in-one and distributed charts.

## [4.7.0-1]

### Added
- Configurable transport HTTP and HTTPS ports ([#213]).
- `image.tag` support; `tag`/`digest` made optional in deployment templates ([#191]).
- Multiple client secret configs in all-in-one charts.
- Multiple token, legacy API key, and token persistence configs across deployment patterns.
- Templated configs for on-demand tenant loading and distributed throttling SSL.
- Symmetric encryption key (AES256) configuration support with validation ([#169], [#172], [#175]).
- Early namespace creation in install flow.

### Changed
- Removed DB configs from Traffic Manager and Gateway nodes; moved database section
  conditional check to the top (TM, GW).
- Replaced deprecated `serviceAccount` key with `serviceAccountName` ([#194]).

### Fixed
- mTLS configuration for OpenShift ([#171]).
- OAuth header config.
- Consistency issue with `sync_runtime_artifacts`.

[Unreleased]: https://github.com/wso2/helm-apim/compare/all-in-one-4.7.0-2...HEAD
[4.7.0-2]: https://github.com/wso2/helm-apim/compare/all-in-one-4.7.0-1...all-in-one-4.7.0-2
[4.7.0-1]: https://github.com/wso2/helm-apim/compare/all-in-one-4.6.0-4...all-in-one-4.7.0-1

[#191]: https://github.com/wso2/helm-apim/pull/191
[#194]: https://github.com/wso2/helm-apim/pull/194
[#213]: https://github.com/wso2/helm-apim/pull/213
[#232]: https://github.com/wso2/helm-apim/pull/232
[#247]: https://github.com/wso2/helm-apim/pull/247
[#240]: https://github.com/wso2/helm-apim/pull/240
[#241]: https://github.com/wso2/helm-apim/pull/241
[#243]: https://github.com/wso2/helm-apim/pull/243
[#169]: https://github.com/wso2/helm-apim/pull/169
[#171]: https://github.com/wso2/helm-apim/pull/171
[#172]: https://github.com/wso2/helm-apim/pull/172
[#175]: https://github.com/wso2/helm-apim/pull/175
[#270]: https://github.com/wso2/helm-apim/pull/270
