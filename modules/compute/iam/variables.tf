## Identity Access Management (IAM) Role Variables
variable "iam_role_vars" {
    type = list(object({
        name = string

        trust_policy_permissions = map(object({
            actions = list(string)
            principals = list(object({
                type = string
                identifiers = list(string)
            }))
        }))

        policies = map(string)

        description = string
    }))
}