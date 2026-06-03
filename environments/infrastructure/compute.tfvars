## Elastic Kubernetes Service (EKS) Variable Values
eks_vars = [
    {
        name = "eks_cluster"
        kubernetes_version = "1.35"

        enable_cluster_creator_admin_permissions = true
        eks_managed_node_groups = {
            node-0 = {
                name = "eks_node"

                create = true
                kubernetes_version = "1.35"
                instance_types = ["t3.medium"]
                create_access_entry = true

                min_size = 1
                max_size = 2
                desired_size = 1
            }
        }

        compute_config = {
            enabled = false
        }

        iam_role_name = "eks-iam"
        iam_role_additional_policies = {
            AmazonEKSWorkerNodePolicy           = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
            AmazonEC2ContainerRegistryReadOnly  = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
            AmazonEKS_CNI_Policy                = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
        }

        endpoint_public_access = true
        access_entries = {
            root = {
                principal_arn = "arn:aws:iam::476320587253:root"

                policy_associations = {
                    root_assc = {
                        policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
                        access_scope = {
                            type = "cluster"
                        }
                    }
                }
            }
        }

        addons = {
            vpc-cni = {
                before_compute = true
            }

            kube-proxy = {}
        }

        description = "EKS cluster deployed on the spoke VPC."
    }
]

helm_vars = [
    {
        name = "ingress-nginx"
        chart = "ingress-nginx"
        repository = "https://kubernetes.github.io/ingress-nginx"

        namespace = "application"
        create_namespace = true

        dependency_update = true
    }
]