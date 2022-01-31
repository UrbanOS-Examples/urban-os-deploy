locals {
  discovery_api_aws_user_name = coalesce(var.discovery_api_iam_user_override, "${terraform.workspace}-discovery-api")
  odo_aws_user_name           = coalesce(var.odo_iam_user_override, "${terraform.workspace}-odo")
  reaper_aws_user_name        = coalesce(var.reaper_iam_user_override, "${terraform.workspace}-reaper")
  andi_aws_user_name          = coalesce(var.andi_iam_user_override, "${terraform.workspace}-andi")
  eks_cluster_name            = coalesce(var.eks_cluster_name_override, "streaming-kube-${terraform.workspace}")
  hosted_zone                 = coalesce(var.hosted_zone_override, "${terraform.workspace}.${var.root_hosted_zone}")
  elasticsearch_domain        = coalesce(var.elasticsearch_domain_override, "elasticsearch-${terraform.workspace}")
  web_acl_name                = coalesce(var.web_acl_name_override, "eks-cluster-web-acl-${terraform.workspace}")
}