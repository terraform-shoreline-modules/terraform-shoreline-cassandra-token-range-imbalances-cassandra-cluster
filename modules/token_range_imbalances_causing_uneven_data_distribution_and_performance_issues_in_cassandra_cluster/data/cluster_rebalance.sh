

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