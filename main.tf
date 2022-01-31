resource "helm_release" "urban_os" {
  name       = "urban-os"
  repository = "https://urbanos-public.github.io/charts"
  # The following line exists to quickly be commented out
  # for local development.
  # repository       = "../charts"
  version          = "1.8.0"
  chart            = "urban-os"
  namespace        = "urban-os"
  create_namespace = true
  wait             = false

  values = [
    file("${path.module}/base.yaml"),
    file("${path.module}/variables/sandbox-${terraform.workspace}.yaml"),
    templatefile("${path.module}/variables/prometheus/scos_rules_template.tpl", jsondecode(file("${path.module}/variables/prometheus/scos_dataset_rules.json")))
  ]

  set {
    name  = "force.deployment"
    value = var.force_deployment
  }

  set_sensitive {
    name  = "vault.adminPassword"
    value = random_password.vault_admin_password.result
  }

  set {
    name  = "global.ingress.annotations.alb\\.ingress\\.kubernetes\\.io/certificate-arn"
    value = data.aws_ssm_parameter.certificate.value
  }

  set_sensitive {
    name  = "andi.postgres.password"
    value = data.aws_secretsmanager_secret_version.andi_rds_password.secret_string
  }

  set_sensitive {
    name  = "kubernetes-data-platform.postgres.db.password"
    value = data.aws_secretsmanager_secret_version.metastore_rds_password.secret_string
  }

  set {
    name  = "global.ingress.annotations.alb\\.ingress\\.kubernetes\\.io/subnets"
    value = data.aws_ssm_parameter.public_subnets.value
  }

  set_sensitive {
    name  = "global.ingress.dnsZone"
    value = local.hosted_zone
  }

  set_sensitive {
    name  = "global.ingress.rootDnsZone"
    value = local.hosted_zone
  }

  set {
    name  = "global.ingress.annotations.alb\\.ingress\\.kubernetes\\.io/security-groups"
    value = data.aws_ssm_parameter.security_groups.value
  }

  set_sensitive {
    name  = "discovery-api.secrets.discoveryApiPresignKey"
    value = random_string.discovery_api_presign_key.result
  }

  set_sensitive {
    name  = "discovery-api.secrets.guardianSecretKey"
    value = random_string.discovery_api_guardian_key.result
  }

  set_sensitive {
    name  = "discovery-api.postgres.password"
    value = data.aws_secretsmanager_secret_version.discovery_postgres_rds_password.secret_string
  }

  set {
    name  = "global.ingress.annotations.alb\\.ingress\\.kubernetes\\.io/wafv2-acl-arn"
    value = data.aws_ssm_parameter.eks_wafv2_web_acl_arn.value
  }

  set_sensitive {
    name  = "andi.auth.auth0_client_secret"
    value = data.aws_secretsmanager_secret_version.andi_auth0_client_secret.secret_string
  }

  set_sensitive {
    name  = "raptor.auth.auth0_client_secret"
    value = data.aws_secretsmanager_secret_version.raptor_auth0_client_secret.secret_string
  }

  set_sensitive {
    name  = "andi.aws.accessKeySecret"
    value = aws_iam_access_key.andi.secret
  }

  set_sensitive {
    name  = "reaper.aws.accessKeySecret"
    value = aws_iam_access_key.reaper.secret
  }

  set_sensitive {
    name  = "odo.aws.accessKeySecret"
    value = aws_iam_access_key.odo.secret
  }

  set_sensitive {
    name  = "discovery-api.aws.accessKeySecret"
    value = aws_iam_access_key.discovery_api.secret
  }

  set_sensitive {
    name  = "andi.aws.accessKeyId"
    value = aws_iam_access_key.andi.id
  }

  set_sensitive {
    name  = "reaper.aws.accessKeyId"
    value = aws_iam_access_key.reaper.id
  }

  set_sensitive {
    name  = "odo.aws.accessKeyId"
    value = aws_iam_access_key.odo.id
  }

  set_sensitive {
    name  = "discovery-api.aws.accessKeyId"
    value = aws_iam_access_key.discovery_api.id
  }

  set_sensitive {
    name  = "vault.adminPassword"
    value = random_password.vault_admin_password.result
  }

}
