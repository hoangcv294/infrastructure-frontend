output "cloudfront_url" {
  value = "https://${aws_cloudfront_distribution.cloudfront_fe.domain_name}"
}


output "access_key" {
  value = aws_iam_access_key.s3_user_cli_key.id
}

output "secret_key" {
  value     = aws_iam_access_key.s3_user_cli_key.secret
  sensitive = true
}