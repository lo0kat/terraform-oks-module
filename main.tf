provider "ovh" {
  endpoint = "ovh-eu"
}

##### PRIVATE REGISTRY CREATION
data "ovh_cloud_project_capabilities_containerregistry_filter" "regcap" {
  service_name = var.project_id
  plan_name    = "SMALL"
  region       = var.region
}

resource "ovh_cloud_project_containerregistry" "reg" {
  service_name = data.ovh_cloud_project_capabilities_containerregistry_filter.regcap.service_name
  plan_id      = data.ovh_cloud_project_capabilities_containerregistry_filter.regcap.id
  region       = data.ovh_cloud_project_capabilities_containerregistry_filter.regcap.region
  name         = "cr-${var.project_id}"
}

##### NETWORK CONFIG
resource "ovh_cloud_project_network_private" "net" {
  service_name = var.project_id
  name         = "${var.cluster_name}-k8s-net"
  regions      = ["${var.region}"]
}


##### PRIVATE CLUSTER CREATION
resource "ovh_cloud_project_kube" "my_cluster" {
  service_name = var.project_id
  name         = var.cluster_name
  region       = var.region
  version      = "1.27"
}

resource "ovh_cloud_project_kube_nodepool" "node_pool" {
  service_name  = var.project_id
  kube_id       = ovh_cloud_project_kube.my_cluster.id
  name          = "node-pool-${var.cluster_name}" //Warning: "_" char is not allowed!
  flavor_name   = var.node_flavor
  desired_nodes = var.node_number
  max_nodes     = var.node_number
  min_nodes     = var.node_number
}
