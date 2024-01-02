# wso2am-traffic-manager

![Version: 3.2.0-0](https://img.shields.io/badge/Version-3.2.0--0-informational?style=flat-square) ![AppVersion: 3.2.0](https://img.shields.io/badge/AppVersion-3.2.0-informational?style=flat-square)

A Helm chart for the deployment of WSO2 API Management Traffic Manager profile

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| aws.efs.accessPoints | object | `{"executionPlans":"fsap-02cc2fe5aca70d172"}` | EFS Access Points for static provisioning |
| aws.efs.capacity | string | `"1Ti"` | EFS capacity |
| aws.efs.directoryPerms | string | `"0777"` | EFS directory permissions |
| aws.efs.fileSystemId | string | `""` | EFS file system ID for mounting the persistent volume |
| aws.enabled | bool | `false` | If AWS is used as the cloud provider |
| aws.region | string | `"us-west-1"` |  |
| aws.secretsManager | object | `{"secretIdentifiers":{"internalKeystorePassword":{"secretKey":"secret","secretName":""}},"secretProviderClass":"wso2am-tm-secret-provider-class","serviceAccountName":"admin"}` | AWS region |
| aws.secretsManager.secretIdentifiers.internalKeystorePassword | object | `{"secretKey":"secret","secretName":""}` | Internal keystore password identifier in secrets manager |
| aws.secretsManager.secretIdentifiers.internalKeystorePassword.secretKey | string | `"secret"` | AWS Secrets Manager secret key |
| aws.secretsManager.secretIdentifiers.internalKeystorePassword.secretName | string | `""` | AWS Secrets Manager secret name |
| aws.secretsManager.secretProviderClass | string | `"wso2am-tm-secret-provider-class"` | AWS Secrets Manager secret provider class name |
| azure.enabled | bool | `false` | If Azure is used as the cloud provider |
| azure.keyVault.activeDirectory.servicePrincipal | object | `{"clientID":"","clientSecret":""}` | Service Principal created for transacting with the target Azure Key Vault For advanced details refer to official documentation (https://github.com/Azure/secrets-store-csi-driver-provider-azure/blob/master/docs/service-principal-mode.md) |
| azure.keyVault.activeDirectory.servicePrincipal.clientID | string | `""` | Application ID of the service principal used in secret-store-csi |
| azure.keyVault.activeDirectory.servicePrincipal.clientSecret | string | `""` | Client secret name of the service principal used in secret-store-csi |
| azure.keyVault.activeDirectory.tenantId | string | `""` | Azure Active Directory tenant ID of the target Key Vault |
| azure.keyVault.name | string | `"wso2am-vault"` | Azure Key vault used for credential management |
| azure.keyVault.resourceManager.resourceGroup | string | `""` | Name of the Azure Resource Group to which the target Azure Key Vault belongs |
| azure.keyVault.resourceManager.subscriptionId | string | `""` | Subscription ID of the target Azure Key Vault |
| azure.keyVault.secretIdentifiers.internalKeystorePasswordID | string | `"wso2am"` | Internal keystore password identifier in keyvault |
| azure.keyVault.secretProviderClass | string | `"wso2am-tm-secret-provider-class"` | Azure Key vault secret provider class name |
| azure.persistence.capacity | string | `"1Gi"` | Persistent volume capacity |
| azure.persistence.fileShares | object | `{"executionPlans":"executionplans"}` | Azure fileshare share name |
| azure.persistence.secretName | string | `"azure-secret"` | Azure file secret name |
| azure.persistence.storageAccountType | string | `""` | Persistent volume storage account type |
| azure.persistence.storageClass | string | `"azurefile"` | Persistent volume storage class |
| gcp.enabled | bool | `true` | If GCP is used as the cloud provider |
| gcp.fs | object | `{"capacity":"1Ti","fileshares":{"executionPlans":{"fileShareName":"executionplans","fileStoreName":"-dev-executionplans-filestore","ip":"10.17.132.226"}},"location":"us-central1-b","network":"default","tier":"standard"}` | File Store configuration parameters |
| gcp.fs.capacity | string | `"1Ti"` | Storage capacity of the file system (in GB or other appropriate units) |
| gcp.fs.fileshares | object | `{"executionPlans":{"fileShareName":"executionplans","fileStoreName":"-dev-executionplans-filestore","ip":"10.17.132.226"}}` | FileStore configuration for specific services |
| gcp.fs.fileshares.executionPlans | object | `{"fileShareName":"executionplans","fileStoreName":"-dev-executionplans-filestore","ip":"10.17.132.226"}` | FileShare configs for CarbonDB persistent storage for instance 1 |
| gcp.fs.fileshares.executionPlans.fileShareName | string | `"executionplans"` | FileShare of the CarbonDB persistent storage for instance 1 |
| gcp.fs.fileshares.executionPlans.fileStoreName | string | `"-dev-executionplans-filestore"` | FileStore of the CarbonDB persistent storage for instance 1 |
| gcp.fs.fileshares.executionPlans.ip | string | `"10.17.132.226"` | IP of the CarbonDB persistent storage for instance 1 |
| gcp.fs.location | string | `"us-central1-b"` | Region of the FileStore |
| gcp.fs.network | string | `"default"` | Network of the FileStore |
| gcp.fs.tier | string | `"standard"` | Tier of the FileStore |
| gcp.secretsManager | object | `{"projectId":"","secret":{"secretName":"secret","secretVersion":"1"},"secretProviderClass":"secret-provider-tm","serviceAccountName":"admin"}` | Secrets Manager configuration parameters |
| gcp.secretsManager.projectId | string | `""` | Project ID |
| gcp.secretsManager.secret.secretName | string | `"secret"` | Name of the secret |
| gcp.secretsManager.secret.secretVersion | string | `"1"` | Version of the secret  |
| gcp.secretsManager.secretProviderClass | string | `"secret-provider-tm"` | Secret provider class |
| gcp.secretsManager.serviceAccountName | string | `"admin"` | Service Account with access to read secrets |
| kubernetes.securityContext.runAsUser | string | `"802"` | User ID of the container |
| wso2.apim.configurations.adminPassword | string | `"admin"` | Admin password of the API Manager |
| wso2.apim.configurations.adminUsername | string | `"admin"` | Admin username of the API Manager |
| wso2.apim.configurations.databases.apimDB.password | string | `"wso2carbon"` | AM database password |
| wso2.apim.configurations.databases.apimDB.poolParameters | object | `{"indexingFrequencyInSeconds":10,"removeAbandoned":true,"removeAbandonedTimeout":300,"testOnBorrow":true,"validationQuery":"SELECT 1"}` | JDBC pool parameters for AM database |
| wso2.apim.configurations.databases.apimDB.url | string | `"jdbc:mysql://localhost:3306/apim_db?useSSL=false"` | AM database URL |
| wso2.apim.configurations.databases.apimDB.username | string | `"wso2carbon"` | AM database username |
| wso2.apim.configurations.databases.jdbc.driver | string | `"com.mysql.cj.jdbc.Driver"` | JDBC driver class name |
| wso2.apim.configurations.databases.sharedDB.password | string | `"wso2carbon"` | Shared database password |
| wso2.apim.configurations.databases.sharedDB.poolParameters | object | `{"indexingFrequencyInSeconds":10,"removeAbandoned":true,"removeAbandonedTimeout":300,"testOnBorrow":true,"validationQuery":"SELECT 1"}` | JDBC pool parameters for shared database |
| wso2.apim.configurations.databases.sharedDB.url | string | `"jdbc:mysql://localhost:3306/shared_db?useSSL=false"` | Shared database URL |
| wso2.apim.configurations.databases.sharedDB.username | string | `"wso2carbon"` | Shared database username |
| wso2.apim.configurations.databases.type | string | `"mysql"` | Azure database type |
| wso2.apim.configurations.eventHandlers[0].name | string | `"userPostSelfRegistration"` |  |
| wso2.apim.configurations.eventHandlers[0].subscriptions[0] | string | `"POST_ADD_USER"` |  |
| wso2.apim.configurations.iskm.enabled | bool | `false` | Set true ISKM is used instead of Resident KM |
| wso2.apim.configurations.iskm.serviceName | string | `""` | ISKM kubernetes service name if ISKM is used instead of Resident KM |
| wso2.apim.configurations.iskm.servicePort | string | `nil` |  |
| wso2.apim.configurations.km.servicePort | int | `9443` |  |
| wso2.apim.configurations.km.serviceUrl | string | `"wso2am-cp-service"` | SKey Manager service name |
| wso2.apim.configurations.log4j2 | object | `{"appenders":"","loggers":"AUDIT_LOG_CONSOLE, HTTP_ACCESS_CONSOLE, TRANSACTION_CONSOLE, CORRELATION_CONSOLE"}` | Application password of accoutn recovery webapp |
| wso2.apim.configurations.log4j2.appenders | string | `""` | Appenders that can be enabled |
| wso2.apim.configurations.log4j2.loggers | string | `"AUDIT_LOG_CONSOLE, HTTP_ACCESS_CONSOLE, TRANSACTION_CONSOLE, CORRELATION_CONSOLE"` | Console loggers that can be enabled. Allowed values are AUDIT_LOG_CONSOLE, HTTP_ACCESS_CONSOLE, TRANSACTION_CONSOLE, CORRELATION_CONSOLE |
| wso2.apim.configurations.oauth.tokenCleanup.enable | bool | `false` | Token cleanup enabled |
| wso2.apim.configurations.resourceAccessControl[0].context | string | `"(.*)/fileupload/resource(.*)"` |  |
| wso2.apim.configurations.resourceAccessControl[0].httpMethod | string | `"all"` |  |
| wso2.apim.configurations.resourceAccessControl[0].permissions | string | `nil` |  |
| wso2.apim.configurations.resourceAccessControl[0].secure | bool | `false` |  |
| wso2.apim.configurations.resourceAccessControl[1].context | string | `"(.*)/fileupload/(.*)"` |  |
| wso2.apim.configurations.resourceAccessControl[1].httpMethod | string | `"all"` |  |
| wso2.apim.configurations.resourceAccessControl[1].permissions[0] | string | `"/permission/protected/"` |  |
| wso2.apim.configurations.resourceAccessControl[1].secure | bool | `true` |  |
| wso2.apim.configurations.resourceAccessControl[2].context | string | `"(.*)/((\\.+)|(.*;+.*)|%2e)/(.*)"` |  |
| wso2.apim.configurations.resourceAccessControl[2].httpMethod | string | `"all"` |  |
| wso2.apim.configurations.resourceAccessControl[2].permissions[0] | string | `"/"` |  |
| wso2.apim.configurations.resourceAccessControl[2].secure | bool | `true` |  |
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
| wso2.apim.configurations.serviceProvider.spNameRegex | string | `"^[\\sa-zA-Z0-9._-]*$"` |  |
| wso2.apim.configurations.sessionData.cleanUp.expiredData | bool | `false` |  |
| wso2.apim.configurations.sessionData.cleanUp.loggedOutSessions | bool | `false` |  |
| wso2.apim.configurations.sessionData.cleanUp.preSessionData | bool | `false` |  |
| wso2.apim.configurations.userStore.properties | object | `{"key":"value"}` | User store properties |
| wso2.apim.configurations.userStore.type | string | `"database_unique_id"` | User store type.  https://apim.docs.wso2.com/en/latest/administer/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-the-primary-user-store/ |
| wso2.apim.portOffset | int | `0` | APIM server port offset |
| wso2.apim.secureVaultEnabled | bool | `false` | Enable secure vault |
| wso2.deployment.am.image.digest | string | `""` | Docker image digest |
| wso2.deployment.am.image.imagePullPolicy | string | `"Always"` | Image pull policy |
| wso2.deployment.am.image.registry | string | `""` | Registry name consisting the image |
| wso2.deployment.am.image.repository | string | `"wso2am"` | Repository name consisting the image |
| wso2.deployment.am.livenessProbe.failureThreshold | int | `3` | Minimum consecutive successes for the probe to be considered successful after having failed |
| wso2.deployment.am.livenessProbe.initialDelaySeconds | int | `60` | Number of seconds after the container has started before liveness probes are initiated |
| wso2.deployment.am.livenessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the probe |
| wso2.deployment.am.minAvailable | int | `1` | Minimum available pod counts for PDB |
| wso2.deployment.am.readinessProbe.failureThreshold | int | `3` | Minimum consecutive successes for the probe to be considered successful after having failed |
| wso2.deployment.am.readinessProbe.initialDelaySeconds | int | `60` | Number of seconds after the container has started before readiness probes are initiated |
| wso2.deployment.am.readinessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the probe |
| wso2.deployment.am.resources.jvm.memory.xms | string | `"1024m"` | JVM heap memory Xms |
| wso2.deployment.am.resources.jvm.memory.xmx | string | `"1024m"` | JVM heap memory Xmx |
| wso2.deployment.am.resources.limits.cpu | string | `"3000m"` | CPU limit for API Manager |
| wso2.deployment.am.resources.limits.memory | string | `"3Gi"` | Memory limit for API Manager |
| wso2.deployment.am.resources.requests.cpu | string | `"2000m"` | CPU request for API Manager |
| wso2.deployment.am.resources.requests.memory | string | `"2Gi"` | Memory request for API Manager |
| wso2.deployment.persistence | object | `{"sharedArtifacts":{"capacity":{"executionPlans":"100M"}}}` | Persisted and shared runtime artifacts for API Manager See official documentation (from https://apim.docs.wso2.com/en/latest/install-and-setup/setup/reference/common-runtime-and-configuration-artifacts/#persistent-runtime-artifacts) |
| wso2.deployment.persistence.sharedArtifacts.capacity.executionPlans | string | `"100M"` | For execution plans shared between the Traffic Manager profile instances |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
