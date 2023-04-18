//=================================================================================
//HTTPS Infrastructure (Subdomain Cloudfront Dist)
//=================================================================================
resource "aws_cloudfront_distribution" "subDist" {
    origin {
      domain_name = var.subdomain_bucket_regional_domain
      origin_access_control_id = aws_cloudfront_origin_access_control.subDistOAC.id
      origin_id = var.subdomain_bucket_id
    }

    default_cache_behavior {
      allowed_methods = ["HEAD", "GET"]
      cached_methods = ["HEAD", "GET"]
      target_origin_id = var.subdomain_bucket_id
      viewer_protocol_policy = "redirect-to-https"
      cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
      #origin_request_policy_id = aws_cloudfront_origin_request_policy.request_policy.id
    }

    enabled = true
    is_ipv6_enabled = true
    default_root_object = "index.html"
    aliases = ["www.trevorscloudresume.com"]
    price_class = "PriceClass_100"

    restrictions {
        geo_restriction {
            restriction_type = "none"
            locations = []
        }
    }
    viewer_certificate {
        cloudfront_default_certificate = false
        acm_certificate_arn = var.cert_arn
        minimum_protocol_version = "TLSv1.2_2021"
        ssl_support_method = "sni-only"
      
    }
}

resource "aws_cloudfront_origin_access_control" "subDistOAC" {
  name                              = var.subdomain_bucket_regional_domain
  description                       = ""
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

//=================================================================================
//=================================================================================

//=================================================================================
//HTTPS Infrastructure (Root Bucket Cloudfront Dist)
//=================================================================================
resource "aws_cloudfront_distribution" "rootDist" {
    origin {
      domain_name = var.root_website_endpoint
      origin_id = var.rootdomain_bucket_id
      custom_origin_config {
        http_port = 80
        https_port = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols = ["TLSv1.2"]
      }
    }
    default_cache_behavior {
      allowed_methods = ["HEAD", "GET"]
      cached_methods = ["HEAD", "GET"]
      target_origin_id = var.rootdomain_bucket_id
      viewer_protocol_policy = "redirect-to-https"
      //Managed cache policy -- CachingDisabled
      cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
      #origin_request_policy_id = aws_cloudfront_origin_request_policy.request_policy.id
    }
    enabled = true
    is_ipv6_enabled = true
    aliases = ["trevorscloudresume.com"]
    price_class = "PriceClass_100"

    restrictions {
        geo_restriction {
            restriction_type = "none"
            locations = []
        }
    }
    viewer_certificate {
        cloudfront_default_certificate = false
        acm_certificate_arn = var.cert_arn
        minimum_protocol_version = "TLSv1.2_2021"
        ssl_support_method = "sni-only"
      
    }
}


//=================================================================================
// Cloudfront Policies
//=================================================================================

resource "aws_cloudfront_cache_policy" "optimized_policy" {
  name = "CloudResumeCachePolicy"
  default_ttl = 86400
  min_ttl = 1
  max_ttl = 31536000
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }

    headers_config {
      header_behavior = "whitelist"
      headers {
        items = ["Origin", "Access-Control-Request-Headers", "Access-Control-Request-Method"]
      }
    }

    query_strings_config {
      query_string_behavior = "none"
    }
    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip = true
  }
}

resource "aws_cloudfront_origin_request_policy" "request_policy" {
  name = "CloudResumeOriginRequestPolicy"
  comment = "Policy to allow CORS"
  cookies_config {
    cookie_behavior = "none"
  }

  headers_config {
    header_behavior = "whitelist"
    headers {
      items = ["Access-Control-Allow-Methods","Access-Control-Allow-Headers","Access-Control-Allow-Origin"]
    }
  }

  query_strings_config {
    query_string_behavior = "none"
    }
}