data "aws_iam_policy_document" "vault_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type        = "Service"
    }
  }
}


data "aws_iam_policy_document" "vault_policy_document" {
  statement {
    sid       = "VaultPolicyDocument"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey",
      "ec2:DescribeInstances"
    ]
  }

  statement {
    sid       = "SecretsBucketAccess"
    effect    = "Allow"
    resources = [
      "arn:aws:s3:::${var.secrets_bucket_name}/*",
      "arn:aws:s3:::${var.secrets_bucket_name}"
    ]

    actions = [
      "s3:GetObject"
    ]
  }
}

resource "aws_iam_role" "vault_role" {
  name               = "vault-role-${var.component}-${var.deployment_identifier}"
  assume_role_policy = data.aws_iam_policy_document.vault_assume_role.json
}

resource "aws_iam_role_policy" "vault_policy" {
  name   = "vault-policy-${var.component}-${var.deployment_identifier}"
  role   = aws_iam_role.vault_role.id
  policy = data.aws_iam_policy_document.vault_policy_document.json
}
