variable "subdomain_bucket_id" {
    description = "Name (id) of S3 bucket for subdomain, must be unique"
    type = string
}

variable "subdomain_bucket_regional_domain" {
    description = "regional domain name for subdomain"
    type = string
}

variable "rootdomain_bucket_id" {
    description = "Name (id) of S3 bucket for root domain to redirect to subdomain bucket site"
    type = string
}

variable "root_website_endpoint" {
    description = "Website endpoint for root S3 static site for redirect"
    type = string
}
