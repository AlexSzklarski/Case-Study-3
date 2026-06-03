## Okta User Resources
user_vars = [
    {
        first_name = "Menno"
        last_name = "Kuipers"
        login = "Menno.Kuipers@innovatech.com"
        email = "Menno.Kuipers@innovatech.com"
        department = "HR"
    },
    {
        first_name = "Dirk"
        last_name = "van Dommelen"
        login = "Dirk.Dommelen@innovatech.com"
        email = "Dirk.Dommelen@innovatech.com"
        department = "Developer"
    },
    {
        first_name = "Rostik"
        last_name = "Pukas"
        login = "Rostik.Pukas@innovatech.com"
        email = "Rostik.Pukas@innovatech.com"
        department = "Sysadmin"
    },
    {
        first_name = "Olha"
        last_name = "Szklarska"
        login = "Olha.Szklarska@innovatech.com"
        email = "Olha.Szklarska@innovatech.com"
        department = "Manager"
    },
    {
        first_name = "Kuba"
        last_name = "Borzyminski"
        login = "Kuba.Borzyminski@innovatech.com"
        email = "Kuba.Borzyminski@innovatech.com"
        department = "Intern"
    }
]

## Okta Group Resources
group_vars = [
    {
        name = "Developer"
        description = "Developers with access to AWS infrastructure."
    },
            {
        name = "Sysadmin"
        description = "Admin with full access to AWS and monitoring."
    },
            {
        name = "Manager"
        description = "Manager with access to costs and monitoring."
    },
            {
        name = "HR"
        description = "HR employee with access to HR data."
    },
            {
        name = "Intern"
        description = "Intern with limited AWS access."
    }
]

group_rule_vars = [
    {
        name = "Developer_Rule"
        group_name = "Developer"
        expression_type = "urn:okta:expression:1.0"
        expression_value = "user.department == \"Developer\""
    },
    {
        name = "Sysadmin_Rule"
        group_name = "Sysadmin"
        expression_type = "urn:okta:expression:1.0"
        expression_value = "user.department == \"Sysadmin\""
    },
    {
        name = "Manager_Rule"
        group_name = "Manager"
        expression_type = "urn:okta:expression:1.0"
        expression_value = "user.department == \"Manager\""
    },
    {
        name = "HR_Rule"
        group_name = "HR"
        expression_type = "urn:okta:expression:1.0"
        expression_value = "user.department == \"HR\""
    },
    {
        name = "Intern_Rule"
        group_name = "Intern"
        expression_type = "urn:okta:expression:1.0"
        expression_value = "user.department == \"Intern\""
    },
]

## Okta Security Policy Resources
policy_password_vars = [
    {
        name = "password_policy"
        description = "Password policy applied to all groups, handles lockout and password strength."
        groups_included = ["EVERYONE"]

        password_dictionary_lookup = true
        password_max_lockout_attempts = 5
        password_min_symbol = 1
        password_min_length = 12
        question_recovery = "INACTIVE"
    }
]

policy_mfa_vars = [
    {
        name = "mfa_policy"
        description = "MFA policy, enables push notifications when logging in."
        groups_included = ["EVERYONE"]

        is_oie = true
        okta_verify = {enroll = "REQUIRED"}
    }
]

policy_signon_vars = [
    {
        name = "signon_policy"
        description = "Signon policy applied to all groups"
        groups_included = ["EVERYONE"]
    }
]

policy_rule_signon_vars = [
    {
        name = "signon_rules"

        policy_id = module.okta.policy_signon_id["signon_policy"]
        mfa_required = true
        mfa_prompt = "ALWAYS"

        session_idle = 10
    }
]