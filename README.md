# Case Study 3

## Modules

The `modules` folder contains all reusable Terraform modules that make up the cloud infrastructure. Each module can be called from the environment folder. The following modules are available:

### Compute
This module consists of EKS, Helm, IAM, and VPN resources.

### Network
This module consists of VPCs, security groups, an ALB and TGW.

### Database
This module consists of a PostgreSQL database.

### Okta
This module consists of Okta users, groups, and group policies.

---

## Environments

The `environments` folder is where each module gets its actual values. Rather than hardcoding values inside the modules themselves, the environment configurations pass in the required variables. This keeps the modules generic and reusable while the environment layer handles deployment values.

---

## Workflows

Deployments and teardowns are handled through four separate CI/CD pipelines:

| Pipeline | Description |
|---|---|
| **Create Okta Resources** | Deploys all Okta resources defined in the Okta module, such as users, groups, and policies. |
| **Destroy Okta Resources** | Tears down all previously deployed Okta resources cleanly. |
| **Create AWS Resources** | Deploys all AWS infrastructure across the Compute, Network and Database modules. |
| **Plan AWS Resources** | Tests IaC for all AWS infrastructure across the Compute, Network and Database modules. |
| **Destroy AWS Resources** | Tears down all previously deployed AWS infrastructure. |

Keeping create and destroy pipelines separate and splitting Okta from AWS makes it easier to manage dependencies, debug issues, and control what gets deployed or removed at any given time.
