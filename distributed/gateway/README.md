# wso2am-gateway

![Version: 3.2.0-0](https://img.shields.io/badge/Version-3.2.0--0-informational?style=flat-square) ![AppVersion: 3.2.0](https://img.shields.io/badge/AppVersion-3.2.0-informational?style=flat-square)

A Helm chart for the deployment of WSO2 API Management deployment

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| aws.efs.accessPoints | object | `{"synapseConfigs":""}` | EFS Access Points for static provisioning |
| aws.efs.accessPoints.synapseConfigs | string | `""` | EFS Access Point ID for mounting synapse configs |
| aws.efs.capacity | string | `""` | EFS capacity |
| aws.efs.directoryPerms | string | `""` | EFS directory permissions |
| aws.efs.fileSystemId | string | `""` | EFS file system ID for mounting the persistent volume |
| aws.enabled | bool | `true` | If AWS is used as the cloud provider |
| aws.region | string | `""` | AWS region |
| aws.secretsManager.secretIdentifiers.internalKeystorePassword | object | `{"secretKey":"","secretName":""}` | Internal keystore password identifier in secrets manager |
| aws.secretsManager.secretIdentifiers.internalKeystorePassword.secretKey | string | `""` | AWS Secrets Manager secret key |
| aws.secretsManager.secretIdentifiers.internalKeystorePassword.secretName | string | `""` | AWS Secrets Manager secret name |
| aws.secretsManager.secretProviderClass | string | `""` | AWS Secrets Manager secret provider class name |
| aws.secretsManager.serviceAccountName | string | `""` |  |
| azure.enabled | bool | `false` | If Azure is used as the cloud provider |
| azure.keyVault.activeDirectory.servicePrincipal | object | `{"clientID":"","clientSecret":""}` | Service Principal created for transacting with the target Azure Key Vault For advanced details refer to official documentation (https://github.com/Azure/secrets-store-csi-driver-provider-azure/blob/master/docs/service-principal-mode.md) |
| azure.keyVault.activeDirectory.servicePrincipal.clientID | string | `""` | Application ID of the service principal used in secret-store-csi |
| azure.keyVault.activeDirectory.servicePrincipal.clientSecret | string | `""` | Client secret name of the service principal used in secret-store-csi |
| azure.keyVault.activeDirectory.tenantId | string | `""` | Azure Active Directory tenant ID of the target Key Vault |
| azure.keyVault.name | string | `""` | Azure Key vault used for credential management |
| azure.keyVault.resourceManager.resourceGroup | string | `""` | Name of the Azure Resource Group to which the target Azure Key Vault belongs |
| azure.keyVault.resourceManager.subscriptionId | string | `""` | Subscription ID of the target Azure Key Vault |
| azure.keyVault.secretIdentifiers.internalKeystorePasswordID | string | `""` | Internal keystore password identifier in keyvault |
| azure.keyVault.secretProviderClass | string | `""` | Azure Key vault secret provider class name |
| azure.persistence.capacity | string | `""` | Persistent volume capacity |
| azure.persistence.fileShares.synapseConfigs | string | `""` | Azure fileshare share name for synapse configs |
| azure.persistence.secretName | string | `""` | Azure file secret name |
| azure.persistence.storageAccountType | string | `""` | Persistent volume storage account type |
| azure.persistence.storageClass | string | `""` | Persistent volume storage class |
| gcp.enabled | bool | `true` | If GCP is used as the cloud provider |
| gcp.fs | object | `{"capacity":"","fileshares":{"sharedConfigs":{"fileShareName":"","fileStoreName":"","ip":""}},"location":"","network":"","tier":""}` | File Store configuration parameters |
| gcp.fs.capacity | string | `""` | Storage capacity of the file system (in GB or other appropriate units) |
| gcp.fs.fileshares | object | `{"sharedConfigs":{"fileShareName":"","fileStoreName":"","ip":""}}` | FileStore configuration for specific services |
| gcp.fs.fileshares.sharedConfigs | object | `{"fileShareName":"","fileStoreName":"","ip":""}` | FileShare configs for CarbonDB persistent storage for instance 1 |
| gcp.fs.fileshares.sharedConfigs.fileShareName | string | `""` | FileShare of the CarbonDB persistent storage for instance 1 |
| gcp.fs.fileshares.sharedConfigs.fileStoreName | string | `""` | FileStore of the CarbonDB persistent storage for instance 1 |
| gcp.fs.fileshares.sharedConfigs.ip | string | `""` | IP of the CarbonDB persistent storage for instance 1 |
| gcp.fs.location | string | `""` | Region of the FileStore |
| gcp.fs.network | string | `""` | Network of the FileStore |
| gcp.fs.tier | string | `""` | Tier of the FileStore |
| gcp.secretsManager.projectId | string | `""` | Project ID |
| gcp.secretsManager.secret.secretName | string | `""` | Name of the secret |
| gcp.secretsManager.secret.secretVersion | string | `""` | Version of the secret  |
| gcp.secretsManager.secretProviderClass | string | `""` | Secret provider class |
| gcp.secretsManager.serviceAccountName | string | `""` | Service Account with access to read secrets |
| kubernetes.ingress.gateway.annotations | object | `{"nginx.ingress.kubernetes.io/backend-protocol":"HTTPS","nginx.ingress.kubernetes.io/proxy-buffer-size":"8k","nginx.ingress.kubernetes.io/proxy-buffering":"on"}` | Gateway ingress annotations |
| kubernetes.ingress.gateway.hostname | string | `"gw.wso2.com"` | Gateway ingress hostname |
| kubernetes.ingress.ingressClass | string | `"nginx"` | Ingress class used for exposing the API Manager Gateway |
| kubernetes.ingress.ratelimit.burstLimit | string | `""` | Ingress ratelimit burst limit |
| kubernetes.ingress.ratelimit.enabled | bool | `false` | Ingress rate limit |
| kubernetes.ingress.ratelimit.zoneName | string | `""` | Ingress ratelimit zone name |
| kubernetes.ingress.tlsSecret | string | `""` | Kubernetes secret created for Ingress TLS |
| kubernetes.ingress.websocket.annotations | object | `{"nginx.ingress.kubernetes.io/backend-protocol":"HTTPS","nginx.ingress.kubernetes.io/proxy-buffer-size":"8k","nginx.ingress.kubernetes.io/proxy-buffering":"on"}` | Gateway websocket ingress annotations |
| kubernetes.ingress.websocket.hostname | string | `"ws.gw.wso2.com"` | Gateway websocket ingress hostname |
| kubernetes.resourceSuffix | string | `""` | Suffix for kubernetes resources when multiple Gateway deployments are used in the same cluster |
| kubernetes.securityContext.runAsUser | string | `"802"` | User ID of the container |
| wso2.apim.configurations.adminPassword | string | `"admin"` | Admin password of the API Manager |
| wso2.apim.configurations.adminUsername | string | `"admin"` | Admin username of the API Manager |
| wso2.apim.configurations.analytics.analyticsAuthUrls | string | `nil` | Authentication URL list for Analytics |
| wso2.apim.configurations.analytics.analyticsUrls | string | `nil` | URL list for Analytics |
| wso2.apim.configurations.analytics.enabled | bool | `false` | Enable or disable APIM Analytics (true/false) |
| wso2.apim.configurations.analytics.eventPublishingType | string | `nil` | Event publishing type |
| wso2.apim.configurations.analytics.password | string | `nil` | Password for Analytics |
| wso2.apim.configurations.analytics.receiverPassword | string | `nil` | Receiver password for Analytics |
| wso2.apim.configurations.analytics.receiverUsername | string | `nil` | Receiver username for Analytics |
| wso2.apim.configurations.analytics.storeApiPassword | string | `nil` | Store API password for Analytics |
| wso2.apim.configurations.analytics.storeApiUrl | string | `nil` | Store API URL for Analytics |
| wso2.apim.configurations.analytics.storeApiUsername | string | `nil` | Store API username for Analytics |
| wso2.apim.configurations.analytics.username | string | `nil` | Username for Analytics |
| wso2.apim.configurations.cache.gatewayToken.enabled | bool | `false` | Enable or disable gateway token cache (true/false) |
| wso2.apim.configurations.cache.gatewayToken.expiryTime | string | `"15m"` | Expiration time for gateway token cache |
| wso2.apim.configurations.cache.jwtClaim.enabled | bool | `false` | Enable or disable JWT claim cache (true/false) |
| wso2.apim.configurations.cache.jwtClaim.expiryTime | string | `"15m"` | Expiration time for JWT claim cache |
| wso2.apim.configurations.cache.kmToken.enabled | bool | `false` | Enable or disable KM token cache (true/false) |
| wso2.apim.configurations.cache.kmToken.expiryTime | string | `"15m"` | Expiration time for KM token cache |
| wso2.apim.configurations.cache.publisherRoles.enabled | bool | `false` | Publisher roles cache configuration |
| wso2.apim.configurations.cache.recentApis.enabled | bool | `false` | Enable or disable recent APIs cache (true/false) |
| wso2.apim.configurations.cache.resource.enabled | bool | `false` | Enable or disable resource cache (true/false) |
| wso2.apim.configurations.cache.resource.expiryTime | string | `"900s"` | Expiration time for resource cache |
| wso2.apim.configurations.cache.scopes.enabled | bool | `false` | Scopes cache configuration |
| wso2.apim.configurations.cache.tags.enabled | bool | `false` | Enable or disable tags cache (true/false) |
| wso2.apim.configurations.cache.tags.expiryTime | string | `"2m"` | Expiration time for tags cache |
| wso2.apim.configurations.cors.allowCredentials | bool | `false` | CORS Access-Control-Allow-Credentials |
| wso2.apim.configurations.cors.allowHeaders | list | `["authorization","Access-Control-Allow-Origin","Content-Type","SOAPAction","apikey","Internal-Key"]` | CORS Access-Control-Allow-Headers |
| wso2.apim.configurations.cors.allowMethods | list | `["GET","PUT","POST","DELETE","PATCH","OPTIONS"]` | CORS Access-Control-Allow-Methods |
| wso2.apim.configurations.cors.allowOrigins | list | `["*"]` | CORS Access-Control-Allow-Origin |
| wso2.apim.configurations.cors.enableForWS | bool | `false` | Enable CORS for Websockets |
| wso2.apim.configurations.cors.enabled | bool | `true` | CORS configuration enabled |
| wso2.apim.configurations.databases.jdbc.driver | string | `"com.mysql.cj.jdbc.Driver"` | JDBC driver class name |
| wso2.apim.configurations.databases.sharedDB.password | string | `"wso2carbon"` | Shared database password |
| wso2.apim.configurations.databases.sharedDB.poolParameters | object | `{"indexingFrequencyInSeconds":10,"removeAbandoned":true,"removeAbandonedTimeout":300,"testOnBorrow":true,"validationQuery":"SELECT 1"}` | JDBC pool parameters for shared database |
| wso2.apim.configurations.databases.sharedDB.url | string | `"jdbc:mysql://localhost:3306/shared_db?useSSL=false"` | Shared database URL |
| wso2.apim.configurations.databases.sharedDB.username | string | `"wso2carbon"` | Shared database username |
| wso2.apim.configurations.databases.type | string | `"mysql"` | Azure database type |
| wso2.apim.configurations.iskm.enabled | bool | `false` | Set true ISKM is used instead of Resident KM |
| wso2.apim.configurations.iskm.serviceName | string | `""` | ISKM kubernetes service name if ISKM is used instead of Resident KM |
| wso2.apim.configurations.iskm.servicePort | string | `nil` | ISKM kubernetes service port |
| wso2.apim.configurations.jwt.claimDialect | string | `"http://wso2.org/claims"` |  |
| wso2.apim.configurations.jwt.claimsExtractorImpl | string | `"org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever"` |  |
| wso2.apim.configurations.jwt.enableUserClaims | string | `"false"` |  |
| wso2.apim.configurations.jwt.enabled | bool | `false` |  |
| wso2.apim.configurations.jwt.encoding | string | `"base64"` |  |
| wso2.apim.configurations.jwt.generatorImpl | string | `"org.wso2.carbon.apimgt.keymgt.token.JWTGenerator"` |  |
| wso2.apim.configurations.jwt.header | string | `"X-JWT-Assertion"` |  |
| wso2.apim.configurations.jwt.signingAlgorithm | string | `"SHA256withRSA"` |  |
| wso2.apim.configurations.km.servicePort | int | `9443` | Key Manager service port |
| wso2.apim.configurations.km.serviceUrl | string | `"wso2am-cp-service"` | Key Manager service name |
| wso2.apim.configurations.log4j2.appenders | string | `""` | Appenders that can be enabled |
| wso2.apim.configurations.log4j2.loggers | string | `"AUDIT_LOG_CONSOLE, HTTP_ACCESS_CONSOLE, TRANSACTION_CONSOLE, CORRELATION_CONSOLE, jms"` | Console loggers that can be enabled. Allowed values are AUDIT_LOG_CONSOLE, HTTP_ACCESS_CONSOLE, TRANSACTION_CONSOLE, CORRELATION_CONSOLE |
| wso2.apim.configurations.oauthConfig | object | `{"authHeader":null,"enableOutboundAuthHeader":null,"enableTokenEncryption":null,"enableTokenHashing":null,"enabled":false,"revokeEndpoint":null}` | OAuth configuration |
| wso2.apim.configurations.oauthConfig.authHeader | string | `nil` | Authentication header configuration |
| wso2.apim.configurations.oauthConfig.enableOutboundAuthHeader | string | `nil` | Enable outbound authentication header for OAuth |
| wso2.apim.configurations.oauthConfig.enableTokenEncryption | string | `nil` | Enable token encryption for OAuth |
| wso2.apim.configurations.oauthConfig.enableTokenHashing | string | `nil` | Enable token hashing for OAuth |
| wso2.apim.configurations.oauthConfig.enabled | bool | `false` | Enable or disable OAuth functionality (true/false) |
| wso2.apim.configurations.oauthConfig.revokeEndpoint | string | `nil` | OAuth2 token revocation endpoint URL |
| wso2.apim.configurations.openTracer.enabled | bool | `false` | Open Tracing enabled |
| wso2.apim.configurations.openTracer.name | string | `""` | Remote tracer name. e.g. jaeger, zipkin |
| wso2.apim.configurations.openTracer.properties.hostname | string | `""` | Remote tracer hostname |
| wso2.apim.configurations.openTracer.properties.port | string | `""` | Remote tracer port |
| wso2.apim.configurations.security.jksSecretName | string | `""` | Kubernetes secret name containing the keystores and truststore |
| wso2.apim.configurations.security.keystores.internal.alias | string | `"wso2carbon"` | Internal keystore alias |
| wso2.apim.configurations.security.keystores.internal.enabled | bool | `true` | Internal keystore enabled |
| wso2.apim.configurations.security.keystores.internal.keyPassword | string | `"wso2carbon"` | Internal keystore key password |
| wso2.apim.configurations.security.keystores.internal.name | string | `"internal.jks"` | Internal keystore name |
| wso2.apim.configurations.security.keystores.internal.password | string | `"wso2carbon"` | Internal keystore password |
| wso2.apim.configurations.security.keystores.primary.alias | string | `"wso2carbon"` | Primary keystore alias |
| wso2.apim.configurations.security.keystores.primary.enabled | bool | `true` | Primary keystore enabled |
| wso2.apim.configurations.security.keystores.primary.keyPassword | string | `"wso2carbon"` | Primary keystore key password |
| wso2.apim.configurations.security.keystores.primary.name | string | `"primary.jks"` | Primary keystore name |
| wso2.apim.configurations.security.keystores.primary.password | string | `"wso2carbon"` | Primary keystore password |
| wso2.apim.configurations.security.keystores.tls.alias | string | `"wso2carbon"` | Secondary keystore alias |
| wso2.apim.configurations.security.keystores.tls.enabled | bool | `true` | Secondary keystore enabled |
| wso2.apim.configurations.security.keystores.tls.keyPassword | string | `"wso2carbon"` | Secondary keystore key password |
| wso2.apim.configurations.security.keystores.tls.name | string | `"tls.jks"` | Secondary keystore name |
| wso2.apim.configurations.security.keystores.tls.password | string | `"wso2carbon"` | Secondary keystore password |
| wso2.apim.configurations.security.truststore.name | string | `"client-truststore.jks"` | Truststore name |
| wso2.apim.configurations.security.truststore.password | string | `"wso2carbon"` | Truststore password |
| wso2.apim.configurations.serviceProvider.resourceAccessControl[0].context | string | `"(.*)/fileupload/resource(.*)"` |  |
| wso2.apim.configurations.serviceProvider.resourceAccessControl[0].httpMethod | string | `"all"` |  |
| wso2.apim.configurations.serviceProvider.resourceAccessControl[0].permissions | string | `nil` |  |
| wso2.apim.configurations.serviceProvider.resourceAccessControl[0].secure | bool | `false` |  |
| wso2.apim.configurations.serviceProvider.resourceAccessControl[1].context | string | `"(.*)/fileupload/(.*)"` |  |
| wso2.apim.configurations.serviceProvider.resourceAccessControl[1].httpMethod | string | `"all"` |  |
| wso2.apim.configurations.serviceProvider.resourceAccessControl[1].permissions[0] | string | `"/permission/protected/"` |  |
| wso2.apim.configurations.serviceProvider.resourceAccessControl[1].secure | bool | `true` |  |
| wso2.apim.configurations.serviceProvider.resourceAccessControl[2].context | string | `"(.*)/((\\.+)|(.*;+.*)|%2e)/(.*)"` |  |
| wso2.apim.configurations.serviceProvider.resourceAccessControl[2].httpMethod | string | `"all"` |  |
| wso2.apim.configurations.serviceProvider.resourceAccessControl[2].permissions[0] | string | `"/"` |  |
| wso2.apim.configurations.serviceProvider.resourceAccessControl[2].secure | bool | `true` |  |
| wso2.apim.configurations.serviceProvider.spNameRegex | string | `"^[\\sa-zA-Z0-9._-]*$"` |  |
| wso2.apim.configurations.throttling.headerBasedThrottling | bool | `false` | Enable header based throttling |
| wso2.apim.configurations.throttling.jwtClaimBasedThrottling | bool | `false` | Enable JWT claim based throttling |
| wso2.apim.configurations.throttling.portOffset | int | `0` | Traffic manager port offset |
| wso2.apim.configurations.throttling.queryParamBasedThrottling | bool | `false` | Enable query param based throttling |
| wso2.apim.configurations.throttling.serviceUrl | string | `"wso2am-tm-service"` | Traffic manager loadbalancer service url for throttling. If the traffic manager is separated from control-plane, all urls should be pointed to traffic-manager ones. |
| wso2.apim.configurations.throttling.unlimitedTier | bool | `true` | Enable unlimited throttling tier |
| wso2.apim.configurations.throttling.urls | list | `["wso2am-tm-1-service","wso2am-tm-2-service"]` | Traffic manager service urls. You only need to define one if the TM is not in HA. |
| wso2.apim.configurations.transport.passthru_https.sender.parameters.hostnameVerifier | string | `"AllowAll"` | Hostname verifier. https://apim.docs.wso2.com/en/latest/install-and-setup/setup/security/enabling-hostname-verification/#configuring-hostname-verification |
| wso2.apim.configurations.userStore.properties | object | `{"key":"value"}` | User store properties |
| wso2.apim.configurations.userStore.type | string | `"database_unique_id"` | User store type.  https://apim.docs.wso2.com/en/latest/administer/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-the-primary-user-store/ |
| wso2.apim.portOffset | int | `0` | APIM server port offset |
| wso2.apim.secureVaultEnabled | bool | `false` | Enable secure vault |
| wso2.deployment.am.gateway.cpuUtilizationPercentage | int | `75` | Target CPU utilization percentage for HPA |
| wso2.deployment.am.gateway.maxReplicas | int | `3` | Maximum replicas for HPA |
| wso2.deployment.am.gateway.memoryUtilizationPercentage | int | `75` | Target memory utilization percentage for HPA |
| wso2.deployment.am.gateway.minAvailable | string | `"50%"` | Minimum available pod counts for PDB |
| wso2.deployment.am.gateway.minReplicas | int | `2` | Minimum replicas for HPA |
| wso2.deployment.am.gateway.replicas | int | `2` | Number of deployment replicas |
| wso2.deployment.am.gateway.strategy.rollingUpdate.maxSurge | int | `2` | The maximum number of pods that can be scheduled above the desired number of pods |
| wso2.deployment.am.gateway.strategy.rollingUpdate.maxUnavailable | int | `0` | The maximum number of pods that can be unavailable during the update |
| wso2.deployment.am.image.digest | string | `""` | Docker image digest |
| wso2.deployment.am.image.imagePullPolicy | string | `"Always"` | Image pull policy |
| wso2.deployment.am.image.registry | string | `""` | Registry name consisting the image |
| wso2.deployment.am.image.repository | string | `"wso2am"` | Repository name consisting the image |
| wso2.deployment.am.livenessProbe.failureThreshold | int | `10` | Minimum consecutive successes for the probe to be considered successful after having failed |
| wso2.deployment.am.livenessProbe.initialDelaySeconds | int | `60` | Number of seconds after the container has started before liveness probes are initiated |
| wso2.deployment.am.livenessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the probe |
| wso2.deployment.am.readinessProbe.failureThreshold | int | `10` | Minimum consecutive successes for the probe to be considered successful after having failed |
| wso2.deployment.am.readinessProbe.initialDelaySeconds | int | `60` | Number of seconds after the container has started before readiness probes are initiated |
| wso2.deployment.am.readinessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the probe |
| wso2.deployment.am.resources.jvm.memory.xms | string | `"1024m"` | JVM heap memory Xms |
| wso2.deployment.am.resources.jvm.memory.xmx | string | `"1024m"` | JVM heap memory Xmx |
| wso2.deployment.am.resources.limits.cpu | string | `"2000m"` | CPU limit for API Manager |
| wso2.deployment.am.resources.limits.memory | string | `"2Gi"` | Memory limit for API Manager |
| wso2.deployment.am.resources.requests.cpu | string | `"1000m"` | CPU request for API Manager |
| wso2.deployment.am.resources.requests.memory | string | `"1Gi"` | Memory request for API Manager |
| wso2.deployment.persistence | object | `{"sharedArtifacts":{"capacity":{"synapseConfigs":"100M"}}}` | Persisted and shared runtime artifacts for API Manager See official documentation (from https://apim.docs.wso2.com/en/latest/install-and-setup/setup/reference/common-runtime-and-configuration-artifacts/#persistent-runtime-artifacts) |
| wso2.deployment.persistence.sharedArtifacts.capacity.synapseConfigs | string | `"100M"` | For synapse artifacts of APIs shared between the Gateway profile instances |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
