# S3 Bucket: Enable Hosting Static Web
resource "aws_s3_bucket" "frontend_test" {
  bucket = var.bucket_name
  tags = {
    Name = "build frontend"
  }
}

resource "aws_s3_bucket_acl" "frontend_test_acl" {
  bucket = aws_s3_bucket.frontend_test.id
  acl    = "private"
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "frontend_test_public_access_block" {
  bucket = aws_s3_bucket.frontend_test.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning to maintain object history
resource "aws_s3_bucket_versioning" "frontend_test_versioning" {
  bucket = aws_s3_bucket.frontend_test.id
  versioning_configuration {
    status = "Enabled"
  }
}

# resource "aws_s3_bucket_website_configuration" "frontend_test_configuration" {
#   bucket = aws_s3_bucket.frontend_test.id

#   index_document {
#     suffix = "index.html"
#   }

#   error_document {
#     key = "index.html"
#   }
# }

resource "aws_s3_bucket_policy" "frontend_test" {
  bucket = aws_s3_bucket.frontend_test.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Grant CloudFront access to bucket"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = [
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.frontend_test.arn}/*"
        ]
      }
    ]
  })
}