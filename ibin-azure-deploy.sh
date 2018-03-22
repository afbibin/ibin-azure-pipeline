#!/bin/sh

##########################################################################################
# PARAMETERS from Jenkins job:
#

#We should pull deploy scripts from Git: ssh://git@github.com/afbibin/ibin-azure-pipeline
BRANCH_TO_BUILD=master

# Docker images tag
DEPLOY_VERSION=stable

#Specific test environment
TEST_ENVIRONMENT=azure

#
#
##########################################################################################


export DOCKER_REPOSITORY=afbibin/


# Define DEPLOY_VERSION
# TODO!!! get proper version of the image
#export DEPLOY_VERSION=${REQUIRED_VERSION}
export DEPLOY_VERSION

# Export Git branch to be used within inner scripts
export BRANCH_TO_BUILD

##############################
# Test environment isolation (begin) -->
TEST_ENVIRONMENT_CONFIGURATION_FILE=./environment-configuration.csv
#Check the requested environment is specified
cat ${TEST_ENVIRONMENT_CONFIGURATION_FILE} | grep ${TEST_ENVIRONMENT};
status=$?
if [[ ${status} != 0 ]]
then 
  echo "Error! Requested test environment ${TEST_ENVIRONMENT} is not specified within the ${TEST_ENVIRONMENT_CONFIGURATION_FILE}"
  exit ${status} 
fi

# Get environment-specific configuration settings for the systems isolation
set `cat ${TEST_ENVIRONMENT_CONFIGURATION_FILE} | \
         awk -v REQUESTED_ENVIRONMENT="${TEST_ENVIRONMENT}" '/#/{next}; {if ($1 == REQUESTED_ENVIRONMENT) {printf "%s %s %s %s\n", $2, $3, $4, $5}}'`
# Extract the project prefix
export PROJECT_PREFIX=$1
# Extract prefix for ports
export PORT_PREFIX=$2
# Extract prefix for a subnetwork
export SUBNET=$3
# TODO Extract target hostname (to deploy services)
export TARGET_HOST=$4
# Test environment isolation (end) <--
##############################

echo "Deployment is configured with the following environment isolation parameters:"
echo "TEST_ENVIRONMENT=${TEST_ENVIRONMENT}; PROJECT_PREFIX=${PROJECT_PREFIX}; PORT_PREFIX=${PORT_PREFIX}; SUBNET=${SUBNET}; TARGET_HOST=${TARGET_HOST}"

# Initialize Env variables
bash ./init_variables_tech.sh
bash ./init_config_service_repository.sh

# Set the service labels prefix (will be added to the docker containers)
export LABEL_PREFIX=ibin.

# Start with deployment
# Compose and run all containers from compose file
docker-compose --file ibin-azure-deploy.yml --project-name ${PROJECT_PREFIX} up -d
