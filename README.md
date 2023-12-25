# m-portal-aws-s3-private-bucket
This Terraform module facilitates the creation of an S3 bucket on AWS with customizable policies, storage transitions, and more. 
**For additional resources, examples, and community engagement**, check out the portal [Cloud Collab Hub](https://cloudcollab.com) :cloud:.

## Usage
**Loading...** ⌛

For more detailed examples and use cases, check out the files in the how-to-usage directory. They provide additional scenarios and explanations for leveraging the features of the aws_s3_private_bucket module.

## Module Inputs

| Description                                     | Type     | Default | Required |
|-------------------------------------------------|----------|---------|----------|
| s3_bucket_name                                  | string   | ""      | yes      |
| enable_default_policy                           | bool     | false   | no       |
| lifecycle_glacier_ir_object_prefix              | string   | ""      | no       |
| lifecycle_glacier_ir_transition_enabled         | bool     | false   | no       |
| lifecycle_days_to_glacier_ir_transition         | number   | 90      | no       |
| lifecycle_days_to_expiration                     | number   | 30      | no       |
| lifecycle_days_to_glacier_transition             | number   | 90      | no       |
| lifecycle_days_to_infrequent_storage_transition  | number   | 60      | no       |
| lifecycle_expiration_enabled                     | bool     | false   | no       |
| lifecycle_expiration_object_prefix               | string   | ""      | no       |
| lifecycle_glacier_object_prefix                  | string   | ""      | no       |
| lifecycle_glacier_transition_enabled             | bool     | false   | no       |
| lifecycle_infrequent_storage_object_prefix       | string   | ""      | no       |
| lifecycle_infrequent_storage_transition_enabled  | bool     | false   | no       |
| versioning                                      | string   | "Disabled" | no     |
| kms_master_key_id                                | string   | ""      | no       |
| custom_iam_s3_policy_statement                   | list(object) | [{}] | no       |
| force_destroy                                    | bool     | false   | no       |
| allowed_resource_arns                            | list(string) | []    | no       |
| enable_restricted_bucket_access                  | bool     | false   | no       |
| enable_whitelists                                | bool     | false   | no       |
| generic_policy_entries                           | list(object) | []    | no       |
| ip_whitelist                                     | list(string) | []    | no       |
| vpc_ids_whitelist                                | list(string) | []    | no       |
| ip_whitelist_vpce                                | list(string) | []    | no       |
| whitelist_actions                                | list(string) | ["s3:PutObject*", "s3:GetObject*"] | no |
| environment                                      | string   | ""      | no       |
| enable_deny_unencrypted_object_uploads           | bool     | true    | no       |
| additional_tags                                  | map(string) | {}    | no       |

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
