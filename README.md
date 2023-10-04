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

    For AWS, the recommended solution would be EFS. To connect your cluster with EFS, you need to setup the `aws-efs-cs--driver` in your cluster. Refer to the [documentation](https://github.com/kubernetes-sigs/aws-efs-csi-driver/tree/master) to setup the driver and set necessary permissions (policy) to the IAM service account. Make sure that you have created the necessary access points in EFS with the required user permissions.