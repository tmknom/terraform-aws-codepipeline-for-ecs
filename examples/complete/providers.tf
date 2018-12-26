provider "aws" {
  region = "ap-northeast-1"
}

# https://www.terraform.io/docs/providers/github/index.html
provider "github" {
  token        = "${var.github_token}"
  organization = "${var.github_organization}"
}
