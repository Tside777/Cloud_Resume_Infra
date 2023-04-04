resource "aws_route53_zone" "trevorscloudresume_zone" {
    name = "trevorscloudresume.com"
}

resource "aws_route53_record" "wwwIPv4" {
    zone_id = aws_route53_zone.trevorscloudresume_zone.id
    name    = "www.trevorscloudresume.com"
    type    = "A"
    alias {
      name = var.subdomain_name
      zone_id = aws_route53_zone.trevorscloudresume_zone.id
      evaluate_target_health = false
    }
}

resource "aws_route53_record" "wwwIPv6" {
    zone_id = aws_route53_zone.trevorscloudresume_zone.id
    name    = "www.trevorscloudresume.com"
    type    = "AAAA"
    alias {
      name = var.subdomain_name
      zone_id = aws_route53_zone.trevorscloudresume_zone.id
      evaluate_target_health = false
    }
}

resource "aws_route53_record" "IPv4" {
    zone_id = aws_route53_zone.trevorscloudresume_zone.id
    name    = "trevorscloudresume.com"
    type    = "A"
    alias {
      name = var.root_domain_name
      zone_id = aws_route53_zone.trevorscloudresume_zone.id
      evaluate_target_health = false
    } 
}

resource "aws_route53_record" "IPv6" {
    zone_id = aws_route53_zone.trevorscloudresume_zone.id
    name    = "trevorscloudresume.com"
    type    = "AAAA"
    alias {
      name = var.root_domain_name
      zone_id = aws_route53_zone.trevorscloudresume_zone.id
      evaluate_target_health = false
    }  
}

/*

resource "aws_route53_record" "NS" {
    
}

resource "aws_route53_record" "SOA" {
    
}

resource "aws_route53_record" "CNAME" {

}

*/