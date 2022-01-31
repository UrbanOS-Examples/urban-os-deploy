data "aws_ssm_parameter" "certificate" {
  name = "${terraform.workspace}_certificate_arn"
}
data "aws_ssm_parameter" "public_subnets" {
  name = "${terraform.workspace}_public_subnets"
}

data "aws_vpc" "vpc" {
  id = var.vpc_id

  # If no VPC ID is set, look up a VPC based on the workspace name.
  # This makes life easier for those working in SCOS terraform managed environments
  # Where the VPC is given the terraform.workspace as a name
  tags = length(var.vpc_id) > 0 ? {} : {
    "Name" = terraform.workspace
  }
}

data "aws_ssm_parameter" "security_groups" {
  name = "${terraform.workspace}_security_group_id"
}

data "aws_elasticsearch_domain" "elasticsearch" {
  domain_name = local.elasticsearch_domain
}

data "aws_ssm_parameter" "eks_wafv2_web_acl_arn" {
  name = "${terraform.workspace}eks_cluster_arn"
}