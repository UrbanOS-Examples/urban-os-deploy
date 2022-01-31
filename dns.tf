provider "aws" {
  version = "~> 3.0"
  alias   = "alm"
  region  = var.alm_region

  assume_role {
    role_arn = var.alm_role_arn
  }
}

data "aws_route53_zone" "internal_zone" {
  provider = aws.alm
  name     = var.internal_zone_name
}

resource "aws_route53_record" "aip_ns_record" {
  count    = var.aip_dns_enabled ? 1 : 0
  provider = aws.alm
  zone_id  = data.aws_route53_zone.internal_zone.zone_id
  name     = var.ns_record_name
  ttl      = 300
  type     = "NS"
  records  = var.ns_records

  lifecycle {
    ignore_changes = [
      name,
      allow_overwrite,
    ]
  }
}

variable "internal_zone_name" {
    description = "The internal hosted zone name"
    default = "internal.smartcolumbusos.com"
}

variable "aip_dns_enabled" {
    description = "Variable to allow feature toggling this file"
    default = false
}

variable "ns_records" {
    description = "List of NS records"
    type = list(string)
    default = [""]
}

variable "ns_record_name" {
  description = "The name of the ns record"
  default = ""
}

variable "alm_role_arn" {
  description = "The ARN for the assume role for ALM access"
  default     = "arn:aws:iam::199837183662:role/jenkins_role"
}

variable "alm_region" {
  description = "Region of ALM resources"
  default     = "us-east-2"
}