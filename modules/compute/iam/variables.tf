variable "iam_role_vars" {
    type = list(object({
        name = string

        trust_policy_permissions = list(any)

        policies = list(string)

        description = string
    }))
}