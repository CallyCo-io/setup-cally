#!/bin/bash
set -eu
echo ::group::Downloading Cally $CALLY_VERSION for ${RUNNER_OS}-${RUNNER_ARCH}

PYTHON_VERSION=$(python3 -c "import sys;print(sys.version_info.minor)")
TOOL_OUTPUT_PATH="Cally-${CALLY_VERSION}-${RUNNER_OS}-${RUNNER_ARCH}-Python-3.${PYTHON_VERSION}"
DOWNLOAD_URL="https://github.com/${CALLY_REPO}/releases/download/v${CALLY_VERSION}/${TOOL_OUTPUT_PATH,,}.tar.gz"

if [[ -z $(wget -S --spider $DOWNLOAD_URL 2>&1 | grep 'HTTP/1.1 200 OK') ]];
then
    echo "::error::No release found at ${DOWNLOAD_URL}"
    echo ::endgroup::
    exit 1
fi

echo "download-url=${DOWNLOAD_URL}" >> $GITHUB_OUTPUT
echo "tool-output-path=${RUNNER_TOOL_CACHE}/${TOOL_OUTPUT_PATH}" >> $GITHUB_OUTPUT
echo cache-key=$(echo "${CALLY_VERSION} ${PROVIDERS}" | sha256sum -z | head -c 64) >> $GITHUB_OUTPUT
echo ::endgroup::
