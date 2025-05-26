# Deploying API-M on OpenShift

## Prerequisites

- Install Git, Helm, OpenShift Client (OC), and the Kubernetes client to follow the steps in this quick start guide.
- Have an existing OpenShift cluster set up.
- Install the NGINX Ingress Controller. Note that Helm resources for WSO2 product deployment patterns are compatible with NGINX Ingress Controller release nginx-0.22.0. Below is a simple guide to set up ingress.

##### Installing Ingress (Optional)

- Use the `deploy.yaml` file from [Kubernetes/nginx-ingress](https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.2/deploy/static/provider/cloud/deploy.yaml) and remove the `runAsUser` and `runAsGroup` values, except for the `runAsUser` defined under 'Deployment' (also delete `runAsGroup` in the Deployment).

```yaml
# custom-ingress-nginx.yaml

apiVersion: security.openshift.io/v1
kind: SecurityContextConstraints
metadata:
    name: ingress-nginx-scc
allowPrivilegedContainer: false
allowHostDirVolumePlugin: false
allowHostNetwork: false
allowHostPID: false
allowHostPorts: true
allowHostIPC: false
defaultAddCapabilities: []
requiredDropCapabilities:
    - ALL
allowedCapabilities:
    - NET_BIND_SERVICE
volumes:
    - configMap
    - secret
    - downwardAPI
    - emptyDir
    - projected
readOnlyRootFilesystem: false
runAsUser:
    type: MustRunAsNonRoot
seLinuxContext:
    type: MustRunAs
fsGroup:
    type: RunAsAny
supplementalGroups:
    type: RunAsAny
seccompProfiles:
    - "runtime/default"
users:
    - system:serviceaccount:ingress-nginx:ingress-nginx
    - system:serviceaccount:ingress-nginx:ingress-nginx-admission
priority: 10
```

- Run:
    ```bash
    oc apply -f ingress-custom-scc.yaml
    oc adm policy add-scc-to-user ingress-nginx-scc -z ingress-nginx,ingress-nginx-admission -n ingress-nginx
    ```
- Check the pods; NGINX should be running. Get the services to find the EXTERNAL-IP.

## General Steps

Required Dockerfiles can be found in the [docker-apim](https://github.com/wso2/docker-apim) repository. Follow the steps below to prepare the necessary images.

#### Preparing the Docker Images

To comply with OpenShift’s security model, especially its use of arbitrary user IDs, you must create a custom Docker image tailored for OpenShift. The following steps ensure compatibility, including setting group ownership to the root group (GID 0), which allows access when OpenShift assigns a random UID at runtime.

The official WSO2 Docker images run as a non-root user with a fixed UID. While this works on standard Kubernetes clusters, OpenShift injects a random UID and restricts container privileges. To prevent permission issues, update the image to:

1. Allow group write access to required directories.
2. Assign root group ownership (GID 0).

Also note:

1. Starting from v4.5.0, each component has a separate Docker image (All-in-one, Control-plane, Gateway, Traffic-manager).
2. These Docker images do not contain any database connectors; you need to build custom Docker images based on each Docker image to work with a separate DB.
3. Download a connector compatible with your DB version and copy it while building the image.

Example: Below is a sample modified Dockerfile using the existing `ubuntu/apim` as the base image.
```Dockerfile
FROM ubuntu:24.04

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# install dependencies
RUN apt-get update \
        && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata curl ca-certificates fontconfig locales python-is-python3 libxml2-utils netcat-traditional unzip wget \
        && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
        && locale-gen en_US.UTF-8 \
        && rm -rf /var/lib/apt/lists/*

ENV JAVA_VERSION=jdk-21.0.5+11
ENV JAVA_HOME=/opt/java/openjdk \
        PATH="/opt/java/openjdk/bin:$PATH"

# install Temurin OpenJDK 21
RUN set -eux; \
        ARCH="$(dpkg --print-architecture)"; \
        case "${ARCH}" in \
             amd64) \
                 ESUM='3c654d98404c073b8a7e66bffb27f4ae3e7ede47d13284c132d40a83144bfd8c'; \
                 BINARY_URL='https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.5%2B11/OpenJDK21U-jdk_x64_linux_hotspot_21.0.5_11.tar.gz'; \
                 ;; \
             arm64) \
                 ESUM='6482639ed9fd22aa2e704cc366848b1b3e1586d2bf1213869c43e80bca58fe5c'; \
                 BINARY_URL='https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.5%2B11/OpenJDK21U-jdk_aarch64_linux_hotspot_21.0.5_11.tar.gz'; \
                 ;; \
             ppc64el) \
                 ESUM='3c6f4c358facfb6c19d90faf02bfe0fc7512d6b0e80ac18146bbd7e0d01deeef'; \
                 BINARY_URL='https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.5%2B11/OpenJDK21U-jdk_ppc64le_linux_hotspot_21.0.5_11.tar.gz'; \
                 ;; \
             s390x) \
                 ESUM='51a7ca42cc2e8cb5f3e7a326c28912ee84ff0791a1ca66650a8c53af07510a7c'; \
                 BINARY_URL='https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.5%2B11/OpenJDK21U-jdk_s390x_linux_hotspot_21.0.5_11.tar.gz'; \
                 ;; \
             *) \
                 echo "Unsupported arch: ${ARCH}"; \
                 exit 1; \
                 ;; \
        esac; \
        curl -LfsSo /tmp/openjdk.tar.gz ${BINARY_URL}; \
        echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
        mkdir -p /opt/java/openjdk; \
        cd /opt/java/openjdk; \
        tar -xf /tmp/openjdk.tar.gz --strip-components=1; \
        rm -rf /tmp/openjdk.tar.gz; \
        java -Xshare:dump;

LABEL maintainer="WSO2 Docker Maintainers <dev@wso2.org>" \
            com.wso2.docker.source="https://github.com/wso2/docker-apim/releases/tag/v4.5.0.1"

# set Docker image build arguments
ARG USER=wso2carbon
ARG USER_ID=10001
ARG USER_GROUP=root
ARG USER_GROUP_ID=0
ARG USER_HOME=/home/${USER}
ARG WSO2_SERVER_NAME=wso2am
ARG WSO2_SERVER_VERSION=4.5.0
ARG WSO2_SERVER_REPOSITORY=product-apim
ARG WSO2_SERVER=${WSO2_SERVER_NAME}-${WSO2_SERVER_VERSION}
ARG WSO2_SERVER_HOME=${USER_HOME}/${WSO2_SERVER}
ARG WSO2_SERVER_DIST_URL=https://github.com/wso2/${WSO2_SERVER_REPOSITORY}/releases/download/v${WSO2_SERVER_VERSION}/${WSO2_SERVER}.zip
ARG MOTD="\n\
Welcome to WSO2 Docker resources.\n\
------------------------------------ \n\
This Docker container comprises a WSO2 product, running with its latest GA release \n\
which is under the Apache License, Version 2.0. \n\
Read more about Apache License, Version 2.0 here @ http://www.apache.org/licenses/LICENSE-2.0.\n"

# create the non-root user and group and set MOTD login message
RUN useradd --system \
                --uid   "${USER_ID}" \
                --gid   "${USER_GROUP_ID}" \   
                --create-home --home-dir "${USER_HOME}" \
                --shell /bin/bash \
                "${USER}" \
        && echo '[ ! -z "${TERM}" -a -r /etc/motd ] && cat /etc/motd' \
                >> /etc/bash.bashrc \
        && echo "${MOTD}" > /etc/motd

# copy init script to user home
COPY docker-entrypoint.sh ${USER_HOME}

RUN chown ${USER} /home/${USER}/docker-entrypoint.sh \
        && chgrp -R 0 ${USER_HOME} \
        && chmod -R g+rwX ${USER_HOME}

# add the WSO2 product distribution to user's home directory
RUN \
        wget -O ${WSO2_SERVER}.zip "${WSO2_SERVER_DIST_URL}" \
        && unzip -d ${USER_HOME} ${WSO2_SERVER}.zip \
        && chown ${USER} -R ${WSO2_SERVER_HOME} \
        && chgrp -R 0 ${WSO2_SERVER_HOME} \
        && chmod -R g+rwX ${WSO2_SERVER_HOME} \
        && mkdir ${USER_HOME}/wso2-tmp \
        && bash -c 'mkdir -p ${USER_HOME}/solr/{indexed-data,database}' \
        && chown ${USER} -R ${USER_HOME}/solr \
        && chgrp -R 0 ${USER_HOME}/solr \
        && chmod -R g+rwX ${USER_HOME}/solr \
        && cp -r ${WSO2_SERVER_HOME}/repository/deployment/server/synapse-configs ${USER_HOME}/wso2-tmp \
        && cp -r ${WSO2_SERVER_HOME}/repository/deployment/server/executionplans ${USER_HOME}/wso2-tmp \
        && rm -f ${WSO2_SERVER}.zip

# copy MySQL driver into the server’s lib directory
COPY --chown=${USER}:${USER_GROUP} mysql-connector.jar ${WSO2_SERVER_HOME}/repository/components/lib/

# remove unnecessary packages
RUN apt-get purge -y netcat-traditional unzip wget

# set the user and work directory
USER ${USER_ID}
WORKDIR ${USER_HOME}

# set environment variables
ENV WORKING_DIRECTORY=${USER_HOME} \
        WSO2_SERVER_HOME=${WSO2_SERVER_HOME}

# expose ports
EXPOSE 9763 9443 9999 11111 8280 8243 5672 9711 9611 9099

# initiate container and start WSO2 Carbon server
ENTRYPOINT ["/home/wso2carbon/docker-entrypoint.sh"]
```
After making the changes, build and push the image to your registry. Update the Helm charts to use these modified images when deploying.

#### Create a Database

Example: Connecting to an External MySQL DB in Azure

1. Go to the Azure dashboard and navigate to `Azure Database for MySQL servers` to create a database.
2. Disable TLS:
        1. Go to the newly created database and navigate to Settings -> Server parameters.
        2. Find `require_secure_transport`, turn it OFF, and save the changes.
        3. Set `max_connections` to 340.
        4. Set `transaction_isolation` to `READ-COMMITTED`.
3. Log in to the DB instance and create the required databases and users:
```sql
CREATE DATABASE apim_db CHARACTER SET latin1;
CREATE DATABASE shared_db CHARACTER SET latin1;

CREATE USER 'apimadmin'@'%' IDENTIFIED BY 'apimadmin';
GRANT ALL ON apim_db.* TO 'apimadmin'@'%';

CREATE USER 'sharedadmin'@'%' IDENTIFIED BY 'sharedadmin';
GRANT ALL ON shared_db.* TO 'sharedadmin'@'%';

FLUSH PRIVILEGES;
```
4. Run the DB scripts (these can be found inside the `dbscripts` folder in an APIM pack):
```bash
mysql -h <DB-URL> -P 3306 -u sharedadmin -p -Dshared_db < './dbscripts/mysql.sql'
mysql -h <DB-URL> -P 3306 -u apimadmin -p -Dapim_db < './dbscripts/apimgt/mysql.sql'
```

#### Log in to the OpenShift Cluster

```bash
oc login <API server URL> -u <user> -p <password>
```

#### Create Secret

1. Before deploying the Helm chart, create a Kubernetes secret containing the keystores and truststore.
2. You can find the default keystore and truststore in any APIM pack at `repository/resources/security/`:
```bash
kubectl create secret generic jks-secret --from-file=wso2carbon.jks --from-file=client-truststore.jks
```

#### Clone helm-apim

```bash
git clone https://github.com/wso2/helm-apim.git
```

#### Change OpenShift-Specific Settings in values.yaml

In each corresponding `values.yaml` file, make the following changes for compatibility with OpenShift:

> 1. **runAsUser**: To allow assignment of arbitrary UIDs, set `kubernetes.securityContext.runAsUser=null`.
> 2. **SELinux Support**: Enable by setting `kubernetes.securityContext.seLinux.enabled=true` if needed.
> 3. **AppArmor Support**: Disable by setting `kubernetes.enableAppArmor=false` if needed.
> 4. **ConfigMap Access**: If your runtime user lacks execute access to ConfigMaps, set `kubernetes.configMaps.scripts.defaultMode=0457`.
> 5. **Seccomp**: Change the seccomp profile using `kubernetes.securityContext.seccompProfile.type`.

Example:

```yaml
    securityContext:
        # -- User ID of the container
        runAsUser: null
        # -- SELinux context for the container
        seLinux:
            enabled: false
            level: ""
        # -- Seccomp profile for the container
        seccompProfile:
            # -- Seccomp profile type (RuntimeDefault, Unconfined, or Localhost)
            type: RuntimeDefault
            localhostProfile: ""
    # -- Enable AppArmor profiles for the deployment
    enableAppArmor: false
    # -- Set UNIX permissions over the executable scripts
    configMaps:
        scripts:
            defaultMode: "0457"
```

---

## APIM ALL-IN-ONE Deployment

- Navigate to the all-in-one deployment (`helm-apim/all-in-one`) and edit `default_values.yaml`:
    - Update the DB-related information (type, URL, credentials, etc.) and the container image information (repository, digest, etc.) as needed.
    - Set `wso2.apim.configurations.security.jksSecretName` to the secret name created earlier.

- Apply the Helm chart using:
    ```bash
    helm install <deployment-name> . -f default_values.yaml
    ```

[Add the Helm install command that sets the values within the command itself.]

## Distributed Setup

Helm charts for distributed setups are in the `apim-helm/distributed` folder. In each chart, update the DB-related information (type, URL, credentials, etc.) and the container image information (repository, digest, etc.) as needed in the `values.yaml`. Refer to the deployment patterns section to find the suitable deployment pattern and follow the deployment guide to make the necessary changes to the `values.yaml`.
