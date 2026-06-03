## Application Load Balancer (ALB) Outputs
output "nginx_tg" {
    value = module.alb.hub-alb.target_groups

    description = "Nginx target group."
}