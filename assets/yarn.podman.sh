#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

exec podman run -it --rm -v $SCRIPT_DIR/..:/app --workdir /app/assets node:18 yarn $@
