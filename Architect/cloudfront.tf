
#######################-Create CloudFront distribution for S3 bucket-#######################
resource "aws_cloudfront_distribution" "cloudfront_fe" {
  origin {
    domain_name = aws_s3_bucket.cloudfront_fe.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.cloudfront_fe.id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cloudfront_fe.cloudfront_access_identity_path
    }
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.cloudfront_fe.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.frontend_cloudfront_cert.arn
    ssl_support_method  = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }

  aliases = [
    "frontend.${var.domain_name}"
  ]
}
resource "aws_cloudfront_origin_access_identity" "cloudfront_fe" {
  comment = "Access identity for the tool check Frontend"
}
