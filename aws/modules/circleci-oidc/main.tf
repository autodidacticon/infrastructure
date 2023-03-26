terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4"
    }
  }
}

data "aws_default_tags" "tags" {}

locals {
  circleci_oidc_url = "oidc.circleci.com/org/${var.circleci_organization_id}"

  tags = {for key, value in var.tags : key => value if lookup(data.aws_default_tags.tags.tags, key, null) != value}
}

resource "aws_iam_openid_connect_provider" "circleci" {
  url = "https://${local.circleci_oidc_url}"

  client_id_list = [
    var.circleci_organization_id,
  ]

  thumbprint_list = [for thumbprint in var.thumbprints : lower(replace(thumbprint, ":", ""))]

  tags = local.tags
}

data "aws_iam_policy_document" "allow_circleci_oidc_assume" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.circleci.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.circleci_oidc_url}:aud"
      values   = [var.circleci_organization_id]
    }
  }
}

data "aws_iam_policy_document" "deny_iam_write_access" {
  statement {
    actions = [
      "iam:Add*",
      "iam:Attach*",
      "iam:Change*",
      "iam:Create*",
      "iam:Deactivate*",
      "iam:Delete*",
      "iam:Detach*",
      "iam:Enable*",
      "iam:Put*",
      "iam:Remove*",
      "iam:Reset*",
      "iam:Resync*",
      "iam:Set*",
      "iam:Tag*",
      "iam:Untag*",
      "iam:Update*",
      "iam:Upload*",
    ]

    resources = ["*"]

    effect = "Deny"
  }
}

resource "aws_iam_policy" "deny_iam_write_access" {
  policy = data.aws_iam_policy_document.deny_iam_write_access.json
}

resource "aws_iam_role" "circleci" {
  name                = "CircleCI"
  assume_role_policy  = data.aws_iam_policy_document.allow_circleci_oidc_assume.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
    aws_iam_policy.deny_iam_write_access.arn,
  ]
}