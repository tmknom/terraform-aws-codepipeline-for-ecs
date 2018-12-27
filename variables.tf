variable "name" {
  type        = "string"
  description = "The name of the pipeline."
}

variable "artifact_bucket_name" {
  type        = "string"
  description = "The S3 Bucket name of artifacts."
}

variable "github_oauth_token" {
  type        = "string"
  description = "The OAuth Token of GitHub."
}

variable "repository_owner" {
  type        = "string"
  description = "The owner of the repository."
}

variable "repository_name" {
  type        = "string"
  description = "The name of the repository."
}

variable "project_name" {
  type        = "string"
  description = "The project name of the CodeBuild."
}

variable "cluster_name" {
  type        = "string"
  description = "The name of the ECS Cluster."
}

variable "service_name" {
  type        = "string"
  description = "The name of the ECS Service."
}

variable "secret_token" {
  default     = ""
  type        = "string"
  description = "The secret token for the GitHub webhook."
}

variable "encryption_key_id" {
  default     = ""
  type        = "string"
  description = "The KMS key ARN or ID."
}

variable "branch" {
  default     = "master"
  type        = "string"
  description = "The name of the branch."
}

variable "poll_for_source_changes" {
  default     = false
  type        = "string"
  description = "Specify true to indicate that periodic checks enabled."
}

variable "file_name" {
  default     = "imagedefinitions.json"
  type        = "string"
  description = "The file name of the image definitions."
}

variable "filter_json_path" {
  default     = "$.ref"
  type        = "string"
  description = "The JSON path to filter on."
}

variable "filter_match_equals" {
  default     = "refs/heads/{Branch}"
  type        = "string"
  description = "The value to match on (e.g. refs/heads/{Branch})."
}

variable "webhook_events" {
  default     = ["push"]
  type        = "list"
  description = "A list of events which should trigger the webhook."
}

variable "iam_path" {
  default     = "/"
  type        = "string"
  description = "Path in which to create the IAM Role and the IAM Policy."
}

variable "description" {
  default     = "Managed by Terraform"
  type        = "string"
  description = "The description of the all resources."
}

variable "tags" {
  default     = {}
  type        = "map"
  description = "A mapping of tags to assign to all resources."
}
