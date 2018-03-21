#!/bin/sh
#############################################################################
#
# Simple smoke tests for IB-Instruments/Backend components
#
#############################################################################

# Disable "exit on error" feature
set +e

# Disable detailed echo
set +x

# Clear failed tests flag upon start
TEST_FAILED=0

#############################################################################
# Check whether the CURL exit code is succeeded (==0)
# Parameters:
#        $1 - CURL exit code
#############################################################################
assert_curl_succeeded() {
set +x
  # Assert latest exit code is Ok
if [[ ${1} -eq 0 ]]
  then
	  echo "CURL status: Ok"
	  echo ----------------------
  else
	  echo "ERROR: CURL_STATUS=${1}"
	  echo "Test FAILED"
	  TEST_FAILED=1
fi  
}


#############################################################################
# Check whether the HTTP response status code is 'positive', i.e.=[200..299]
# Parameters:
#        $1 - shorten HTTP response (use curl -Is)
#############################################################################
assert_http_status_succeeded() {
set +x
#Extract HTTP status as a number
HTTP_STATUS_CODE=${1}
echo "HTTP_STATUS_CODE=${HTTP_STATUS_CODE}"
# Assert HTTP_STATUS is between 200...299
if [ "${HTTP_STATUS_CODE}" -ge 200 -a "${HTTP_STATUS_CODE}" -le 299 ]
  then
	  echo "HTTP code: Ok "
	  echo ----------------------
  else
	  echo "HTTP code: FAILED!"
	  echo ----------------------
	  TEST_FAILED=1
fi  
}

#############################################################################
# Check whether healthcheck response suceeded, i.e. contains <"status": "UP" >
# Parameters:
#        $1 - HTTP response
#############################################################################
assert_healthcheck_succeeded() {
set +x
#Extract HTTP status as a number
RESPONSE_JSON=${1}
echo "Service status='${RESPONSE_JSON}'"
# Assert value == "UP"
if [ "${RESPONSE_JSON}" == "UP" ]
  then
	  echo "Test PASSED"
	  echo ======================
  else
	  echo "Test FAILED!"
	  echo ======================
	  TEST_FAILED=1
fi  
}

#####################################################################
# Check whether the string $1 is literally equal to given string $2 
# Parameters:
#        $1 - actual value
#        $2 - expected value
#####################################################################
assert_strings_equal() {
set +x
echo "Assert: '${1}' == '${2}' (as expected)"
if [ "${1}" == "${2}" ]
  then
	  echo "Test PASSED"
	  echo ======================
  else
	  echo "Test FAILED!"
	  echo ======================
	  TEST_FAILED=1
fi  
}


# Make sure TARGET_HOST env var is set, otherwise activate DEBUG mode
if [ -z ${TARGET_HOST+x} ]; 
  then 
    echo "D DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG D"
    echo "E                                                             E"
    echo "B Env var 'TARGET_HOST' is not set. DEBUG mode is activated!  B"
    echo "U                                                             U"
    echo "G DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG G"
	TARGET_HOST=ibdock1
	PORT_PREFIX=10
	PROJECT_PREFIX=dev1

	# Initialize ports
	IBIN_BACKEND_CONFIG_SERVICE_PORT=${PORT_PREFIX}000
	IBIN_BACKEND_SERVICE_REGISTRY_PORT=${PORT_PREFIX}001
	IBIN_BACKEND_STORAGE_SERVICE_PORT=${PORT_PREFIX}002
	IBIN_BACKEND_CORE_SERVICE_PORT=${PORT_PREFIX}003
	IBIN_BACKEND_FRONT_API_SERVICE_PORT=${PORT_PREFIX}004
	IBIN_FRONTEND_UI_PORT=${PORT_PREFIX}080
	IBIN_PROXY_PORT=${PORT_PREFIX}088
fi



echo "#################################################################"
echo "TEST FOR: ibin-backend-config-service"
ENDPOINT="http://${TARGET_HOST}:${IBIN_BACKEND_CONFIG_SERVICE_PORT}/core-service/${PROJECT_PREFIX}/"
echo  ENDPOINT=${ENDPOINT}

# Basic authentication with user:p@55w0rd
RESPONSE=`curl -sIX GET ${ENDPOINT} -H 'authorization: Basic dXNlcjpwQDU1dzByZA=='`
CURL_STATUS=$?
#echo CURL response:
#echo "${RESPONSE}"

assert_curl_succeeded ${CURL_STATUS}
#Extract HTTP status code from HTTP response with double grep
HTTP_STATUS=`echo "${RESPONSE}" | grep 'HTTP\/1\.1'|grep -o -E '[0-9]{3}'` 
assert_http_status_succeeded ${HTTP_STATUS}


echo "#################################################################"
echo "TEST FOR: ibin-backend-service-registry"
ENDPOINT="http://${TARGET_HOST}:${IBIN_BACKEND_SERVICE_REGISTRY_PORT}/"
echo  ENDPOINT=${ENDPOINT}

RESPONSE=`curl -siX GET ${ENDPOINT}`
CURL_STATUS=$?
assert_curl_succeeded ${CURL_STATUS}

#Extract HTTP status code from HTTP response with double grep
HTTP_STATUS=`echo "${RESPONSE}" | grep 'HTTP\/1\.1'|grep -o -E '[0-9]{3}'` 
assert_http_status_succeeded ${HTTP_STATUS}

#Extract status from HTML response with grep
SERVICE_STATUS=`echo "${RESPONSE}" | grep -oP '(?<=status</td><td>)[^<]+'`
assert_healthcheck_succeeded ${SERVICE_STATUS}


echo "#################################################################"
echo "TEST FOR: ibin-backend-storage-service"
ENDPOINT="http://${TARGET_HOST}:${IBIN_BACKEND_STORAGE_SERVICE_PORT}/storage/health"
echo  ENDPOINT=${ENDPOINT}

RESPONSE=`curl -siX GET ${ENDPOINT}`
CURL_STATUS=$?
#echo CURL response:
#echo "${RESPONSE}"
assert_curl_succeeded ${CURL_STATUS}

#Extract HTTP status code from HTTP response with double grep
HTTP_STATUS=`echo "${RESPONSE}" | grep 'HTTP\/1\.1'|grep -o -E '[0-9]{3}'` 
assert_http_status_succeeded ${HTTP_STATUS}

#Extract status from JSON response with grep
SERVICE_STATUS=`echo "${RESPONSE}" | grep -oP '(?<=status\"\:\")[^"]+'`
assert_healthcheck_succeeded ${SERVICE_STATUS}


echo "#################################################################"
echo "TEST FOR: ibin-backend-front-api-service"
ENDPOINT="http://${TARGET_HOST}:${IBIN_BACKEND_FRONT_API_SERVICE_PORT}/api/health"
echo  ENDPOINT=${ENDPOINT}

RESPONSE=`curl -siX GET ${ENDPOINT}`
CURL_STATUS=$?
#echo CURL response:
#echo "${RESPONSE}"
assert_curl_succeeded ${CURL_STATUS}

#Extract HTTP status code from HTTP response with double grep
HTTP_STATUS=`echo "${RESPONSE}" | grep 'HTTP\/1\.1'|grep -o -E '[0-9]{3}'` 
assert_http_status_succeeded ${HTTP_STATUS}

#Extract status from JSON response with grep
SERVICE_STATUS=`echo "${RESPONSE}" | grep -oP '(?<=status\"\:\")[^"]+'`
assert_healthcheck_succeeded ${SERVICE_STATUS}


echo "#################################################################"
echo "TEST FOR: ibin-backend-core-service"
ENDPOINT="http://${TARGET_HOST}:${IBIN_BACKEND_CORE_SERVICE_PORT}/core/health"
echo  ENDPOINT=${ENDPOINT}

RESPONSE=`curl -siX  GET ${ENDPOINT}`
CURL_STATUS=$?
#echo CURL response:
#echo "${RESPONSE}"
assert_curl_succeeded ${CURL_STATUS}

#Extract HTTP status code from HTTP response with double grep
HTTP_STATUS=`echo "${RESPONSE}" | grep 'HTTP\/1\.1'|grep -o -E '[0-9]{3}'` 
assert_http_status_succeeded ${HTTP_STATUS}

#Extract status from JSON response with grep
SERVICE_STATUS=`echo "${RESPONSE}" | grep -oP '(?<=status\"\:\")[^"]+'`
assert_healthcheck_succeeded ${SERVICE_STATUS}

echo "#################################################################"
echo "TEST FOR: ibin-frontend"
ENDPOINT="http://${TARGET_HOST}:${IBIN_FRONTEND_UI_PORT}/"
echo  ENDPOINT=${ENDPOINT}

RESPONSE=`curl -siX GET ${ENDPOINT}`
CURL_STATUS=$?
assert_curl_succeeded ${CURL_STATUS}

#Extract HTTP status code from HTTP response with double grep
HTTP_STATUS=`echo "${RESPONSE}" | grep 'HTTP\/1\.1'|grep -o -E '[0-9]{3}'` 
assert_http_status_succeeded ${HTTP_STATUS}

echo "#################################################################"
echo "TEST FOR: ibin-proxy"
ENDPOINT="http://${TARGET_HOST}:${IBIN_PROXY_PORT}/"
echo  ENDPOINT=${ENDPOINT}

RESPONSE=`curl -siX GET ${ENDPOINT}`
CURL_STATUS=$?
assert_curl_succeeded ${CURL_STATUS}

#Extract HTTP status code from HTTP response with double grep
HTTP_STATUS=`echo "${RESPONSE}" | grep 'HTTP\/1\.1'|grep -o -E '[0-9]{3}'` 
assert_http_status_succeeded ${HTTP_STATUS}


if [ ${TEST_FAILED} -ne 0 ]; 
  then
    echo ""
    echo "EEEEEEE    RRRRRR     RRRRRR      OOOOO     RRRRRR     !! "
    echo "E          R     R    R     R    O     O    R     R    !! "
    echo "E          R     R    R     R    O     O    R     R    !! "
    echo "EEEEEE     RRRRRR     RRRRRR     O     O    RRRRRR     !! "
    echo "E          R   R      R   R      O     O    R   R      !! "
    echo "E          R    R     R    R     O     O    R    R        "
    echo "EEEEEEE    R     R    R     R     OOOOO     R     R    !! "
    echo ""
    echo "###########################################################"
    echo "   ERROR: there are FAILED test(s) for: ${PROJECT_PREFIX}"
    echo "###########################################################"
  else
    echo ""
    echo "       OOOOO     K     K  "
    echo "      O     O    K    K   "
    echo "      O     O    K   K    "
    echo "      O     O    KKKK     "
    echo "      O     O    K   K    "
    echo "      O     O    K    K   "
    echo "       OOOOO     K     K  " 
    echo ""
    echo "**********************************"
    echo "     All tests PASSED for: ${PROJECT_PREFIX}"
    echo "**********************************"
fi

# Enable "exit on error" feature
set -e

exit ${TEST_FAILED}

