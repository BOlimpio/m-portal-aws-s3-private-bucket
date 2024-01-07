# module "s3-bucket-decompress-upload" {
#   source                              = "git::https://github.worldpay.com/DTS/tf-module-s3-logging.git?ref=DE572453-deprecate-bad-policy"
#   s3_bucket_name                      = "${var.tier}-${var.product}-decompress-upload"
#   versioning                          = false
#   application                         = "Ethos"
#   role                                = "Storage"
#   environment_name                    = var.common_tags["Tier"]
#   gitrepo                             = var.gitrepo
#   common_tags                         = merge(var.common_tags, { Description = "Provides an upload location for files that need to be untarred" })
#   contains_pii_data                   = true
#   s3_bucket_force_destroy             = false
#   kms_master_key_id                   = data.aws_kms_key.upload_kms_key_alias.arn
#   s3_restricted_access_ids            = var.s3_allowed_ids
#   enable_restricted_bucket_access     = false
#   enable_whitelists                   = false
#   logging_bucket                      = var.s3_access_logs_bucket_name
#   enable_DenyUnEncryptedObjectUploads = false
#   ip_whitelists                       = var.ip_whitelists
#   disable_default_policy              = true

#   user_ingester_arns = {
#     (data.aws_iam_role.airflow_iamserviceaccount.arn) = "s3:PutObject,s3:GetObject,s3:GetBucketTagging,s3:AbortMultipartUpload,s3:ListBucketVersions,s3:GetObjectTagging,s3:ListBucket,s3:DeleteObject,s3:GetObjectVersion,s3:ListMultipartUploadParts"
#   }
# }

provider "aws" {
  region = "us-east-1"  # Substitua pela sua região desejada
}

module "s3_example" {
  source = "./modules/s3"

  s3_bucket_name = "example-bucket"
  environment    = "dev"

  enable_default_policy = true

  # Adicionando uma política customizada
  custom_iam_s3_policy_statement = [
    {
      Sid       = "AllowReadForSpecificUsers",
      Effect    = "Allow",
      Principal = { AWS = ["arn:aws:iam::123456789012:user/user1", "arn:aws:iam::123456789012:user/user2"] },
      Action    = ["s3:GetObject"],
      Resource  = ["arn:aws:s3:::example-bucket/*"],
    },
  ]

  lifecycle_infrequent_storage_transition_enabled = true
  lifecycle_days_to_infrequent_storage_transition  = 30
  lifecycle_infrequent_storage_object_prefix = "infrequent/"

  enable_whitelists = true
  ip_whitelist      = ["192.168.1.1/32"]
  whitelist_actions = ["s3:GetObject"]
}
