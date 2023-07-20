output "mycluster_host" {
  value = ovh_cloud_project_kube.my_cluster.kubeconfig_attributes[0].host
  sensitive = true
}

output "mycluster_cluster_ca_certificate" {
  value = ovh_cloud_project_kube.my_cluster.kubeconfig_attributes[0].cluster_ca_certificate
  sensitive = true
}

output "mycluster_client_certificate" {
  value = ovh_cloud_project_kube.my_cluster.kubeconfig_attributes[0].client_certificate
  sensitive = true
}

output "mycluster_client_key" {
  value = ovh_cloud_project_kube.my_cluster.kubeconfig_attributes[0].client_key
  sensitive = true
}