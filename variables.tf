# ******************************************************************************************************************
# *                                                                                                                *
# *  Project: Neptune Deployment and/or Migration                                                                  *
# *                                                                                                                *
# *  Copyright © 2021 MongoExpUser. All Rights Reserved.                                                           *
# *                                                                                                                *
# *  variables.tf                                                                                                  *
# *                                                                                                                *                                                                                             *
# ******************************************************************************************************************


# a.  naming, tagging and environmetal variables
variable "org_name" {
  default = "my-org"
}

variable "project_name" {
  default = "my-pro"
}

variable "environment" {
  default = "my-env"
}

variable "region" {
  default = "us-east-1"
}

variable "tag_key_name" {
  default = "Name"
}

variable "prov_cluster_tag" {
  default = "my-prov-cluster"
}

variable "instance_tags" {
  description = "A list of tag values for instances."
  # length must equal length of "cluster_instance_identifiers" variable
  default = ["my-neptune-db-1", "my-neptune-db-2"]
}

# b. resource variables
variable "snapshot_identifier" {
  description = "ARN of the snapshot to be used in creating the instance(s), if snapshot is required to create the instances."
  # note: the DB snapshot must have been created from an instance with a version that is compatible with the version specified under engine version below
  # check this link for guide: https://docs.aws.amazon.com/neptune/latest/userguide/engine-releases.html
  default = "my-snapshot-arn"
}

variable "cluster_identifier" {
  default = "my-cluster"
}

variable "engine" {
  default = "neptune"
}

variable "engine_version" {
 # note: if the cluster is being created from a snapshot, ensure version compatibility between the snapshot  and the version specified here
 # check this link for guide: https://docs.aws.amazon.com/neptune/latest/userguide/engine-releases.html
  default = "1.0.4.0"
}

variable "backup_retention_period" {
  default = 1
}

variable "preferred_backup_window" {
  default = "20:00-22:30"
}

variable "preferred_maintenance_window" {
  default = "sun:15:00-sun:17:00"
}

variable "neptune_cluster_parameter_group_name" {
  # note: ensure neptune_enable_audit_log parameter is set to 1 on the specified parameter group to enable Audit logs to be published in CloudWatch Logs.
  default  = "my-cluster-parameter-group"
  #default  = "default.neptune1"
}

variable "neptune_subnet_group_name" {
  default = "my-subnet-group"
}

variable "vpc_security_group_ids" {
  default =  ["my-sg-value"]
}

variable "vpc_id" {
  # note: each DB instance has thesame subnet group (db_subnet_group_name) and security group (vpc_security_group_ids) on same VPC (vpc_id)
  default = ["my-vpc-id"]
}

variable "storage_encrypted" {
  default = true
}

variable "cluster_instance_identifiers" {
  description = "A list of instance's indentifiers (names) to be created ."
  default = ["my-neptune-db", "my-neptune-db"]
}

variable "neptune_instance_class" {
  default = "db.t3.medium"
}

variable "publicly_accessible" {
  default = false
}

variable "skip_final_snapshot"{
  default = true
}

variable "final_snapshot_identifier"{
  default = "my-cluster-snapshot"
}

variable "neptune_enable_cloudwatch_logs_exports" {
  default = ["audit"]
}

variable "auto_minor_version_upgrade" {
  default = true
}

variable "apply_immediately" {
  default = true
}

variable "deletion_protection" {
  default = true
}

variable "iam_database_authentication_enabled" {
  default = true
}
