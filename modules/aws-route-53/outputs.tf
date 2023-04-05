output "hosted_zone_id" {
    value = aws_route53_zone.trevorscloudresume_zone.zone_id
}

output "cert_arn" {
    value = aws_acm_certificate.cert.arn
}