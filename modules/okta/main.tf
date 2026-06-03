terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.10.0"
    }
  }
}

## Okta User Resources
resource "okta_user" "user_resource" {
    for_each = { for inst in var.user_vars : inst.first_name => inst }

    first_name = each.value.first_name
    last_name = each.value.last_name
    login = each.value.login
    email = each.value.email
    department = each.value.department
}

## Okta Group Resources
resource "okta_group" "group_resource" {
    for_each = { for inst in var.group_vars : inst.name => inst }
    
    name = each.value.name
    description = each.value.description
}

resource "okta_group_rule" "group_rule_resource" {
    for_each = { for inst in var.group_rule_vars : inst.name => inst }

    name = each.value.name
    group_assignments = [okta_group.group_resource[each.value.group_name].id]
    expression_type = each.value.expression_type
    expression_value = each.value.expression_value
}

## Okta Security Policy Resource
resource "okta_policy_password" "policy_password_resource" {
    for_each = { for inst in var.policy_password_vars : inst.name => inst }

    name = each.value.name
    description = each.value.description
    groups_included = each.value.groups_included

    password_dictionary_lookup = each.value.password_dictionary_lookup
    password_max_lockout_attempts = each.value.password_max_lockout_attempts
    password_min_symbol = each.value.password_min_symbol
    password_min_length = each.value.password_min_length
    question_recovery = each.value.question_recovery
}

resource "okta_policy_mfa" "policy_mfa_resource" {
    for_each = { for inst in var.policy_mfa_vars : inst.name => inst }

    name = each.value.name
    description = each.value.description
    groups_included = each.value.groups_included

    is_oie = each.value.is_oie
    okta_verify = each.value.okta_verify
}

resource "okta_policy_signon" "policy_signon_resource" {
    for_each = { for inst in var.policy_signon_vars : inst.name => inst }

    name = each.value.name
    description = each.value.description
    groups_included = each.value.groups_included
}

resource "okta_policy_rule_signon" "policy_rule_signon_resource" {
    for_each = { for inst in var.policy_rule_signon_vars : inst.name => inst }

    name = each.value.name
    
    policy_id = var.policy_id
    mfa_required = each.value.mfa_required
    mfa_prompt = each.value.mfa_prompt

    session_idle = each.value.session_idle

    depends_on = [ okta_policy_signon.policy_signon_resource ]
}