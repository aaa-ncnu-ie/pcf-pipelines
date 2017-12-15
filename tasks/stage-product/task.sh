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

  chmod +x tool-om/om-linux
  CMD_PATH="tool-om/om-linux"

  local cwd
  cwd="${1}"

  local version
  pushd "${cwd}/pivnet-product"
    # if [ ${PRODUCT_NAME} = 'cf' ] #check for ERT product name due to verion name issue when returned as 1.11.11-build.4
    #  then
    #    version="$(ls -1 *.pivotal | sed "s/"${PRODUCT_NAME}"-\(.*\).pivotal/\1/" | sed "s/\(.*\)-build\(.*\)/\1/")" #updated variable
    #  elif
      if [ ${PRODUCT_NAME} = 'Pivotal_Single_Sign-On_Service' ]
      then
        version="$(ls -1 *.pivotal | sed "s/"${PRODUCT_NAME}"_\(.*\).pivotal/\1/" | sed "s/\(.*\)-build\(.*\)/\1/")"
      elif [ ${PRODUCT_NAME} = 'p-cloudcache' ]
      then
        version="$(ls -1 *.pivotal | sed "s/"${PRODUCT_NAME}"_\(.*\).pivotal/\1/" | sed "s/\(.*\).pivotal\(.*\)/\1/")"
      else
        version="$(ls -1 *.pivotal | sed "s/"${PRODUCT_NAME}"-\(.*\).pivotal/\1/" | sed "s/\(.*\)-build\(.*\)/\1/")" #updated variable
      #  version="$(ls -1 *.pivotal | sed "s/"${PRODUCT_NAME}"-\(.*\).pivotal/\1/")"
      fi
  popd

  ./${CMD_PATH} --target "${OPSMAN_URI}" \
     --skip-ssl-validation \
     --username "${OPSMAN_USERNAME}" \
     --password "${OPSMAN_PASSWORD}" \
     stage-product \
     --product-name "${PRODUCT_NAME}" \
     --product-version "${version}"
}

main "${PWD}"
