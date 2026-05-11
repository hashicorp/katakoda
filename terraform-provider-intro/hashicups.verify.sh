# Copyright IBM Corp. 2017, 2026
# SPDX-License-Identifier: MPL-2.0

if curl -sL --fail localhost:19090/health -o /dev/null; then
    echo "done"
else
    echo "Not ready yet"
fi
