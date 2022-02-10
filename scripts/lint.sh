#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

env DBT_MATERIALIZATION=table sqlfluff lint $@