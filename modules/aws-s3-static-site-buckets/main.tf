//=================================================================================
//Subdomain Bucket Configurations
//=================================================================================
resource "aws_s3_bucket" "subbucket" {
    bucket = var.subdomain_bucket_name

    tags = {
        Name = "Cloud Resume Subdomain Bucket"
        Environment = "Prod"
    }
}

resource "aws_s3_bucket_acl" "subACL" {
    bucket = aws_s3_bucket.subbucket.id
    acl = "private"
}

resource "aws_s3_bucket_public_access_block" "subdomain_bucket_public_acces" {
  bucket = aws_s3_bucket.subbucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "cloudfront_subdomain_policy" {
    bucket = aws_s3_bucket.subbucket.id
    policy = data.aws_iam_policy_document.cloudfront_subdomain_policy.json
}

data "aws_iam_policy_document" "cloudfront_subdomain_policy" {
    statement {
        principals {
          type = "Service"
          identifiers = ["cloudfront.amazonaws.com"]
        }
        actions = [
            "s3:GetObject",
        ]
        resources = ["${aws_s3_bucket.subbucket.arn}/*"]
        condition {
          test = "StringEquals"
          variable = "AWS:SourceArn"
          values = [var.subdomain_dist_arn]
        }

    }
}


//=================================================================================
//Root Domain Bucket Configuration (For web redirect only)
//=================================================================================
resource "aws_s3_bucket" "rootbucket" {
    bucket = var.rootdomain_bucket_name

    tags = {
        Name = "Cloud Resume Root Bucket"
        Environment = "Prod"
    }
}

resource "aws_s3_bucket_acl" "rootACL" {
    bucket = aws_s3_bucket.rootbucket.id
    acl = "private"
}

resource "aws_s3_bucket_public_access_block" "root_bucket_public_acces" {
  bucket = aws_s3_bucket.rootbucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_website_configuration" "webbucket" {
    bucket = aws_s3_bucket.rootbucket.id

    redirect_all_requests_to {
        host_name = "www.trevorscloudresume.com"
        protocol = "https"
    }
}

//=================================================================================
//Bucket Objects (Stored in subdomain bucket only)
//=================================================================================
resource "aws_s3_object" "html" {
    key = "index.html"
    bucket = aws_s3_bucket.subbucket.id
    source = "src/index.html"
    server_side_encryption = "AES256"
    etag = filemd5("src/index.html")
    content_type = "text/html"
}

resource "aws_s3_object" "css" {
    key = "styles.css"
    bucket = aws_s3_bucket.subbucket.id
    source = "src/styles.css"
    server_side_encryption = "AES256"
    etag = filemd5("src/styles.css")
    content_type = "text/css"
}

resource "aws_s3_object" "js" {
    key = "index.js"
    bucket = aws_s3_bucket.subbucket.id
    source = "src/index.js"
    server_side_encryption = "AES256"
    etag = filemd5("src/index.js")
    content_type = "application/x-javascript"
}