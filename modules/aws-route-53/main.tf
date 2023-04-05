resource "aws_route53_zone" "trevorscloudresume_zone" {
    name = "trevorscloudresume.com"
}

resource "aws_route53_record" "wwwIPv4" {
    zone_id = aws_route53_zone.trevorscloudresume_zone.id
    name    = "www.trevorscloudresume.com"
    type    = "A"
    alias {
      name = var.subdomain_name
      zone_id = var.sub_hosted_zone_id
      evaluate_target_health = false
    }
}

resource "aws_route53_record" "wwwIPv6" {
    zone_id = aws_route53_zone.trevorscloudresume_zone.id
    name    = "www.trevorscloudresume.com"
    type    = "AAAA"
    alias {
      name = var.subdomain_name
      zone_id = var.sub_hosted_zone_id
      evaluate_target_health = false
    }
}

resource "aws_route53_record" "IPv4" {
    zone_id = aws_route53_zone.trevorscloudresume_zone.id
    name    = "trevorscloudresume.com"
    type    = "A"
    alias {
      name = var.root_domain_name
      zone_id = var.root_hosted_zone_id
      evaluate_target_health = false
    } 
}

resource "aws_route53_record" "IPv6" {
    zone_id = aws_route53_zone.trevorscloudresume_zone.id
    name    = "trevorscloudresume.com"
    type    = "AAAA"
    alias {
      name = var.root_domain_name
      zone_id = var.root_hosted_zone_id
      evaluate_target_health = false
    }  
}

resource "aws_route53_record" "cname" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name = dvo.resource_record_name
      record = dvo.resource_record_value
      type = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name = each.value.name
  records = [ each.value.record ]
  ttl = 300
  type = each.value.type
  zone_id = aws_route53_zone.trevorscloudresume_zone.id

}


//=================================================================================
//Certificate Management
//=================================================================================

 resource "aws_acm_certificate" "cert" {
  domain_name = "trevorscloudresume.com"
  subject_alternative_names = [ "*.trevorscloudresume.com"]
  validation_method = "DNS"
 }

 resource "aws_acm_certificate_validation" "certvalidation" {
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cname : record.fqdn]
 }


