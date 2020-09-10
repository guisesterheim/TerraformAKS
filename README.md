# Terraform AKS

This repo has the resources to create a Kubernetes AKS cluster on Azure with two node pools

## Documentation:

For a complete explanation of each step, and all the configurations read the blog post here: http://sesterheim.com.br/build-and-configure-an-aks-on-azure-using-terraform/

## How to run:

### Step 1: 

Create an Azure user to run all your Terraform scripts. Find more information on the blog post above.

### Step 2: 

`terraform init \\<br/>
    -backend-config "container_name=\<your folder inside Azure Blob Storage\>" \\<br>
    -backend-config "storage_account_name=\<your Azure Storage Name\>" \\ \s\s
    -backend-config "key=\<file name to be stored\>" \\\s\s
    -backend-config "subscription_id=\<subscription ID of your account\>" \
    -backend-config "client_id=\<your username\>" \
    -backend-config "client_secret=\<your password\>" \
    -backend-config "tenant_id=\<tenant id\>" \
    -backend-config "resource_group_name=\<resource group name to find your Blob Storage\>"`

### Step 3:

<code>terraform plan \
    -var 'client_id=\<client_id\>' \
    -var 'client_secret=\<secret_id\>' \
    -var 'subscription_id=\<subscription_id\>' \
    -var 'tenant_id=\<tenant_id\>' \
    -var 'timestamp=\<timestamp\>' \
    -var 'acr_reader_user_client_id=\<User client ID to read ACR\>' \
    -var 'acr_reader_user_secret_key=\<User secret to read ACR\>' \
    -var-file="\<your additional vars file name. Suggestion: rootVars-dev.tfvars\>" \
    -out tfout.log</code>

### Step 4:

<code>terraform apply tfout.log</code>

### Step 5:

<code>az aks get-credentials --name $(terraform output aks_name) --resource-group $(terraform output resource_group_name)</code>

### Step 6:

Apply Kubernetes configurations:

1. <code>PROFILE=dev</code>
2. <code>kubectl apply -f k8s_deployment-dev.yaml</code>
3. <code>kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.34.1/deploy/static/provider/cloud/deploy.yaml</code>

### Step 7:

<code>kubectl get ingress --watch</code>