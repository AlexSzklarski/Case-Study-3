## Okta User Variables
variable "user_vars" {
    type = list(object({
        first_name = string
        last_name = string
        login = string
        email = string
        department = string
    }))
}

## Okta Group Variables
variable "group_vars" {
    type = list(object({
        name = string
        description = string
    }))
}

variable "group_rule_vars" {
    type = list(object({
        name = string
        group_name = string

        expression_type = string
        expression_value = string
    }))
}

## Okta Security Policy Variables
variable "policy_password_vars" {
    type = list(object({
        name = string
        description = string
        groups_included = list(string)

        password_dictionary_lookup = bool
        password_max_lockout_attempts = number
        password_min_symbol = number
        password_min_length = number
        question_recovery = string
        
    }))
}

variable "policy_mfa_vars" {
    type = list(object({
        name = string
        description = string
        groups_included = list(string)

        is_oie = bool
        okta_verify = map(string)
    }))
}

variable "policy_signon_vars" {
    type = list(object({
        name = string
        description = string
        groups_included = list(string)
    }))
}

variable "policy_rule_signon_vars" {
    type = list(object({
        name = string
        
        mfa_required = bool
        mfa_prompt = string

        session_idle = number
    }))
}

variable "policy_id" {
    type = string
}