output "codepipeline_id" {
  value       = "${aws_codepipeline.default.id}"
  description = "The codepipeline ID."
}

output "codepipeline_arn" {
  value       = "${aws_codepipeline.default.arn}"
  description = "The codepipeline ARN."
}

output "codepipeline_webhook_id" {
  value       = "${aws_codepipeline_webhook.default.id}"
  description = "The CodePipeline webhook's ARN."
}

output "codepipeline_webhook_url" {
  value       = "${aws_codepipeline_webhook.default.url}"
  description = "The CodePipeline webhook's URL. POST events to this endpoint to trigger the target."
}

output "github_repository_webhook_url" {
  value       = "${github_repository_webhook.default.url}"
  description = "URL of the webhook."
}

output "iam_role_arn" {
  value       = "${aws_iam_role.default.arn}"
  description = "The Amazon Resource Name (ARN) specifying the IAM Role."
}

output "iam_role_create_date" {
  value       = "${aws_iam_role.default.create_date}"
  description = "The creation date of the IAM Role."
}

output "iam_role_unique_id" {
  value       = "${aws_iam_role.default.unique_id}"
  description = "The stable and unique string identifying the IAM Role."
}

output "iam_role_name" {
  value       = "${aws_iam_role.default.name}"
  description = "The name of the IAM Role."
}

output "iam_role_description" {
  value       = "${aws_iam_role.default.description}"
  description = "The description of the IAM Role."
}

output "iam_policy_id" {
  value       = "${aws_iam_policy.default.id}"
  description = "The IAM Policy's ID."
}

output "iam_policy_arn" {
  value       = "${aws_iam_policy.default.arn}"
  description = "The ARN assigned by AWS to this IAM Policy."
}

output "iam_policy_description" {
  value       = "${aws_iam_policy.default.description}"
  description = "The description of the IAM Policy."
}

output "iam_policy_name" {
  value       = "${aws_iam_policy.default.name}"
  description = "The name of the IAM Policy."
}

output "iam_policy_path" {
  value       = "${aws_iam_policy.default.path}"
  description = "The path of the IAM Policy."
}

output "iam_policy_document" {
  value       = "${aws_iam_policy.default.policy}"
  description = "The policy document of the IAM Policy."
}
