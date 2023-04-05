output "subdomain_dist_arn" {
  value = aws_cloudfront_distribution.subDist.arn
}

output "subdomain_name" {
    value = aws_cloudfront_distribution.subDist.domain_name
}

output "root_domain_name" {
    value = aws_cloudfront_distribution.rootDist.domain_name
}

output "sub_hosted_zone_id" {
    value = aws_cloudfront_distribution.subDist.hosted_zone_id
}

output "root_hosted_zone_id" {
    value = aws_cloudfront_distribution.rootDist.hosted_zone_id
}