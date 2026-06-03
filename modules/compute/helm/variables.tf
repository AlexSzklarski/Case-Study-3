## Helm Resources
variable "helm_vars" {
    type = list(object({
        name = string
        chart = string
        repository = string

        namespace = string
        create_namespace = bool

        dependency_update = bool
    }))
}