# terraform-aws-codepipeline-for-ecs

[![CircleCI](https://circleci.com/gh/tmknom/terraform-aws-codepipeline-for-ecs.svg?style=svg)](https://circleci.com/gh/tmknom/terraform-aws-codepipeline-for-ecs)
[![GitHub tag](https://img.shields.io/github/tag/tmknom/terraform-aws-codepipeline-for-ecs.svg)](https://registry.terraform.io/modules/tmknom/codepipeline-for-ecs/aws)
[![License](https://img.shields.io/github/license/tmknom/terraform-aws-codepipeline-for-ecs.svg)](https://opensource.org/licenses/Apache-2.0)

Terraform module template following [Standard Module Structure](https://www.terraform.io/docs/modules/create.html#standard-module-structure).

## Usage

Named `terraform-<PROVIDER>-<NAME>`. Module repositories must use this three-part name format.

```sh
curl -fsSL https://raw.githubusercontent.com/tmknom/terraform-aws-codepipeline-for-ecs/master/install | sh -s terraform-aws-sample
cd terraform-aws-sample && make install
```

## Examples

- [Minimal](https://github.com/tmknom/terraform-aws-codepipeline-for-ecs/tree/master/examples/minimal)
- [Complete](https://github.com/tmknom/terraform-aws-codepipeline-for-ecs/tree/master/examples/complete)

## Inputs

| Name                    | Description                                              |  Type  |         Default         | Required |
| ----------------------- | -------------------------------------------------------- | :----: | :---------------------: | :------: |
| artifact_bucket_name    | The S3 Bucket name of artifacts.                         | string |            -            |   yes    |
| cluster_name            | The name of the ECS Cluster.                             | string |            -            |   yes    |
| github_oauth_token      | The OAuth Token of GitHub.                               | string |            -            |   yes    |
| name                    | The name of the pipeline.                                | string |            -            |   yes    |
| project_name            | The project name of the CodeBuild.                       | string |            -            |   yes    |
| repository_name         | The name of the repository.                              | string |            -            |   yes    |
| repository_owner        | The owner of the repository.                             | string |            -            |   yes    |
| secret_token            | The secret token for the GitHub webhook.                 | string |            -            |   yes    |
| service_name            | The name of the ECS Service.                             | string |            -            |   yes    |
| branch                  | The name of the branch.                                  | string |        `master`         |    no    |
| description             | The description of the all resources.                    | string | `Managed by Terraform`  |    no    |
| encryption_key_id       | The KMS key ARN or ID.                                   | string |         `` | no         |
| file_name               | The file name of the image definitions.                  | string | `imagedefinitions.json` |    no    |
| filter_json_path        | The JSON path to filter on.                              | string |         `$.ref`         |    no    |
| filter_match_equals     | The value to match on (e.g. refs/heads/{Branch}).        | string |  `refs/heads/{Branch}`  |    no    |
| iam_path                | Path in which to create the IAM Role and the IAM Policy. | string |           `/`           |    no    |
| poll_for_source_changes | Specify true to indicate that periodic checks enabled.   | string |         `false`         |    no    |
| tags                    | A mapping of tags to assign to all resources.            |  map   |          `{}`           |    no    |
| webhook_events          | A list of events which should trigger the webhook.       |  list  |      `[ "push" ]`       |    no    |

## Outputs

| Name                          | Description                                                                         |
| ----------------------------- | ----------------------------------------------------------------------------------- |
| codepipeline_arn              | The codepipeline ARN.                                                               |
| codepipeline_id               | The codepipeline ID.                                                                |
| codepipeline_webhook_id       | The CodePipeline webhook's ARN.                                                     |
| codepipeline_webhook_url      | The CodePipeline webhook's URL. POST events to this endpoint to trigger the target. |
| github_repository_webhook_url | URL of the webhook.                                                                 |
| iam_policy_arn                | The ARN assigned by AWS to this IAM Policy.                                         |
| iam_policy_description        | The description of the IAM Policy.                                                  |
| iam_policy_document           | The policy document of the IAM Policy.                                              |
| iam_policy_id                 | The IAM Policy's ID.                                                                |
| iam_policy_name               | The name of the IAM Policy.                                                         |
| iam_policy_path               | The path of the IAM Policy.                                                         |
| iam_role_arn                  | The Amazon Resource Name (ARN) specifying the IAM Role.                             |
| iam_role_create_date          | The creation date of the IAM Role.                                                  |
| iam_role_description          | The description of the IAM Role.                                                    |
| iam_role_name                 | The name of the IAM Role.                                                           |
| iam_role_unique_id            | The stable and unique string identifying the IAM Role.                              |

## Development

### Requirements

- [Docker](https://www.docker.com/)

### Configure environment variables

```shell
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=ap-northeast-1
```

### Installation

```shell
git clone git@github.com:tmknom/terraform-aws-codepipeline-for-ecs.git
cd terraform-aws-codepipeline-for-ecs
make install
```

### Makefile targets

```text
check-format                   Check format code
cibuild                        Execute CI build
clean                          Clean .terraform
docs                           Generate docs
format                         Format code
help                           Show help
install                        Install requirements
lint                           Lint code
release                        Release GitHub and Terraform Module Registry
terraform-apply-complete       Run terraform apply examples/complete
terraform-apply-minimal        Run terraform apply examples/minimal
terraform-destroy-complete     Run terraform destroy examples/complete
terraform-destroy-minimal      Run terraform destroy examples/minimal
terraform-plan-complete        Run terraform plan examples/complete
terraform-plan-minimal         Run terraform plan examples/minimal
upgrade                        Upgrade makefile
```

### Releasing new versions

Bump VERSION file, and run `make release`.

### Terraform Module Registry

- <https://registry.terraform.io/modules/tmknom/codepipeline-for-ecs/aws>

## License

Apache 2 Licensed. See LICENSE for full details.
