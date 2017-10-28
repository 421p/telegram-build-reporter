#!/usr/bin/env bash

test_result=$1

token=${TBR_TOKEN:?"TBR_TOKEN is not set"}
target=${TBR_TARGET:?"TBR_TARGET is not set"}

success_message=${TBR_SUCCESS:='✅ Build passed!'}
fail_message=${TBR_FAIL:='❌ Build failed!'}

function notify {
    wget --quiet \
      --method POST \
      --header 'content-type: application/json' \
      --body-data "{\"chat_id\":\"${target}\",\"text\":\"$1\"}" \
      --output-document \
      - https://api.telegram.org/bot${token}/sendMessage >> /dev/null
}

[[ ${test_result} -eq 0 ]] && notify "${success_message}" || notify "${fail_message}"