
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Token Range Imbalances Causing Uneven Data Distribution and Performance Issues in Cassandra Cluster
---

This incident type refers to a problem in a Cassandra cluster where the token range imbalances cause uneven distribution of data across the cluster. This can result in slower read and write performance that can impact the overall functionality of the system. Token range imbalances occur when the distribution of the tokens that define the ranges of data each node is responsible for is not evenly spread across the cluster. As a result, certain nodes may be responsible for a disproportionate amount of data, leading to performance issues and potential failure of the system.

### Parameters
```shell
export KEYSPACE="PLACEHOLDER"

export KEY="PLACEHOLDER"

export TABLE="PLACEHOLDER"

export NODE_ADDRESS="PLACEHOLDER"

export PORT_NUMBER="PLACEHOLDER"

export NAME_OF_CLUSTER="PLACEHOLDER"

export CLUSTER_NAME="PLACEHOLDER"

export KEYSPACE_NAME="PLACEHOLDER"
```

## Debug

### Check the status of the Cassandra cluster
```shell
nodetool status
```

### Check for any inconsistencies in the token ranges
```shell
nodetool describecluster
```

### Check for any imbalanced token ranges
```shell
nodetool ring
```

### Check for any under-replicated data
```shell
nodetool getendpoints ${KEYSPACE} ${TABLE} ${KEY}
```

### Check for any over-replicated data
```shell
nodetool cleanup ${KEYSPACE} ${TABLE}
```

### Check for any read performance issues
```shell
nodetool cfstats
```

### Check for any write performance issues
```shell
nodetool tpstats
```

## Repair

### Rebalancing the cluster: Token range imbalances can occur due to nodes being added or removed from the cluster. Rebalancing the cluster can help redistribute the data evenly across all nodes. This can be achieved by using nodetool or by performing an automatic rebalance.
```shell


#!/bin/bash



# Set the variables

${CLUSTER_NAME}="${NAME_OF_CLUSTER}"

${NODE_ADDRESS}="${NODE_ADDRESS}"



# Check if nodetool is installed

if ! command -v nodetool &> /dev/null

then

    echo "nodetool could not be found. Please install Cassandra before running this script."

    exit 1

fi



# Run nodetool to rebalance the cluster

nodetool -- ${NODE_ADDRESS} -p ${PORT_NUMBER} repair --full ${KEYSPACE_NAME}



# Check if the rebalance was successful

if [ $? -eq 0 ]

then

    echo "Cluster rebalanced successfully."

else

    echo "Cluster rebalance failed. Please check the logs for more information."

    exit 1

fi



exit 0


```