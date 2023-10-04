# helm-apim
This repo will be used to maintain APIM related helm charts

## Prerequisites

- WSO2 Product Docker images required for the deployment.  - It is recommended to push your own images to the cloud provider's container registry (ACR, ECR, etc.) as a best practice. Refer [U2 documentation](https://updates.docs.wso2.com/en/latest/updates/how-to-use-docker-images-to-receive-updates/) for any additional information. 
    
    Note that you need a valid WSO2 subscription to obtain the U2 updated docker images from the WSO2 private registry.

- A running Kubernetes cluster (AKS, EKS, etc.)

- Ingress controller for routing traffic. The recommendation is to use [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/) suitable for your cloud environment.

- If you are enabling secure vault configurations for the product, you need to configure the secret manager service of the respective cloud provider. Since the secrets are encrypted using the internal keystore password, that password should be included in the key vault so that it can be resolved using a CSI driver when the helm charts are deployed.

    For AWS, you need to deploy the `secrets-store-csi-driver-provider` and create the necessary IAM policies, OIDC providers, and IAM service accounts. Please refer the [documentation](https://github.com/aws/secrets-store-csi-driver-provider-aws) for more information and steps to follow.

- If you are enabling solr indexing in your setup, you need to mount the carbon database and solr indexed data to a persistent storage location.

    For AWS, the recommended solution would be EFS. To connect your cluster with EFS, you need to setup the `aws-efs-cs--driver` in your cluster. Refer to the [documentation](https://github.com/kubernetes-sigs/aws-efs-csi-driver/tree/master) to setup the driver and set necessary permissions (policy) to the IAM service account. Make sure that you have created the necessary access points in EFS with the required user permissions. The UIDs should match those of the user inside the container.

- Make sure the RDS is up and running. You need to create the relevant databases in the RDS system before deploying the chart. Also, it is recommended to include the database JDBC driver in your Docker image so that APIM can connect to the databases without any issues. If you are not adding the driver to the image itself, you might have to modify the helm charts and mount the driver to the deplyoments.

## Sample Configurations

The helm charts inlude cloud provider specific blocks. The parameters in those blocks can be used to configure services that are specific for each cloud provider.

```yaml
aws:
  enabled: true
  efs:
    capacity: "50Gi"
    directoryPerms: "0777"
    fileSystemId: "fs-12345678"
    accessPoints:
        carbonDb: "fsap-12345678"
        solr: "fsap-12345678"
  region: ""
  secretsManager:
    secretProviderClass: "wso2am-am-secret-provider-class"
    secretIdentifiers:
      internalKeystorePassword:
        secretName: "<secret_name>"
        secretKey: "<secret_key>"
  serviceAccountName: ""
```

For example, if the enabled attribute is set to true under aws, then it is assumed that the helm charts will be deployed in EKS and will be using other AWS services. Refer the [README](all-in-one/README.md) of the charts to get more information on the parameters.