## Helm Resources
resource "helm_release" "eks_monitoring" {
    for_each = { for inst in var.helm_vars : inst.name => inst }

    name = each.value.name
    chart = each.value.chart
    repository = each.value.repository
 
    namespace = each.value.namespace
    create_namespace = each.value.create_namespace

    dependency_update = each.value.dependency_update
}