
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

| Name                                                 | Description                                                                                                            |  Type   |  Default  | Required |
| ---------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- | :-----: | :-------: | :------: |
| application                                          |                                                                                                                        | string  |    n/a    |   yes    |
| common\_tags                                         |                                                                                                                        |   map   |  `<map>`  |    no    |
| custom\_iam\_s3\_policy                              | Custom IAM policy for S3 - must be a implemented as a json document                                             | string  |   `""`    |    no    |
| default\_bucket\_policy\_statement                   | A JSON IAM policy statement                                                                                            | string  |   `""`    |    no    |
| enable\_cloudtrail                                   | Enabling CloudTrail will effectively invalidate all set    bucket permissions except those required for AWS CloudTrail | string  | `"false"` |    no    |
| environment\_name                                    | Name of the Worldpay environment, eg TEST, DEVL, PPRD                                                                  | string  |    n/a    |   yes    |
| force\_destroy                                       |                                                                                                                        | string  | `"false"` |    no    |
| gitrepo                                              |                                                                                                                        | string  |    n/a    |   yes    |
| instance\_names                                      |                                                                                                                        |  list   | `<list>`  |    no    |
| kms\_master\_key\_id                                 | Set this to the value of the KMS key id. If this parameter is empty the default KMS master key is used                 | string  |   `""`    |    no    |
| lifecycle\_days\_to\_expiration                      | Specifies the number of days after object creation when the specific rule action takes effect                          | string  |  `"30"`   |    no    |
| lifecycle\_days\_to\_glacier\_transition             | Specifies the number of days after object creation when the specific rule action takes effect                          | string  |  `"90"`   |    no    |
| lifecycle\_days\_to\_infrequent\_storage\_transition | Specifies the number of days after object creation when the specific rule action takes effect                          | string  |  `"60"`   |    no    |
| lifecycle\_expiration\_enabled                       | Enable/disable lifecycle expiration of objects (e.g. `true` or `false`)                                                | string  | `"false"` |    no    |
| lifecycle\_expiration\_object\_prefix                | Prefix of the identification of one or more objects to which the rule applies                                          | string  |   `""`    |    no    |
| lifecycle\_glacier\_object\_prefix                   | Prefix of the identification of one or more objects to which the rule applies                                          | string  |   `""`    |    no    |
| lifecycle\_glacier\_transition\_enabled              | Enable/disable lifecycle expiration of objects (e.g. `true` or `false`)                                                | string  | `"false"` |    no    |
| lifecycle\_infrequent\_storage\_object\_prefix       | Prefix of the identification of one or more objects to which the rule applies                                          | string  |   `""`    |    no    |
| lifecycle\_infrequent\_storage\_transition\_enabled  | Enable/disable lifecycle expiration of objects (e.g. `true` or `false`)                                                | string  | `"false"` |    no    |
| replication\_configuration                           | Cross region replication configuation block                                                                            |  list   | `<list>`  |    no    |
| role                                                 |                                                                                                                        | string  |    n/a    |   yes    |
| s3\_bucket\_force\_destroy                           |                                                                                                                        | string  |    n/a    |   yes    |
| s3\_bucket\_name                                     | The name of the bucket                                                                                                 | string  |   `""`    |    no    |
| user\_cross\_account\_arns                           |                                                                                                                        |   map   |  `<map>`  |    no    |
| user\_ingester\_arns                                 |                                                                                                                        |   map   |  `<map>`  |    no    |
| versioning                                           | Enable bucket versioning of objects                                                                                    | string  | `"false"` |    no    |
| enable_logging                                       | enable logging for the bucket                                                                                          | boolean |  `false`  |    no    |
| logging_bucket                                       | Bucket to send logs to if enable_logging enabled                                                                       | string  |   `""`    |    no    |
| contains_pii_data                                    | Identify whether this bucket containers PII data                                                                       | boolean |    n/a    |   yes    |
| enable_restricted_bucket_access                      | Enables the policy to deny all GetObject requests except for IDs specified in s3_restricted_access_ids                 | boolean |  `false`  |    no    |
| s3_restricted_access_ids                             | List of role / user IDs to allow access to GetObject from S3 bucket                                                    |  list   |   `[]`    |    no    |
| enable_whitelists | Enable whitelist feature | boolean | false | no |
| ip_whitelist_worldpay_ips | List of WorldPay IP addresses to whitelist | list | `["63.32.67.110/32"]` | no |
| ip_whitelist_vpce | List of VPC Endpoint IDs to whitelist | list | `[]` | no |
| vpc_ids_whitelist | VPC IDs to whitelist | list | `[]` | no |


## Outputs

| Name                 | Description |
| -------------------- | ----------- |
| arn                  |             |
| bucket\_domain\_name |             |
| id                   |             |
| region               |             |

