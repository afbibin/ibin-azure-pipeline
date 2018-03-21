#!/bin/bash

############################################################################
# This script initializes the system environment variables
# Optionally it can store particular variable "name-value" pair 
# inside a special .env file (by appending a new line)
# .env file then could be passed to some container(s) at a deployment phase 
#
# NOTE: to add some variable into *.env file, use the following syntax:
# store_variable "<VARIABLE_NAME>"
############################################################################

# Target .env file
TARGET_ENV_FILE="./variables_tech.env"

###########################################################################################
# Store (add) the variable "name=value" pair with given variable name (defined as string) 
#       into the specified ${TARGET_ENV_FILE} file
###########################################################################################
store_variable() {
echo $1=\"${!1}\" >> ${TARGET_ENV_FILE}
}

echo "# NOTE: This file is generated with special script $0" > "${TARGET_ENV_FILE}"
echo "#       Do not modify it directly!" >> "${TARGET_ENV_FILE}"

# Mongo DB
export IBIN_MONGODB_PORT="${PORT_PREFIX}017"

# Configuration service
export IBIN_BACKEND_CONFIG_SERVICE_PORT="${PORT_PREFIX}000"

# Service registry
export IBIN_BACKEND_SERVICE_REGISTRY_PORT="${PORT_PREFIX}001"

# Mongo storage service
export IBIN_BACKEND_STORAGE_SERVICE_PORT="${PORT_PREFIX}002"

# Backend core service
export IBIN_BACKEND_CORE_SERVICE_PORT="${PORT_PREFIX}003"

# Backend frontend API service
export IBIN_BACKEND_FRONT_API_SERVICE_PORT="${PORT_PREFIX}004"

#System and network prefixes and network IP
export IB_INST_BACKEND_NETWORK=10.80.${SUBNET}.1/24

####################################################################################################
#
# FRONTEND configuration
#
####################################################################################################

# Where to put application logs
IBIN_LOG_PATH="/var/logs/ib-instruments/${PROJECT_PREFIX}"
export IBIN_LOG_PATH

# Frontend web UI service
export IBIN_FRONTEND_UI_PORT=${PORT_PREFIX}080 
store_variable "IBIN_FRONTEND_UI_PORT"

# Frontend-service internal port
export IBIN_FRONTEND_SERVER_PORT=8080
store_variable "IBIN_FRONTEND_SERVER_PORT"

# Frontend-service hostname to bind a web-service to the server
IBIN_FRONTEND_SERVER_HOST=ibin-frontend
store_variable "IBIN_FRONTEND_SERVER_HOST"

# NodeJS behaviour mode
NODE_ENV=${TARGET_ENV}
store_variable "NODE_ENV"

# IB Instruments proxy-server port
export IBIN_PROXY_PORT=${PORT_PREFIX}088
