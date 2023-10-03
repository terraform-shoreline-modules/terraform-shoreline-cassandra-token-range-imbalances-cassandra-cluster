terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "token_range_imbalances_causing_uneven_data_distribution_and_performance_issues_in_cassandra_cluster" {
  source    = "./modules/token_range_imbalances_causing_uneven_data_distribution_and_performance_issues_in_cassandra_cluster"

  providers = {
    shoreline = shoreline
  }
}