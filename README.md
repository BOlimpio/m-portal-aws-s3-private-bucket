
# A Terraform module to provision a private s3 Bucket

This is a security hardened s3 module that follows the least privilege security model as described in the document [Cloud Data Platform (CDP) – Cloud Data Lake (CDL) - S3](https://gsp.worldpay.com/sites/DTS/Cloud_Data_Platform/_layouts/15/WopiFrame2.aspx?sourcedoc={df9b639d-a9e9-41e4-9eda-e7aa8b28e452}&action=view&wdAccPdf=0&wdparaid=5810107A)

## Usage
```
module "s3_private_bucket" {
  source            = "git:ssh://git@github.devops.worldpay.local:EDP/tf-common-modules//s3"
  s3_bucket_name    = "XXXXXXXXX-private_bucket"
  versioning        = true
  user_ingester_arns {
      "arn:aws:iam:::users/salesforce" = ["s3:PutObject"]
  }
}

module "s3_cloudtrail_bucket" {
  source            = "git:ssh://git@github.devops.worldpay.local:EDP/tf-common-modules//s3"
  s3_bucket_name    = "XXXXXXXXX-cloudtrail"
  versioning     = true
  enable_cloudtrail = true
}
```

A full working example can be found in [example/434844845806](https://github.devops.worldpay.local/EDP/tf-common-modules/tree/master/s3/example/434844845806) folder.

__NOTE__:

This module creates a private s3 bucket by utilizing the [Amazons S3 Block Public Access](https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html). If an attempt is made to create a bucket policy with public bucket or object access it will fail.  That secures both the bucket and its contents from ever being made publically available.

## Dependency

This module has the following dependencies which are required to be referenced:

https://github.devops.worldpay.local/EDP/tf-aws-module-tag-label

## Inputs

| Variable                                  | Description                                                                                                       | Type         | Default                          | Required   |
| ----------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ------------ | -------------------------------- | ---------- |
| `s3_bucket_name`                          | The name of the bucket                                                                                            | string       | ""                               | Yes        |
| `enable_default_policy`                   | Enable or disable the default IAM policy for the S3 bucket. When enabled, it enforces secure practices for object uploads and HTTPS connections. | bool         | false                            | No         |
| `lifecycle_glacier_ir_object_prefix`      | Prefix of the identification of one or more objects to which the rule applies                                     | string       | ""                               | No         |
| `lifecycle_glacier_ir_transition_enabled` | Enable/disable lifecycle expiration of objects (e.g., `true` or `false`)                                          | bool         | false                            | No         |
| `lifecycle_days_to_glacier_ir_transition` | Specifies the number of days after object creation when the specific rule action takes effect                      | number       | 90                               | No         |
| `lifecycle_days_to_expiration`            | Specifies the number of days after object creation when the specific rule action takes effect                      | number       | 30                               | No         |
| `lifecycle_days_to_glacier_transition`    | Specifies the number of days after object creation when the specific rule action takes effect                      | number       | 90                               | No         |
| `lifecycle_days_to_infrequent_storage_transition` | Specifies the number of days after object creation when the specific rule action takes effect              | number       | 60                               | No         |
| `lifecycle_expiration_enabled`            | Enable/disable lifecycle expiration of objects (e.g., `true` or `false`)                                          | bool         | false                            | No         |
| `lifecycle_expiration_object_prefix`      | Prefix of the identification of one or more objects to which the rule applies                                     | string       | ""                               | No         |
| `lifecycle_glacier_object_prefix`         | Prefix of the identification of one or more objects to which the rule applies                                     | string       | ""                               | No         |
| `lifecycle_glacier_transition_enabled`    | Enable/disable lifecycle expiration of objects (e.g., `true` or `false`)                                          | bool         | false                            | No         |
| `lifecycle_infrequent_storage_object_prefix` | Prefix of the identification of one or more objects to which the rule applies                                  | string       | ""                               | No         |
| `lifecycle_infrequent_storage_transition_enabled` | Enable/disable lifecycle expiration of objects (e.g., `true` or `false`)                                  | bool         | false                            | No         |
| `versioning`                              | Enable bucket versioning of objects: Enabled or Disabled                                                           | string       | "Disabled"                       | No         |
| `kms_master_key_id`                       | Set this to the value of the KMS key id. If this parameter is empty, the default KMS master key is used         | string       | ""                               | No         |
| `attach_custom_policy`                    | Flag to determine whether to attach a custom policy                                                                | bool         | false                            | No         |
| `custom_iam_s3_policy`                    | Custom IAM policy for S3                                                                                         | string       | ""                               | No         |
| `force_destroy`                           | When true, forces the destruction of the S3 bucket and all its content. Use with caution.                        | bool         | false                            | No         |
| `allowed_resource_arns`                   | List of ARNs for allowed resources                                                                                | list(string) | []                               | No         |
| `enable_restricted_bucket_access`          | Whether to run the policy for s3_restricted_access_ids                                                            | bool         | false                            | No         |
| `enable_whitelists`                       | Whether to enable IP whitelisting                                                                                | bool         | false                            | No         |
| `generic_policy_entries`                  | List of entries for the generic policy                                                                           | list(object) | []                               | No         |
| `ip_whitelist`                            | List of whitelisted IP addresses                                                                                | list(string) | []                               | No         |
| `vpc_ids_whitelist`                       | List of VPC IDs to whitelist for S3 access                                                                      | list(string) | []                               | No         |
| `ip_whitelist_vpce`                       | List of extra VPC Endpoint IDs to allow access to S3                                                             | list(string) | []                               | No         |
| `whitelist_actions`                       | Actions that are denied by the whitelist                                                                        | list(string) | ["s3:PutObject*", "s3:GetObject*"] | No         |
| `enable_deny_unencrypted_object_uploads`  | Whether to enforce Encrypted Object Uploads                                                                      | bool         | true                             | No         |
| `additional_tags`                         | A map of additional tags to add to the S3 bucket.                                                                | map(string)   | {}                               | No         |

## Outputs

| Name                 | Description |
| -------------------- | ----------- |
| arn                  |             |
| bucket\_domain\_name |             |
| id                   |             |
| region               |             |

