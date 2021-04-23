# ******************************************************************************************************************
# *                                                                                                                *
# *  Project: Neptune Deployment and/or Migration.                                                                 *
# *                                                                                                                *
# *  Copyright © 2021 MongoExpUser. All Rights Reserved.                                                           *
# *                                                                                                                *
# *  main.tf implements a template for the deployment of AWS Neptune and/or migration of data to AWS Neptune       *
# *                                                                                                                *
# *  Neptune cluster instance(s) could be a combination of only a writer OR a writer and reader(s).                *
# *                                                                                                                *
# *                                                                                                                *
# * Note: To Migrate or Restore databse:                                                                           *
# * 1) If a snapshot is to be migrated/restored, do the followings:                                                *
# *    a) Uncomment "snapshot_identifier" paramater with the definition of the "neptune_cluster" resource          *
# *    b) Specify the ARN of the snapshot to be migrated in the "variable.tf" file under the variable name:        *
# *       "snapshot_identifier"                                                                                    *
# *                                                                                                                *
# *                                                                                                                *
# ******************************************************************************************************************
# * REFERENCES:                                                                                                    *
# * 1) Terraform                                                                                                   *
# *   a) https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_cluster               *
# *   b) https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_cluster_instance      *
# * 2) AWS                                                                                                         *
# *    a) https://docs.aws.amazon.com/neptune/latest/userguide/intro.html                                          *
# *    b) https://docs.aws.amazon.com/neptune/latest/userguide/backup-restore-restore-snapshot.html                *                                                                                                *
# ******************************************************************************************************************


# identity data
data "aws_caller_identity" "caller_identity" {}

# create local variables for referencing purpose
locals {
  account_id                    = data.aws_caller_identity.caller_identity.account_id
  snapshot_identifier_arn       = "arn:aws:rds:${var.region}:${local.account_id}:snapshot:${var.snapshot_identifier}"
  pre_or_post_fix = "${var.org_name}-${var.project_name}-${var.environment}-${var.region}"
}

# create neptune resource(s)
# 1a. cluster
resource "aws_neptune_cluster" "neptune_cluster" {
  cluster_identifier                    =   "${var.cluster_identifier}-prov"
  #snapshot_identifier                  =   local.snapshot_identifier_arn
  engine                                =   var.engine
  engine_version                        =   var.engine_version
  backup_retention_period               =   var.backup_retention_period
  preferred_backup_window               =   var.preferred_backup_window
  preferred_maintenance_window          =   var.preferred_maintenance_window
  neptune_cluster_parameter_group_name  =   var.neptune_cluster_parameter_group_name
  neptune_subnet_group_name             =   var.neptune_subnet_group_name
  vpc_security_group_ids                =   var.vpc_security_group_ids
  apply_immediately                     =   var.apply_immediately
  storage_encrypted                     =   var.storage_encrypted
  deletion_protection                   =   var.deletion_protection
  enable_cloudwatch_logs_exports        =   var.neptune_enable_cloudwatch_logs_exports
  skip_final_snapshot                   =   var.skip_final_snapshot
  final_snapshot_identifier             =   var.final_snapshot_identifier
  iam_database_authentication_enabled   =   var.iam_database_authentication_enabled
  tags = {
    Name                                =   var.prov_cluster_tag
  }
}


# 1b. cluster instances
resource "aws_neptune_cluster_instance" "neptune_cluster_instances" {
  depends_on                            =   [aws_neptune_cluster.neptune_cluster]
  count                                 =   length(var.cluster_instance_identifiers)
  identifier                            =   "${local.pre_or_post_fix}-${var.cluster_instance_identifiers[count.index]}-${count.index}"
  cluster_identifier                    =   aws_neptune_cluster.neptune_cluster.id
  instance_class                        =   var.neptune_instance_class
  engine                                =   aws_neptune_cluster.neptune_cluster.engine
  engine_version                        =   aws_neptune_cluster.neptune_cluster.engine_version
  publicly_accessible                   =   var.publicly_accessible
  neptune_subnet_group_name             =   aws_neptune_cluster.neptune_cluster.neptune_subnet_group_name
  neptune_parameter_group_name          =   aws_neptune_cluster.neptune_cluster.neptune_cluster_parameter_group_name
  preferred_maintenance_window          =   var.preferred_maintenance_window
  auto_minor_version_upgrade            =   var.auto_minor_version_upgrade
  apply_immediately                     =   var.apply_immediately
  tags = {
    Name                                =   var.instance_tags[count.index]
  }
}
