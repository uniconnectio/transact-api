#!/bin/bash

# install jq, a command line JSON parser 
# download site https://stedolan.github.io/jq/download/
# on Ubuntu, install using "sudo apt-get install jq"
# on Mac, install using "brew install jq"

# Azure API Management BaseUrl = https://uniconnect-transact.azure-api.net
# Alternate domain name for BaseUrl = http://transact.uniconnect.io (https will return cert error)

BASE_URL='https://uniconnect-transact.azure-api.net'

# CURL_OPTS='-w /*%{time_connect}:%{time_starttransfer}:%{time_total}*/'
CURL_OPTS=''

# Access-Token API (T24) 
RES=$(curl -X POST "$BASE_URL/security/authentication/access-token" \
  $CURL_OPTS \
  -H 'Content-Type: application/json' \
  -d '{ "email": "demouser2@uniconnect.com", "password": "demo@2018", "strategy": "local", "companyCode": "GB0010001", "bankId": "5b07e07962b26ba8a0fd3c28" }' )

# Access-Token API (Finacle) 
#RES=$(curl $CURL_OPTS -X POST \
#  "$BASE_URL/security/authentication/access-token" \
#  -H 'Content-Type: application/json' \
#  -d '{ "email": "finacle@uniconnect.com", "password": "demo@2018", "strategy": "local", "companyCode": "", "bankId": "5b07e08a62b26ba8a0fd3c33" }' )

# parse access-token value
TOKEN=$(echo "$RES" | jq -r '.accessToken')

echo $RES | jq .
echo $TOKEN

# Welcome Profile API  
RES=$(curl -X GET "$BASE_URL/customermgmt/welcome/profile" \
  $CURL_OPTS \
  -H "Authorization: Bearer $TOKEN" )

echo $RES | jq .

# Welcome Messages API 
RES=$(curl -X GET "$BASE_URL/customermgmt/welcome/messages" \
  $CURL_OPTS \
  -H "Authorization: Bearer $TOKEN" )

echo $RES | jq .

# Accounts List API 
RES=$(curl -X GET "$BASE_URL/accountmgmt/retail/accounts" \
  $CURL_OPTS \
  -H "Authorization: Bearer $TOKEN" )

# parse first accountId
ACTID=$(echo "$RES" | jq '.[0].accountId')

echo $RES | jq .
echo $ACTID

# Account Details API 
RES=$(curl -X GET "$BASE_URL/accountmgmt/retail/accounts/$ACTID" \
  $CURL_OPTS \
  -H "Authorization: Bearer $TOKEN" )

echo $RES | jq .

# Transactions History API 
RES=$(curl -X GET "$BASE_URL/accountmgmt/retail/accounts/$ACTID/transactions?fromDate=20130401&toDate=20140430" \
  $CURL_OPTS \
  -H "Authorization: Bearer $TOKEN" )

echo $RES | jq .

# Full Profile API 
RES=$(curl -X GET "$BASE_URL/customermgmt/profile/profile" \
  $CURL_OPTS \
  -H "Authorization: Bearer $TOKEN" )

echo $RES | jq .

