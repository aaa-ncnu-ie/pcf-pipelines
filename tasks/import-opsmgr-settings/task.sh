#!/bin/bash -eu

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

  chmod +x tool-om/om-linux
  local om="tool-om/om-linux"

  printf "Waiting for %s to come up" "$OPSMAN_URI"
  until $(curl --output /dev/null --silent --head --fail -k ${OPSMAN_URI}); do
    printf '.'
    sleep 5
  done
  printf '\n'

  $om --target "${OPSMAN_URI}" \
      --skip-ssl-validation \
      import-installation \
      --installation "${cwd}/opsmgr-settings/${OPSMAN_SETTINGS_FILENAME}" \
      --decryption-passphrase "${OPSMAN_PASSPHRASE}"
 }

 sudo apt-get update
 sudo apt-get install sshpass

 echo "Updating routes on opsman"

 echo "Setting  ${ROUTE1}"
 sshpass -e ssh -o StrictHostKeyChecking=no ubuntu@${OPSMAN_IP} ${ROUTE1}
 echo "Setting  ${ROUTE2}"
 sshpass -e ssh -o StrictHostKeyChecking=no ubuntu@${OPSMAN_IP} ${ROUTE2}
 echo "Setting  ${ROUTE3}"
 sshpass -e ssh -o StrictHostKeyChecking=no ubuntu@${OPSMAN_IP} ${ROUTE3}
 echo "Setting  ${ROUTE4}"
 sshpass -e ssh -o StrictHostKeyChecking=no ubuntu@${OPSMAN_IP} ${ROUTE4}
 
 main "${PWD}"
