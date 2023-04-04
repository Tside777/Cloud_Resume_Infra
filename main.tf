terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 4.0"
      }
    }
}

provider "aws" {
    region = "us-east-1"
}

module "s3_buckets" {
    source="./modules/aws-s3-static-site-buckets"
    
    rootdomain_bucket_name = "trevors-cloud-resume-terraform-bucket"
    subdomain_bucket_name = "www.trevors-cloud-resume-terraform-bucket"
    subdomain_dist_arn = module.cloudfront_distributions.subdomain_dist_arn
}

module "cloudfront_distributions" {
    source ="./modules/aws-cloudfront-distributions"

    subdomain_bucket_id = module.s3_buckets.subdomain_bucket_id
    subdomain_bucket_regional_domain = module.s3_buckets.subdomain_bucket_regional_domain
    rootdomain_bucket_id = module.s3_buckets.rootdomain_bucket_id
    root_website_endpoint = module.s3_buckets.root_website_endpoint
}