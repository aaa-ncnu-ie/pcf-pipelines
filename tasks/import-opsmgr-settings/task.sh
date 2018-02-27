#!/bin/bash

set -eu

# Copyright 2017-Present Pivotal Software, Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

function main() {
  local cwd
  cwd="${1}"

  printf "Waiting for %s to come up" "$OPSMAN_DOMAIN_OR_IP_ADDRESS"
  until $(curl --output /dev/null --silent --head --fail -k https://${OPSMAN_DOMAIN_OR_IP_ADDRESS}); do
    printf '.'
    sleep 5
  done
  printf '\n'

  om-linux --target "https://${OPSMAN_DOMAIN_OR_IP_ADDRESS}" \
      --skip-ssl-validation \
      --request-timeout 86400 \
      import-installation \
      --installation "${cwd}/opsmgr-settings/${OPSMAN_SETTINGS_FILENAME}" \
      --decryption-passphrase "${OPSMAN_PASSPHRASE}"
 }

 sudo apt-get update
 sudo apt-get install sshpass

 echo "Updating routes on opsman"

 if [ -z "${ROUTE1##*net*}" ]; then
   echo "Running command: \"echo PASSWORD| sudo -S ${ROUTE1}\""
   sshpass -e ssh -t -o StrictHostKeyChecking=no ubuntu@${OPSMAN_IP} "echo ${SSHPASS}| sudo -S ${ROUTE1}"
 fi

 if [ -z "${ROUTE2##*net*}" ]; then
   echo "Running command: \"echo PASSWORD| sudo -S ${ROUTE2}\""
   sshpass -e ssh -t -o StrictHostKeyChecking=no ubuntu@${OPSMAN_IP} "echo ${SSHPASS}| sudo -S ${ROUTE2}"
 fi

 if [ -z "${ROUTE3##*net*}" ]; then
   echo "Running command: \"echo PASSWORD| sudo -S ${ROUTE3}\""
   sshpass -e ssh -t -o StrictHostKeyChecking=no ubuntu@${OPSMAN_IP} "echo ${SSHPASS}| sudo -S ${ROUTE3}"
 fi

 if [ -z "${ROUTE4##*net*}" ]; then
   echo "Running command: \"echo PASSWORD| sudo -S ${ROUTE4}\""
   sshpass -e ssh -t -o StrictHostKeyChecking=no ubuntu@${OPSMAN_IP} "echo ${SSHPASS}| sudo -S ${ROUTE4}"
 fi

 if [ -z "${ROUTE5##*net*}" ]; then
   echo "Running command: \"echo PASSWORD| sudo -S ${ROUTE5}\""
   sshpass -e ssh -t -o StrictHostKeyChecking=no ubuntu@${OPSMAN_IP} "echo ${SSHPASS}| sudo -S ${ROUTE5}"
 fi

 if [ -z "${ROUTE6##*net*}" ]; then
   echo "Running command: \"echo PASSWORD| sudo -S ${ROUTE6}\""
   sshpass -e ssh -t -o StrictHostKeyChecking=no ubuntu@${OPSMAN_IP} "echo ${SSHPASS}| sudo -S ${ROUTE6}"
 fi

 echo -e $CERT > /tmp/test.crt
 echo -e $KEY > /tmp/test.key
 sed -i 's/^ //g' /tmp/test.key
 sed -i 's/^ //g' /tmp/test.crt

 echo "Moving old cert.."
 sshpass -e ssh -t -o StrictHostKeyChecking=no ubuntu@${OPSMAN_IP} "echo ${SSHPASS}| sudo -S cp /var/tempest/cert/tempest.crt /var/tempest/cert/tempest.crt.old"
 echo "Moving old key.."
 sshpass -e ssh -t -o StrictHostKeyChecking=no ubuntu@${OPSMAN_IP} "echo ${SSHPASS}| sudo -S cp /var/tempest/cert/tempest.key /var/tempest/cert/tempest.key.old"

 echo "Copying new key.."
 sshpass -e scp -o StrictHostKeyChecking=no /tmp/test.key ubuntu@${OPSMAN_IP}:/home/ubuntu/tempest1.key
 echo "Copying new cert.."
 sshpass -e scp -o StrictHostKeyChecking=no /tmp/test.crt ubuntu@${OPSMAN_IP}:/home/ubuntu/tempest1.crt

 echo "Putting new key in place.."
 sshpass -e ssh -t -o StrictHostKeyChecking=no ubuntu@${OPSMAN_IP} "echo ${SSHPASS}| sudo -S mv /home/ubuntu/tempest1.key /var/tempest/cert/tempest.key"
 echo "Putting new cert in place.."
 sshpass -e ssh -t -o StrictHostKeyChecking=no ubuntu@${OPSMAN_IP} "echo ${SSHPASS}| sudo -S mv /home/ubuntu/tempest1.crt /var/tempest/cert/tempest.crt"
 echo "Restarting nginx.."
 sshpass -e ssh -t -o StrictHostKeyChecking=no ubuntu@${OPSMAN_IP} "echo ${SSHPASS}| sudo -S service nginx restart"

 main "${PWD}"
