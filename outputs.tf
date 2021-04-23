# ******************************************************************************************************************
# *                                                                                                                *
# *  Project: Neptune Deployment and/or Migration                                                                  *
# *                                                                                                                *
# *  Copyright © 2021 MongoExpUser. All Rights Reserved.                                                           *
# *                                                                                                                *
# *  output.tf.                                                                                                    *
# *                                                                                                                *                                                                                             *
# ******************************************************************************************************************

output "neptune_cluster_output" {
  description = "Created neptune cluster(s) and related key-value pair attributes"
  value = aws_neptune_cluster.neptune_cluster
}

output "neptune_cluster_instances_output" {
  description = "A list of created neptune cluster instance(s) and related key-value pair attributes"
  value = aws_neptune_cluster_instance.neptune_cluster_instances
}
