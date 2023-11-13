# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

if curl -sL --fail localhost:19090/health -o /dev/null; then
    echo "done"
else
    echo "Not ready yet"
fi
