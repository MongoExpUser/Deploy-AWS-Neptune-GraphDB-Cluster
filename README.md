# Deploy-AWS-Neptune-GraphDB-Cluster

<strong>Terraform module for the deployment of AWS Neptune graph database cluster with or without a snapshot.</strong>
<br>

This repo is based on <strong>```Terraform Version 0.14.8```</strong>.

## RUNNING MODULE

### To run the module  on ```AWS```:

1) Copy the following script into a file (base.tf) in the current working directory:

```hcl

# define credential variable(s) of provider(s)
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}

# define provider(s)
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

# create resources
module "deploy_aws_neptune" {
  source = "git::https://github.com/mongoexpuser/deploy-aws-neptune-graphdb-cluster.git"
}

# create outputs
output "neptune_cluster" {
  description = "Created neptune cluster(s) and related key-value pair attributes"
  value = module.deploy_aws_neptune.neptune_cluster_output
}

output "neptune_cluster_instances" {
  description = "A list of created neptune cluster instance(s) and related key-value pair attributes"
  value = module.deploy_aws_neptune.neptune_cluster_instances_output
}

```

2) Check to ensure all the variables defined in the variables.tf file are <strong>```valid```</strong>.

3) Finally, execute the module from the base file (base.tf) in the current working directory (CWD) by typing the following commands at the prompt (assuming running via <strong>```bash```</strong>  with <strong>```sudo```</strong> access):


```bash
  #1) run init
  sudo terraform init
  
  #2) run terraform plan
  sudo TF_VAR_aws_access_key="access-key-value" \
       TF_VAR_aws_secret_key="secret-key-value" \
       TF_VAR_aws_region="aws-region-value" \
       terraform plan
                                                                                    
  #3) run terraform apply
  sudo TF_VAR_aws_access_key="access-key-value" \
      TF_VAR_aws_secret_key="secret-key-value" \
      TF_VAR_aws_region="aws-region-value" \
      terraform apply
```


# License

Copyright © 2015 - present. MongoExpUser

Licensed under the MIT license.
