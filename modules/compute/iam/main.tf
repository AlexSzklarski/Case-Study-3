## Identity Access Management (IAM) Role Resources
module "iam_role" {
    source  = "terraform-aws-modules/iam/aws//modules/iam-role"
    for_each = { for inst in var.iam_role_vars : inst.name => inst }

    name = each.value.name

    trust_policy_permissions = each.value.trust_policy_permissions

    policies = each.value.policies

    tags = {
        name = each.value.name
        description = each.value.description
    }
}