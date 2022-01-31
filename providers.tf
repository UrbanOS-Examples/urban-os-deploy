terraform {
  backend "s3" {
    key     = "urban-os"
    encrypt = true
  }
}

data "aws_eks_cluster" "urban_os_cluster" {
  name = local.eks_cluster_name
}

provider "helm" {
  version = ">= 2.1"
  kubernetes {
    host                   = data.aws_eks_cluster.urban_os_cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.urban_os_cluster.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args = [
        "token",
        "-i", local.eks_cluster_name,
        "-r", var.os_role_arn
      ]
      command = "aws-iam-authenticator"
    }
  }
}

provider "aws" {
  version = "~> 3.0"
  region  = var.os_region

  assume_role {
    role_arn = var.os_role_arn
  }
}