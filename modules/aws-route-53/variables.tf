variable "root_domain_name" {
    description = "Cloudfront domain name for root distribution"
    type = string
}

variable "subdomain_name" {
    description = "Cloudfront domain name for subdomain distribution"
    type = string
}

variable "sub_hosted_zone_id" {
    description = "Hosted zone id that sub cloudfront distribtuion has"
    type = string
}

variable "root_hosted_zone_id" {
    description = "Hosted zone id that root cloudfront distribtuion has"
    type = string
}