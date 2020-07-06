#!/usr/bin/env bash
# shellcheck disable=SC2143

export log_dir="/root/.log"

echo "Reached scenario end" >> "$log_dir"/end.log
echo "done"
