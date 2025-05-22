
output "lbc_iam_policy" {
  value = data.http.lbc_iam_policy.response_body
}

output "lbc_helm_metadata" {
  description = "Metadata block outlining the status of the deployed release"

  value = helm_release.lb_controller.metadata

}