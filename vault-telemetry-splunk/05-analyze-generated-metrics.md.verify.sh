#!/usr/bin/env bash
# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# shellcheck disable=SC2143

export log_dir="/root/.log"

echo "Reached scenario end" >> "$log_dir"/end.log
echo "done"
