#!/bin/bash

set -e

if [[ -z "${CDS_LIC_FILE}" ]]; then
  echo "[ERROR]: CDS_LIC_FILE is unset"
  exit 1
fi

