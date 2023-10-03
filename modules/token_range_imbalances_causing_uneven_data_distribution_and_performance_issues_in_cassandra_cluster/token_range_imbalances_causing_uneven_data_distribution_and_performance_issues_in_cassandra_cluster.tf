resource "shoreline_notebook" "token_range_imbalances_causing_uneven_data_distribution_and_performance_issues_in_cassandra_cluster" {
  name       = "token_range_imbalances_causing_uneven_data_distribution_and_performance_issues_in_cassandra_cluster"
  data       = file("${path.module}/data/token_range_imbalances_causing_uneven_data_distribution_and_performance_issues_in_cassandra_cluster.json")
  depends_on = [shoreline_action.invoke_cluster_rebalance]
}

resource "shoreline_file" "cluster_rebalance" {
  name             = "cluster_rebalance"
  input_file       = "${path.module}/data/cluster_rebalance.sh"
  md5              = filemd5("${path.module}/data/cluster_rebalance.sh")
  description      = "Rebalancing the cluster: Token range imbalances can occur due to nodes being added or removed from the cluster. Rebalancing the cluster can help redistribute the data evenly across all nodes. This can be achieved by using nodetool or by performing an automatic rebalance."
  destination_path = "/agent/scripts/cluster_rebalance.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_cluster_rebalance" {
  name        = "invoke_cluster_rebalance"
  description = "Rebalancing the cluster: Token range imbalances can occur due to nodes being added or removed from the cluster. Rebalancing the cluster can help redistribute the data evenly across all nodes. This can be achieved by using nodetool or by performing an automatic rebalance."
  command     = "`chmod +x /agent/scripts/cluster_rebalance.sh && /agent/scripts/cluster_rebalance.sh`"
  params      = ["PORT_NUMBER","KEYSPACE_NAME","CLUSTER_NAME","NAME_OF_CLUSTER","NODE_ADDRESS"]
  file_deps   = ["cluster_rebalance"]
  enabled     = true
  depends_on  = [shoreline_file.cluster_rebalance]
}

