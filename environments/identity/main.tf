module "okta" {
    source = "../../modules/okta"

    user_vars = var.user_vars

    group_vars = var.group_vars
    group_rule_vars = var.group_rule_vars

    policy_password_vars = var.policy_password_vars
    policy_mfa_vars = var.policy_mfa_vars
    policy_signon_vars = var.policy_signon_vars
    policy_rule_signon_vars = var.policy_rule_signon_vars
    policy_id = module.okta.policy_signon_id["signon_policy"]
}