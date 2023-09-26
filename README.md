# terraform-aws-organizations

Terraform module to configure [AWS Organizations](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_introduction.html).

GitHub: https://github.com/atheiman/terraform-aws-organizations
Terraform Registry: https://registry.terraform.io/modules/atheiman/organizations/aws/latest

## Usage

```hcl
module "org" {
  source  = "atheiman/organizations/aws"

  ous = [
    "core",
    "workloads/nonprod",
    "workloads/prod",
  ]
}

output "org" {
  value = module.org.org
}

output "ous" {
  value = module.org.ous
}
```

Exposed outputs:

```hcl
Outputs:

org = {...}
ous = {
  "core" = {...}
  "workloads" = {...}
  "workloads/nonprod" = {...}
  "workloads/prod" = {...}
}
```

## Features

1. Create organization
1. Create nested organizational units using simple `list(string)` interface

## Roadmap

1. [Manage AWS accounts](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_create.html)
1. [Enable AWS services organization integrations](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services.html)
1. [Enable and deploy organization policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies.html)
