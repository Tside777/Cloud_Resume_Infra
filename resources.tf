//Subdomain Bucket Configurations
resource "aws_s3_bucket" "subbucket" {
    bucket = "www.trevors-cloud-resume-terraform-bucket"

    tags = {
        Name = "Cloud Resume Subdomain Bucket"
        Environment = "Prod"
    }
}

resource aws_s3_bucket_acl "subACL" {
    bucket = aws_s3_bucket.subbucket.id
    acl = "private"
}



//Root Domain Bucket Configuration
resource "aws_s3_bucket" "rootbucket" {
    bucket = "trevors-cloud-resume-terraform-bucket"

    tags = {
        Name = "Cloud Resume Root Bucket"
        Environment = "Prod"
    }
}

resource aws_s3_bucket_acl "rootACL" {
    bucket = aws_s3_bucket.rootbucket.id
    acl = "private"
}

resource "aws_s3_bucket_website_configuration" "webbucket" {
    bucket = aws_s3_bucket.rootbucket.id

    redirect_all_requests_to {
        host_name = "www.trevorscloudresume.com"
        protocol = "https"
    }
}