# m-portal-aws-s3-private-bucket
This Terraform module facilitates the creation of an S3 bucket on AWS with customizable policies, storage transitions, and more. 
**For additional resources, examples, and community engagement**, check out the portal [Cloud Collab Hub](https://cloudcollab.com) :cloud:.

## Usage
**Loading...** ⌛

For more detailed examples and use cases, check out the files in the how-to-usage directory. They provide additional scenarios and explanations for leveraging the features of the aws_s3_private_bucket module.

## Module Inputs

Certainly! Here's the table of inputs for your S3 bucket module with an additional column for "required":

| Variable                                      | Type               | Description                                                                                                 | Default       | Required |
|-----------------------------------------------|--------------------|-------------------------------------------------------------------------------------------------------------|---------------|----------|
| s3_bucket_name                                | string             | The name of the bucket                                                                                       | ""            | Yes      |
| enable_default_policy                         | bool               | Enable or disable the default IAM policy for the S3 bucket. When enabled, it enforces secure practices for object uploads and HTTPS connections.                | false         | No       |
| lifecycle_glacier_ir_object_prefix            | string             | Prefix of the identification of one or more objects to which the rule applies                                 | ""            | No       |
| lifecycle_glacier_ir_transition_enabled       | bool               | Enable/disable lifecycle expiration of objects (e.g. `true` or `false`)                                      | false         | No       |
| lifecycle_days_to_glacier_ir_transition       | number             | Specifies the number of days after object creation when the specific rule action takes effect                | 90            | No       |
| lifecycle_days_to_expiration                  | number             | Specifies the number of days after object creation when the specific rule action takes effect                | 30            | No       |
| lifecycle_days_to_glacier_transition          | number             | Specifies the number of days after object creation when the specific rule action takes effect                | 90            | No       |
| lifecycle_days_to_infrequent_storage_transition| number             | Specifies the number of days after object creation when the specific rule action takes effect                | 60            | No       |
| lifecycle_expiration_enabled                  | bool               | Enable/disable lifecycle expiration of objects (e.g. `true` or `false`)                                      | false         | No       |
| lifecycle_expiration_object_prefix            | string             | Prefix of the identification of one or more objects to which the rule applies                                 | ""            | No       |
| lifecycle_glacier_object_prefix               | string             | Prefix of the identification of one or more objects to which the rule applies                                 | ""            | No       |
| lifecycle_glacier_transition_enabled          | bool               | Enable/disable lifecycle expiration of objects (e.g. `true` or `false`)                                      | false         | No       |
| lifecycle_infrequent_storage_object_prefix    | string             | Prefix of the identification of one or more objects to which the rule applies                                 | ""            | No       |
| lifecycle_infrequent_storage_transition_enabled| bool              | Enable/disable lifecycle expiration of objects (e.g. `true` or `false`)                                      | false         | No       |
| versioning                                    | string             | Enable bucket versioning of objects: Enabled or Disabled                                                      | "Disabled"    | No       |
| kms_master_key_id                             | string             | Set this to the value of the KMS key id. If this parameter is empty the default KMS master key is used       | ""            | No       |
| custom_iam_s3_policy_statement                | list(map(string)) | List of custom policy statements.                                                                           | []            | No       |
| force_destroy                                 | bool               | When true, forces the destruction of the S3 bucket and all its content. Use with caution.                    | false         | No       |
| allowed_resource_arns                         | list(string)       | List of ARNs for allowed resources                                                                          | []            | No       |
| enable_restricted_bucket_access               | bool               | Whether to run the policy for s3_restricted_access_ids                                                       | false         | No       |
| enable_whitelists                             | bool               | Whether to enable IP whitelisting                                                                           | false         | No       |
| generic_policy_entries                        | list(object({...}))| List of entries for the generic policy                                                                       | []            | No       |
| ip_whitelist                                  | list(string)       | List of whitelisted IP addresses                                                                            | []            | No       |
| vpc_ids_whitelist                             | list(string)       | List of VPC IDs to whitelist for S3 access                                                                  | []            | No       |
| ip_whitelist_vpce                             | list(string)       | List of extra VPC Endpoint IDs to allow access to S3                                                        | []            | No       |
| whitelist_actions                             | list(string)       | Actions that are denied by the whitelist                                                                    | ["s3:PutObject*", "s3:GetObject*"] | No       |
| environment                                   | string             | S3 bucket environment (e.g. DEV/TEST/UAT/PROD)                                                              | ""            | No       |
| enable_deny_unencrypted_object_uploads        | bool               | Whether to enforce Encrypted Object Uploads                                                                 | true          | No       |
| additional_tags                               | map(string)        | A map of additional tags to add to the S3 bucket.                                                            | {}            | No       |

## Module outputs

| Name            | Description                        |
|-----------------|------------------------------------|
| s3_attributes   | Attributes of the created S3 bucket |

## How to Use Output Attributes

arn = module.example_s3_bucket.s3_attributes.arn
**OR**
arn = module.example_s3_bucket.s3_attributes["arn"]

## License

This project is licensed under the MIT License - see the [MIT License](https://opensource.org/licenses/MIT) file for details.

## Contributing

Contributions are welcome! Please follow the guidance below for details on how to contribute to this project:

1. Fork the repository
2. Create a new branch: `git checkout -b feature/your-feature-name`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/your-feature-name`
5. Open a pull request
