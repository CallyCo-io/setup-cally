#!/bin/bash
set -eu
echo ::group::Downloading Cally Providers

arg=$(echo ${PROVIDERS} | tr -d '\n' | sed 's/ //g' | sed 's/,$//g')
readarray -td, providers <<<"$arg,"; unset 'providers[-1]'; declare -p providers;

for provider in "${providers[@]}"; do
    echo "::info::Downloading ${provider}"
    if [[ "${provider}" == *\/* ]]; then
        src=$(echo "${provider}" | awk -F/ '{print $1}')
    else
        src=hashicorp
        provider=hashicorp/${provider}
    fi
    pkg=$(echo "${provider}" | awk -F/ '{print $2}' | awk -F@ '{print $1}')
    ver=$(echo "${provider}" | awk -F/ '{print $2}' | awk -F@ '{print $2}')
    # We don't throw an exit code if the provider fails, this will cause confusion
    cally provider build --source ${src} --provider ${pkg} --version ${ver}
    echo "::info::Installing ${provider}"
    (cd build/${pkg} && pip install . --target ${RUNNER_TEMP}/${provider})
    cp -a ${RUNNER_TEMP}/${provider}/. ${TOOL_OUTPUT_PATH}
    echo "::info::${provider} installed"
done

echo ::endgroup::
