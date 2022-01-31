# Provider Variables

variable "os_role_arn" {
  description = "The ARN for the assume role for OS access"
}

variable "os_region" {
  description = "Region of OS resources"
  default     = "us-west-2"
}

# Helm Variables

variable "extra_helm_args" {
  description = "Helm options"
  default     = ""
}

variable "chart_version" {
  description = "The version of the vault chart to deploy"
  default     = "1.1.2"
}

variable "force_deployment" {
  description = "Set this to a unique value to force the helm deployment"
  default     = 0.0
}

# Infrastructure Variables

variable "root_hosted_zone" {
  description = "The base hosted zone value"
  default     = "internal.smartcolumbusos.com"
}

variable "vpc_id" {
  description = "The ID for AWS VPC"
  default     = ""
}

variable "elasticsearch_domain_override" {
  description = "The elasticsearch domain name to override"
  default     = ""
}

variable "web_acl_name_override" {
  description = "The Web ACL name to override"
  default     = ""
}

variable "eks_cluster_name_override" {
  description = "The name of the eks cluster to deploy UrbanOS to"
  default     = ""
}

variable "discovery_api_iam_user_override" {
  description = "The name of the AWS IAM account for discovery"
  default     = ""
}

variable "odo_iam_user_override" {
  description = "The name of the AWS IAM account for odo"
  default     = ""
}

variable "reaper_iam_user_override" {
  description = "The name of the eks cluster to deploy UrbanOS to"
  default     = ""
}

variable "andi_iam_user_override" {
  description = "The name of the eks cluster to deploy UrbanOS to"
  default     = ""
}

variable "hosted_zone_override" {
  description = "The hosted zone name to override the value of the hosted zone"
  default     = ""
}