terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4"
    }
  }
}

// create an iam policy that denies all iam write actions but allows a user to changer their own password
resource "aws_iam_policy" "deny_all_write_actions" {
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Deny",
        "Action": [
          "iam:Add*",
          "iam:Attach*",
          "iam:ChangePassword",
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
          "iam:Upload*"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "iam:ChangeOwnPassword"
        ],
        "Resource": "*"
      }
    ]
  })
}
