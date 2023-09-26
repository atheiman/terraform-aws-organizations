output "org" {
  description = "aws_organizations_organization resource"
  value       = resource.aws_organizations_organization.org
}

output "ous" {
  description = "map of organizational units - keys are ou paths as string, values are aws_organizations_organizational_unit resources"
  value = { for ou_path_str, ou in local.ous_output_helper : ou_path_str =>
    ou["level"] == 0 ? aws_organizations_organizational_unit.l0[ou["name"]] :
    ou["level"] == 1 ? aws_organizations_organizational_unit.l1[ou["name"]] :
    ou["level"] == 2 ? aws_organizations_organizational_unit.l2[ou["name"]] :
    ou["level"] == 3 ? aws_organizations_organizational_unit.l3[ou["name"]] :
    aws_organizations_organizational_unit.l4[ou["name"]]
  }
}
