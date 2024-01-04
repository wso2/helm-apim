# am-all-in-one

![Version: 3.2.0-0](https://img.shields.io/badge/Version-3.2.0--0-informational?style=flat-square) ![AppVersion: 3.2.0](https://img.shields.io/badge/AppVersion-3.2.0-informational?style=flat-square)

A Helm chart for the deployment of WSO2 API Management deployment

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| aws.efs.accessPoints.carbonDb | string | `""` | EFS Access Point ID for mounting carbonDB |
| aws.efs.accessPoints.solr | string | `""` | EFS Access Point ID for mounting solr |
| aws.efs.capacity | string | `""` | EFS capacity |
| aws.efs.directoryPerms | string | `""` | EFS directory permissions |
| aws.efs.fileSystemId | string | `""` | EFS file system ID for mounting the persistent volume |
| aws.enabled | bool | `true` | If AWS is used as the cloud provider |
| aws.region | string | `""` | AWS region |
| aws.secretsManager.secretIdentifiers.internalKeystorePassword.secretKey | string | `""` | AWS Secrets Manager secret key |
| aws.secretsManager.secretIdentifiers.internalKeystorePassword.secretName | string | `""` | AWS Secrets Manager secret name |
| aws.secretsManager.secretProviderClass | string | `""` | AWS Secrets Manager secret provider class name |
| aws.secretsManager.serviceAccountName | string | `""` | Name of Kubernetes service account to read secrets |
| azure.enabled | bool | `false` | If Azure is used as the cloud provider |
| azure.keyVault.activeDirectory.servicePrincipal.clientID | string | `""` | Application ID of the service principal used in secret-store-csi |
| azure.keyVault.activeDirectory.servicePrincipal.clientSecret | string | `""` | Client secret name of the service principal used in secret-store-csi |
| azure.keyVault.activeDirectory.tenantId | string | `""` | Azure Active Directory tenant ID of the target Key Vault |
| azure.keyVault.name | string | `""` | Azure Key vault used for credential management |
| azure.keyVault.resourceManager.resourceGroup | string | `""` | Name of the Azure Resource Group to which the target Azure Key Vault belongs |
| azure.keyVault.resourceManager.subscriptionId | string | `""` | Subscription ID of the target Azure Key Vault |
| azure.keyVault.secretIdentifiers.internalKeystorePasswordID | string | `""` | Internal keystore password identifier in keyvault |
| azure.keyVault.secretProviderClass | string | `""` | Azure Key vault secret provider class name |
| azure.persistence.capacity | string | `""` | Persistent volume capacity |
| azure.persistence.fileShares.carbondb | string | `""` | Azure fileshare share name for carbonDB |
| azure.persistence.fileShares.solr | string | `""` | Azure fileshare share name for solr |
| azure.persistence.secretName | string | `""` | Azure file secret name |
| azure.persistence.storageAccountType | string | `""` | Persistent volume storage account type |
| azure.persistence.storageClass | string | `""` | Persistent volume storage class |
| gcp.enabled | bool | `false` | If GCP is used as the cloud provider |
| gcp.fs.capacity | string | `""` | Storage capacity of the file system (in GB or other appropriate units) |
| gcp.fs.fileshares.carbonDB.fileShareName | string | `""` | FileShare of the CarbonDB persistent storage |
| gcp.fs.fileshares.carbonDB.fileStoreName | string | `""` | FileStore of the CarbonDB persistent storage |
| gcp.fs.fileshares.carbonDB.ip | string | `""` | IP of the CarbonDB persistent storage |
| gcp.fs.fileshares.solr.fileShareName | string | `""` | FileShare of the solr persistent storage |
| gcp.fs.fileshares.solr.fileStoreName | string | `""` | FileStore of the solr persistent storage |
| gcp.fs.fileshares.solr.ip | string | `""` | IP of the solr persistent storage |
| gcp.fs.location | string | `""` | Region of the FileStore |
| gcp.fs.network | string | `""` | Network of the FileStore |
| gcp.fs.tier | string | `""` | Tier of the FileStore |
| gcp.secretsManager.projectId | string | `""` | Project ID |
| gcp.secretsManager.secret.secretName | string | `""` | Name of the secret |
| gcp.secretsManager.secret.secretVersion | string | `""` | Version of the secret  |
| gcp.secretsManager.secretProviderClass | string | `""` | Secret provider class |
| gcp.secretsManager.serviceAccountName | string | `""` | Service Account with access to read secrets |
| kubernetes.ingress.controlPlane.annotations."nginx.ingress.kubernetes.io/affinity" | string | `"cookie"` |  |
| kubernetes.ingress.controlPlane.annotations."nginx.ingress.kubernetes.io/backend-protocol" | string | `"HTTPS"` |  |
| kubernetes.ingress.controlPlane.annotations."nginx.ingress.kubernetes.io/session-cookie-hash" | string | `"sha1"` |  |
| kubernetes.ingress.controlPlane.annotations."nginx.ingress.kubernetes.io/session-cookie-name" | string | `"route"` |  |
| kubernetes.ingress.controlPlane.enabled | bool | `true` |  |
| kubernetes.ingress.controlPlane.hostname | string | `"am.wso2.com"` |  |
| kubernetes.ingress.gateway.annotations | object | `{"nginx.ingress.kubernetes.io/backend-protocol":"HTTPS","nginx.ingress.kubernetes.io/proxy-buffer-size":"8k","nginx.ingress.kubernetes.io/proxy-buffering":"on"}` | Ingress annotations for Gateway pass-through |
| kubernetes.ingress.gateway.enabled | bool | `true` |  |
| kubernetes.ingress.gateway.hostname | string | `"gw.wso2.com"` | Ingress hostname for Gateway pass-through |
| kubernetes.ingress.ratelimit.burstLimit | string | `""` | Ingress ratelimit burst limit |
| kubernetes.ingress.ratelimit.enabled | bool | `false` | Enable Ingress rate limit |
| kubernetes.ingress.ratelimit.zoneName | string | `""` | Ingress ratelimit zone name |
| kubernetes.ingress.websocket.annotations | object | `{"nginx.ingress.kubernetes.io/backend-protocol":"HTTPS","nginx.ingress.kubernetes.io/proxy-buffer-size":"8k","nginx.ingress.kubernetes.io/proxy-buffering":"on"}` | Ingress annotations for Websocket |
| kubernetes.ingress.websocket.enabled | bool | `true` |  |
| kubernetes.ingress.websocket.hostname | string | `"websocket.wso2.com"` | Ingress hostname for Websocket |
| kubernetes.ingressClass | string | `"nginx"` | Ingress class to be used for the ingress resource |
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
| wso2.apim.configurations.cors.enabled | bool | `true` | CORS configuration enabled |
| wso2.apim.configurations.databases.apimDB.password | string | `"wso2carbon"` | AM database password |
| wso2.apim.configurations.databases.apimDB.poolParameters | object | `{"indexingFrequencyInSeconds":10,"removeAbandoned":true,"removeAbandonedTimeout":300,"testOnBorrow":true,"validationQuery":"SELECT 1"}` | JDBC pool parameters for AM database |
| wso2.apim.configurations.databases.apimDB.url | string | `"jdbc:mysql://10.195.0.2:3306/apim_db?useSSL=false"` | AM database URL |
| wso2.apim.configurations.databases.apimDB.username | string | `"wso2carbon"` | AM database username |
| wso2.apim.configurations.databases.jdbc.driver | string | `"com.mysql.cj.jdbc.Driver"` | JDBC driver class name |
| wso2.apim.configurations.databases.sharedDB.password | string | `"wso2carbon"` | Shared database password |
| wso2.apim.configurations.databases.sharedDB.poolParameters | object | `{"indexingFrequencyInSeconds":10,"removeAbandoned":true,"removeAbandonedTimeout":300,"testOnBorrow":true,"validationQuery":"SELECT 1"}` | JDBC pool parameters for shared database |
| wso2.apim.configurations.databases.sharedDB.url | string | `"jdbc:mysql://10.195.0.2:3306/shared_db?useSSL=false"` | Shared database URL |
| wso2.apim.configurations.databases.sharedDB.username | string | `"wso2carbon"` | Shared database username |
| wso2.apim.configurations.databases.type | string | `"mysql"` | Azure database type |
| wso2.apim.configurations.devportal.applicationSharingImpl | string | `nil` | Implementation details for application sharing |
| wso2.apim.configurations.devportal.applicationSharingType | string | `nil` | Type of application sharing |
| wso2.apim.configurations.devportal.create_default_application | string | `nil` | Create a default application for new users |
| wso2.apim.configurations.devportal.displayDeprecatedApis | string | `nil` | Display deprecated APIs in the portal |
| wso2.apim.configurations.devportal.displayMultipleVersions | string | `nil` | Display multiple versions of the same API or only show the latest version |
| wso2.apim.configurations.devportal.enableAnonymousMode | string | `nil` | Enable or disable anonymous mode |
| wso2.apim.configurations.devportal.enableApplicationSharing | string | `nil` | Enable or disable application sharing |
| wso2.apim.configurations.devportal.enableComments | string | `nil` | Enable or disable comments for the API |
| wso2.apim.configurations.devportal.enableCrossTenantSubscriptions | string | `nil` | Enable or disable subscriptions across tenants |
| wso2.apim.configurations.devportal.enableForum | string | `nil` | Enable or disable the forum for the API |
| wso2.apim.configurations.devportal.enableKeyProvisioning | string | `nil` | Enable or disable key provisioning |
| wso2.apim.configurations.devportal.enableRatings | string | `nil` | Enable or disable ratings for the API |
| wso2.apim.configurations.devportal.loginUsernameCaseInsensitive | string | `nil` | Specify whether the username is case-insensitive during login |
| wso2.apim.configurations.eventListeners[0] | object | `{"id":"token_revocation","name":"org.wso2.is.notification.ApimOauthEventInterceptor","order":1,"properties":{"notificationEndpoint":"https://localhost:${mgt.transport.https.port}/internal/data/v1/notify"},"type":"org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"}` | Token revocation event listener configuration |
| wso2.apim.configurations.eventListeners[0].properties.notificationEndpoint | string | `"https://localhost:${mgt.transport.https.port}/internal/data/v1/notify"` | Notification endpoint for token revocation event |
| wso2.apim.configurations.gateway.environments | list | `[{"description":"This is the internal gateway environment","displayInApiConsole":true,"httpHostname":"gw.wso2.com","name":"default","serviceName":"apim-am-all-in-one-am-service","servicePort":9443,"showAsTokenEndpointUrl":true,"type":"hybrid","wsHostname":"websocket.wso2.com"}]` | Gateway environments |
| wso2.apim.configurations.gateway.environments[0] | object | `{"description":"This is the internal gateway environment","displayInApiConsole":true,"httpHostname":"gw.wso2.com","name":"default","serviceName":"apim-am-all-in-one-am-service","servicePort":9443,"showAsTokenEndpointUrl":true,"type":"hybrid","wsHostname":"websocket.wso2.com"}` | Gateway name |
| wso2.apim.configurations.gateway.environments[0].description | string | `"This is the internal gateway environment"` | Description |
| wso2.apim.configurations.gateway.environments[0].displayInApiConsole | bool | `true` | Display in the API console |
| wso2.apim.configurations.gateway.environments[0].httpHostname | string | `"gw.wso2.com"` | Hostname for HTTP requests |
| wso2.apim.configurations.gateway.environments[0].serviceName | string | `"apim-am-all-in-one-am-service"` | Service name for the gateway |
| wso2.apim.configurations.gateway.environments[0].servicePort | int | `9443` | Service port for the gateway |
| wso2.apim.configurations.gateway.environments[0].showAsTokenEndpointUrl | bool | `true` | Show as Token Endpoint URL |
| wso2.apim.configurations.gateway.environments[0].type | string | `"hybrid"` | Gateway type |
| wso2.apim.configurations.gateway.environments[0].wsHostname | string | `"websocket.wso2.com"` | Hostname for Websocket requests |
| wso2.apim.configurations.idp.authorizeEndpoint | string | `"https://am.wso2.com/oauth2/authorize"` | Authorization endpoint for OAuth 2.0 |
| wso2.apim.configurations.idp.enabled | bool | `true` | Enable or disable Identity Provider functionality (true/false) |
| wso2.apim.configurations.idp.oidc | object | `{"logoutEndpoint":"https://am.wso2.com/oidc/logout","sessionEndpoint":"https://am.wso2.com/oidc/checksession"}` | OpenID Connect (OIDC) configuration |
| wso2.apim.configurations.idp.oidc.logoutEndpoint | string | `"https://am.wso2.com/oidc/logout"` | Logout endpoint for OIDC |
| wso2.apim.configurations.idp.oidc.sessionEndpoint | string | `"https://am.wso2.com/oidc/checksession"` | Session endpoint for OIDC |
| wso2.apim.configurations.idp.serverUrl | string | `"https://am.wso2.com"` | URL of the Identity Provider server |
| wso2.apim.configurations.iskm.enabled | bool | `false` | Set true ISKM is used instead of Resident KM |
| wso2.apim.configurations.iskm.serviceName | string | `nil` | ISKM kubernetes service name if ISKM is used instead of Resident KM |
| wso2.apim.configurations.iskm.servicePort | string | `nil` | ISKM kubernetes service port if ISKM is used instead of Resident KM |
| wso2.apim.configurations.jwt.claimDialect | string | `"http://wso2.org/claims"` |  |
| wso2.apim.configurations.jwt.claimsExtractorImpl | string | `"org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever"` |  |
| wso2.apim.configurations.jwt.enableUserClaims | string | `"false"` |  |
| wso2.apim.configurations.jwt.enabled | bool | `false` |  |
| wso2.apim.configurations.jwt.encoding | string | `"base64"` |  |
| wso2.apim.configurations.jwt.generatorImpl | string | `"org.wso2.carbon.apimgt.keymgt.token.JWTGenerator"` |  |
| wso2.apim.configurations.jwt.header | string | `"X-JWT-Assertion"` |  |
| wso2.apim.configurations.jwt.signingAlgorithm | string | `"SHA256withRSA"` |  |
| wso2.apim.configurations.log4j2.appenders | string | `""` | Log4j appender to be enabled |
| wso2.apim.configurations.log4j2.loggers | string | `"AUDIT_LOG_CONSOLE, HTTP_ACCESS_CONSOLE, TRANSACTION_CONSOLE, CORRELATION_CONSOLE"` | Console loggers that can be enabled. Allowed values are AUDIT_LOG_CONSOLE, HTTP_ACCESS_CONSOLE, TRANSACTION_CONSOLE, CORRELATION_CONSOLE |
| wso2.apim.configurations.notification.enableAuthentication | bool | `false` | Enable authentication for the mail server (true/false) |
| wso2.apim.configurations.notification.enableStartTls | bool | `false` | Enable STARTTLS for secure communication (true/false) |
| wso2.apim.configurations.notification.fromAddress | string | `nil` | Sender's email address |
| wso2.apim.configurations.notification.hostname | string | `nil` | Hostname of the mail server |
| wso2.apim.configurations.notification.password | string | `nil` | Password for authentication (if applicable) |
| wso2.apim.configurations.notification.port | int | `25` | Port for mail server communication |
| wso2.apim.configurations.notification.username | string | `nil` | Username for authentication (if applicable) |
| wso2.apim.configurations.oauth.tokenCleanup | object | `{"enable":false}` | Token cleanup configuration |
| wso2.apim.configurations.oauth.tokenCleanup.enable | bool | `false` | Enable or disable OAuth token cleanup (true/false) |
| wso2.apim.configurations.oauthConfig | object | `{"authHeader":null,"enableOutboundAuthHeader":null,"enableTokenEncryption":null,"enableTokenHashing":null,"enabled":false,"revokeEndpoint":null}` | OAuth configuration |
| wso2.apim.configurations.oauthConfig.authHeader | string | `nil` | Authentication header configuration |
| wso2.apim.configurations.oauthConfig.enableOutboundAuthHeader | string | `nil` | Enable outbound authentication header for OAuth |
| wso2.apim.configurations.oauthConfig.enableTokenEncryption | string | `nil` | Enable token encryption for OAuth |
| wso2.apim.configurations.oauthConfig.enableTokenHashing | string | `nil` | Enable token hashing for OAuth |
| wso2.apim.configurations.oauthConfig.enabled | bool | `false` | Enable or disable OAuth functionality (true/false) |
| wso2.apim.configurations.oauthConfig.revokeEndpoint | string | `nil` | OAuth2 token revocation endpoint URL |
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
| wso2.apim.configurations.serviceProvider.spNameRegex | string | `"^[\\sa-zA-Z0-9._-]*$"` | Service Provider name regex |
| wso2.apim.configurations.throttling.blacklistCondition | object | `{"enabled":false,"period":null,"startDelay":null}` | Blacklist condition configuration |
| wso2.apim.configurations.throttling.blacklistCondition.enabled | bool | `false` | Enable or disable blacklist condition (true/false) |
| wso2.apim.configurations.throttling.blacklistCondition.period | string | `nil` | Period for blacklist condition |
| wso2.apim.configurations.throttling.blacklistCondition.startDelay | string | `nil` | Start delay for blacklist condition |
| wso2.apim.configurations.throttling.jms | object | `{"startDelay":null}` | JMS throttling configuration |
| wso2.apim.configurations.throttling.jms.startDelay | string | `nil` | Start delay for JMS throttling |
| wso2.apim.configurations.token.revocation.EnablePersistentNotifier | bool | `true` | Enable persistent notifier for token revocation |
| wso2.apim.configurations.token.revocation.EnableRealtimeNotifier | bool | `true` | Enable real-time notifier for token revocation |
| wso2.apim.configurations.token.revocation.NotifierImpl | string | `"org.wso2.carbon.apimgt.keymgt.events.TokenRevocationNotifierImpl"` | Notifier implementation for token revocation |
| wso2.apim.configurations.token.revocation.PersistentNotifierHostname | string | `"https://localhost:2379/v2/keys/jti/"` | Hostname for the persistent notifier |
| wso2.apim.configurations.token.revocation.PersistentNotifierPassword | string | `"root"` | Password for persistent notifier |
| wso2.apim.configurations.token.revocation.PersistentNotifierTtl | int | `5000` | Time-to-live (TTL) for persistent notifier (in milliseconds) |
| wso2.apim.configurations.token.revocation.PersistentNotifierUsername | string | `"root"` | Username for persistent notifier |
| wso2.apim.configurations.token.revocation.RealtimeNotifierTtl | int | `5000` | Time-to-live (TTL) for real-time notifier (in milliseconds) |
| wso2.apim.configurations.token.revocation.enabled | bool | `false` | Enable or disable token revocation functionality (true/false) |
| wso2.apim.configurations.transport.receiver.ciphers | list | `["SSL_RSA_WITH_RC4_128_MD5","SSL_RSA_WITH_RC4_128_SHA"]` | List of supported ciphers |
| wso2.apim.configurations.transport.receiver.keystore.fileName | string | `"$ref{keystore.tls.file_name}"` | Keystore file name reference |
| wso2.apim.configurations.transport.receiver.keystore.password | string | `"$ref{keystore.tls.password}"` | Keystore password reference |
| wso2.apim.configurations.transport.receiver.sessionTimeout | string | `""` | Session timeout duration |
| wso2.apim.configurations.transport.receiver.sslEnabledProtocols | list | `["TLSv1","TLSv1.1","TLSv1.2"]` | Enabled SSL protocols |
| wso2.apim.configurations.transport.receiver.sslPort | int | `9711` | SSL port for secure communication |
| wso2.apim.configurations.transport.receiver.tcpPort | int | `9611` | TCP port for communication |
| wso2.apim.configurations.transport.receiver.type | string | `""` | Receiver type (e.g., HTTP, HTTPS) |
| wso2.apim.configurations.transport.receiver.workerThreads | int | `10` | Number of worker threads |
| wso2.apim.configurations.userStore.properties | object | `{"key":"value"}` | User store properties |
| wso2.apim.configurations.userStore.type | string | `"database_unique_id"` | User store type.  https://apim.docs.wso2.com/en/latest/administer/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-the-primary-user-store/ |
| wso2.apim.configurations.workflow.callbackEndpoint | string | `nil` | Callback endpoint for workflow |
| wso2.apim.configurations.workflow.clientRegistrationEndpoint | string | `nil` | Endpoint for client registration in workflow |
| wso2.apim.configurations.workflow.clientRegistrationPassword | string | `nil` | Password for client registration in workflow |
| wso2.apim.configurations.workflow.clientRegistrationUsername | string | `nil` | Username for client registration in workflow |
| wso2.apim.configurations.workflow.enabled | bool | `false` | Enable or disable workflow functionality (true/false) |
| wso2.apim.configurations.workflow.serviceUrl | string | `nil` | URL of the workflow service |
| wso2.apim.configurations.workflow.tokenEndpoint | string | `nil` | Token endpoint for workflow |
| wso2.apim.portOffset | int | `0` | APIM server port offset |
| wso2.apim.secureVaultEnabled | bool | `true` | Enable secure vault |
| wso2.deployment.am.image.digest | string | `""` | Docker image digest |
| wso2.deployment.am.image.imagePullPolicy | string | `"Always"` | Image pull policy |
| wso2.deployment.am.image.registry | string | `""` | Registry name consisting the image |
| wso2.deployment.am.image.repository | string | `""` | Repository name consisting the image |
| wso2.deployment.am.livenessProbe.failureThreshold | int | `3` | Minimum consecutive successes for the probe to be considered successful after having failed |
| wso2.deployment.am.livenessProbe.initialDelaySeconds | int | `120` | Number of seconds after the container has started before liveness probes are initiated |
| wso2.deployment.am.livenessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the probe |
| wso2.deployment.am.minAvailable | int | `1` | Minimum available pod counts for PDB |
| wso2.deployment.am.readinessProbe.failureThreshold | int | `3` | Minimum consecutive successes for the probe to be considered successful after having failed |
| wso2.deployment.am.readinessProbe.initialDelaySeconds | int | `120` | Number of seconds after the container has started before readiness probes are initiated |
| wso2.deployment.am.readinessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the probe |
| wso2.deployment.am.resources.jvm.memory.xms | string | `"1024m"` | JVM heap memory Xms |
| wso2.deployment.am.resources.jvm.memory.xmx | string | `"1024m"` | JVM heap memory Xmx |
| wso2.deployment.am.resources.limits.cpu | string | `"2000m"` | CPU limit for API Manager |
| wso2.deployment.am.resources.limits.memory | string | `"2Gi"` | Memory limit for API Manager |
| wso2.deployment.am.resources.requests.cpu | string | `"1000m"` | CPU request for API Manager |
| wso2.deployment.am.resources.requests.memory | string | `"1Gi"` | Memory request for API Manager |
| wso2.deployment.persistence.solrIndexing | object | `{"capacity":{"carbonDatabase":"50M","solrIndexedData":"50M"},"enabled":true}` | Persistent runtime artifacts for Apache solr-based indexing |
| wso2.deployment.persistence.solrIndexing.capacity.carbonDatabase | string | `"50M"` | For persisting the H2 based local Carbon database file |
| wso2.deployment.persistence.solrIndexing.capacity.solrIndexedData | string | `"50M"` | For persisting the indexed data |
| wso2.deployment.persistence.solrIndexing.enabled | bool | `true` | Indicates if persistence of the runtime artifacts for Apache solr-based indexing is enabled By default, this is disabled |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
