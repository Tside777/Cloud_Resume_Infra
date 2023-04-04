variable "rootdomain_bucket_name" {
    description = "Name of S3 bucket for root domain to redirect to subdomain bucket site"
    type = string
}

variable "subdomain_bucket_name" {
    description = "Name of S3 bucket for subdomain, must be unique"
    type = string
}

variable "subdomain_dist_arn" {
    description = "ARN of cloudfront distribution for subdomain bucket"
    type = string
}