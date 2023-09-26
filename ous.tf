locals {
  l0_ou_paths = distinct([for ou in var.ous : [element(split("/", ou), 0)]])
  l1_ou_paths = distinct([for ou in var.ous : slice(split("/", ou), 0, 2) if length(split("/", ou)) > 1])
  l2_ou_paths = distinct([for ou in var.ous : slice(split("/", ou), 0, 3) if length(split("/", ou)) > 2])
  l3_ou_paths = distinct([for ou in var.ous : slice(split("/", ou), 0, 4) if length(split("/", ou)) > 3])
  l4_ou_paths = distinct([for ou in var.ous : slice(split("/", ou), 0, 5) if length(split("/", ou)) > 4])

  l0_ous = { for ou_path in local.l0_ou_paths :
    ou_path[length(ou_path) - 1] => {
      name = element(ou_path, length(ou_path) - 1)
    }
  }
  l1_ous = { for ou_path in local.l1_ou_paths :
    ou_path[length(ou_path) - 1] => {
      name        = element(ou_path, length(ou_path) - 1)
      parent_name = element(ou_path, length(ou_path) - 2)
    }
  }
  l2_ous = { for ou_path in local.l2_ou_paths :
    ou_path[length(ou_path) - 1] => {
      name        = element(ou_path, length(ou_path) - 1)
      parent_name = element(ou_path, length(ou_path) - 2)
    }
  }
  l3_ous = { for ou_path in local.l3_ou_paths :
    ou_path[length(ou_path) - 1] => {
      name        = element(ou_path, length(ou_path) - 1)
      parent_name = element(ou_path, length(ou_path) - 2)
    }
  }
  l4_ous = { for ou_path in local.l4_ou_paths :
    ou_path[length(ou_path) - 1] => {
      name        = element(ou_path, length(ou_path) - 1)
      parent_name = element(ou_path, length(ou_path) - 2)
    }
  }

  ous_output_helper = {
    for p in concat(
      local.l0_ou_paths,
      local.l1_ou_paths,
      local.l2_ou_paths,
      local.l3_ou_paths,
      local.l4_ou_paths,
    ) : join("/", p) => { level = length(p) - 1, name = element(p, length(p) - 1) }
  }
}

resource "aws_organizations_organizational_unit" "l0" {
  for_each  = local.l0_ous
  name      = each.key
  parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "l1" {
  for_each  = local.l1_ous
  name      = each.key
  parent_id = aws_organizations_organizational_unit.l0[each.value["parent_name"]].id
}

resource "aws_organizations_organizational_unit" "l2" {
  for_each  = local.l2_ous
  name      = each.key
  parent_id = aws_organizations_organizational_unit.l1[each.value["parent_name"]].id
}

resource "aws_organizations_organizational_unit" "l3" {
  for_each  = local.l3_ous
  name      = each.key
  parent_id = aws_organizations_organizational_unit.l2[each.value["parent_name"]].id
}

resource "aws_organizations_organizational_unit" "l4" {
  for_each  = local.l4_ous
  name      = each.key
  parent_id = aws_organizations_organizational_unit.l3[each.value["parent_name"]].id
}
