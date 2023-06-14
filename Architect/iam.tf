#######################-S3 User-#######################
resource "aws_iam_user" "s3_user_cli" {
  name = "s3_user_cli"
}

#######################-S3 User key-#######################
resource "aws_iam_access_key" "s3_user_cli_key" {
  user = aws_iam_user.s3_user_cli.name
}

#######################-Create policy-#######################
resource "aws_iam_policy" "full_access_s3_policy" {
  name_prefix = "s3_policy_"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:*"
        ]
        Resource = [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      }
    ]
  })
}

#######################-Attach policy-#######################
resource "aws_iam_policy_attachment" "s3_policy_attachment" {
  name       = "s3_policy_attachment"
  policy_arn = aws_iam_policy.full_access_s3_policy.arn
  users      = [aws_iam_user.s3_user_cli.name]
}
