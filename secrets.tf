resource "random_string" "discovery_api_presign_key" {
  length           = 64
  special          = true
  override_special = "/@$#*"
}

resource "random_string" "discovery_api_guardian_key" {
  length           = 64
  special          = true
  override_special = "/@$#*"
}

resource "random_password" "vault_admin_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

data "aws_secretsmanager_secret_version" "andi_rds_password" {
  secret_id = data.aws_secretsmanager_secret.andi_rds_password_id.id
}

data "aws_secretsmanager_secret" "andi_rds_password_id" {
  name = "${terraform.workspace}-andi-postgres-rds-password"
}

data "aws_secretsmanager_secret_version" "metastore_rds_password" {
  secret_id = data.aws_secretsmanager_secret.metastore_rds_password_id.id
}

data "aws_secretsmanager_secret" "metastore_rds_password_id" {
  name = "${terraform.workspace}-metastore-rds-password"
}

data "aws_secretsmanager_secret_version" "discovery_postgres_rds_password" {
  secret_id = data.aws_secretsmanager_secret.discovery_postgres_rds_password_id.id
}

data "aws_secretsmanager_secret" "discovery_postgres_rds_password_id" {
  name = "${terraform.workspace}-discovery-postgres-rds-password"
}

data "aws_secretsmanager_secret" "andi_auth0_client_secret_name" {
  name = "${terraform.workspace}-andi-auth0-client-secret"
}

data "aws_secretsmanager_secret_version" "andi_auth0_client_secret" {
  secret_id = data.aws_secretsmanager_secret.andi_auth0_client_secret_name.id
}

data "aws_secretsmanager_secret" "raptor_auth0_client_secret_name" {
  name = "${terraform.workspace}-raptor-auth0-client-secret"
}

data "aws_secretsmanager_secret_version" "raptor_auth0_client_secret" {
  secret_id = data.aws_secretsmanager_secret.raptor_auth0_client_secret_name.id
}

resource "aws_iam_access_key" "andi" {
  user = local.andi_aws_user_name
}

resource "aws_iam_access_key" "odo" {
  user = local.odo_aws_user_name
}

resource "aws_iam_access_key" "reaper" {
  user = local.reaper_aws_user_name
}

resource "aws_iam_access_key" "discovery_api" {
  user = local.discovery_api_aws_user_name
}