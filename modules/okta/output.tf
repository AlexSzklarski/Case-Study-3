output "policy_signon_id" {
    value = { for key, policy in okta_policy_signon.policy_signon_resource : key => policy.id }
}