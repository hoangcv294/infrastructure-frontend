# Define IP set for whitelisting
resource "aws_waf_ipset" "waf_ip_whitelist" {
  name = "waf_ip_whitelist"

  ip_set_descriptors {
    type  = "IPV4"
    value = "xx.xx.xx.xx/xx" #CIDR
}
}

# Define WAF rule to match IP set
resource "aws_waf_rule" "waf_ip_rule" {
  name = "waf_ip_rule"

  metric_name = "wafIpMetric"

  predicates {
    type    = "IPMatch"
    negated = false
    data_id = aws_waf_ipset.waf_ip_whitelist.id
  }
}

# Define WAF Web ACL to use the rule
resource "aws_waf_web_acl" "waf_waf_acl" {
  name = "waf_waf_acl"

  metric_name = "wafWafMetric"
  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1

    rule_id = aws_waf_rule.waf_ip_rule.id
  }
}