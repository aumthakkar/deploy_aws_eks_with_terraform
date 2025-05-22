

resource "kubernetes_ingress_class_v1" "ingress_class_default" {
  depends_on = [helm_release.lb_controller]
  metadata {
    name = "${local.name}-ingress-class"
    annotations = {
      "ingressclass.kubernetes.io/is-default-class" = "true"
    }
  }

  spec {
    controller = "ingress.k8s.aws/alb" # Specify this value to denote ingresses should be managed by AWS LB Controller
  }

}