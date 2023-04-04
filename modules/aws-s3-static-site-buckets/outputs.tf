output "subdomain_bucket_id" {
    value = aws_s3_bucket.subbucket.id
}

output "subdomain_bucket_regional_domain" {
    value = aws_s3_bucket.subbucket.bucket_regional_domain_name
}

output "rootdomain_bucket_id" {
    value = aws_s3_bucket.rootbucket.id
}

output "root_website_endpoint" {
    value = aws_s3_bucket_website_configuration.webbucket.website_endpoint
}
