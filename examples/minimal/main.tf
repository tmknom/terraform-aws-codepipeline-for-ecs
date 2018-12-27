module "codepipeline" {
  source               = "../../"
  name                 = "example"
  artifact_bucket_name = "${aws_s3_bucket.artifact.id}"
  github_oauth_token   = "${var.github_token}"
  repository_owner     = "${var.github_organization}"
  repository_name      = "terraform-aws-codepipeline-for-ecs"
  project_name         = "${module.codebuild.codebuild_project_id}"
  cluster_name         = "${aws_ecs_cluster.default.name}"
  service_name         = "${module.ecs_fargate.ecs_service_name}"
}

module "codebuild" {
  source              = "git::https://github.com/tmknom/terraform-aws-codebuild.git?ref=tags/1.2.0"
  name                = "codepipeline-for-ecs"
  artifact_bucket_arn = "${aws_s3_bucket.artifact.arn}"

  buildspec = "examples/minimal/buildspec.yml"
}

resource "aws_s3_bucket" "artifact" {
  bucket        = "artifact-codepipeline-for-ecs-${data.aws_caller_identity.current.account_id}"
  acl           = "private"
  force_destroy = true
}

module "ecs_fargate" {
  source                    = "git::https://github.com/tmknom/terraform-aws-ecs-fargate.git?ref=tags/1.1.0"
  name                      = "codepipeline-for-ecs"
  container_name            = "${local.container_name}"
  container_port            = "${local.container_port}"
  cluster                   = "${aws_ecs_cluster.default.arn}"
  subnets                   = ["${module.vpc.public_subnet_ids}"]
  target_group_arn          = "${module.alb.alb_target_group_arn}"
  vpc_id                    = "${module.vpc.vpc_id}"
  container_definitions     = "${data.template_file.default.rendered}"
  ecs_task_execution_policy = "${data.aws_iam_policy.ecs_task_execution.policy}"

  desired_count                     = 1
  assign_public_ip                  = true
  health_check_grace_period_seconds = 60
}

data "template_file" "default" {
  template = "${file("${path.module}/container_definitions.json")}"

  vars {
    container_name = "${local.container_name}"
    container_port = "${local.container_port}"
    image          = "${module.ecr.ecr_repository_url}:latest"
  }
}

locals {
  container_name = "example"
  container_port = "${module.alb.alb_target_group_port}"
}

resource "aws_ecs_cluster" "default" {
  name = "default"
}

data "aws_iam_policy" "ecs_task_execution" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

module "ecr" {
  source          = "git::https://github.com/tmknom/terraform-aws-ecr.git?ref=tags/1.0.0"
  name            = "codepipeline-for-ecs"
  tag_prefix_list = ["release"]
}

module "alb" {
  source                     = "git::https://github.com/tmknom/terraform-aws-alb.git?ref=tags/1.4.1"
  name                       = "codepipeline-for-ecs"
  vpc_id                     = "${module.vpc.vpc_id}"
  subnets                    = ["${module.vpc.public_subnet_ids}"]
  access_logs_bucket         = "${module.s3_lb_log.s3_bucket_id}"
  enable_https_listener      = false
  enable_http_listener       = true
  enable_deletion_protection = false
}

module "s3_lb_log" {
  source                = "git::https://github.com/tmknom/terraform-aws-s3-lb-log.git?ref=tags/1.0.0"
  name                  = "s3-lb-log-codepipeline-for-ecs-${data.aws_caller_identity.current.account_id}"
  logging_target_bucket = "${module.s3_access_log.s3_bucket_id}"
  force_destroy         = true
}

module "s3_access_log" {
  source        = "git::https://github.com/tmknom/terraform-aws-s3-access-log.git?ref=tags/1.0.0"
  name          = "s3-access-log-codepipeline-for-ecs-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}

module "vpc" {
  source                    = "git::https://github.com/tmknom/terraform-aws-vpc.git?ref=tags/1.0.0"
  cidr_block                = "${local.cidr_block}"
  name                      = "codepipeline-for-ecs"
  public_subnet_cidr_blocks = ["${cidrsubnet(local.cidr_block, 8, 0)}", "${cidrsubnet(local.cidr_block, 8, 1)}"]
  public_availability_zones = ["${data.aws_availability_zones.available.names}"]
}

locals {
  cidr_block = "10.255.0.0/16"
}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

# NOTE: The GITHUB_TOKEN environment variable will be set by Makefile.
variable "github_token" {
  default = ""
}

# NOTE: The GITHUB_ORGANIZATION environment variable will be set by Makefile.
variable "github_organization" {
  default = ""
}
