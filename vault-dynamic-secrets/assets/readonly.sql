-- Copyright IBM Corp. 2017, 2023
-- SPDX-License-Identifier: MPL-2.0

CREATE ROLE "{{name}}" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}' INHERIT;
GRANT ro TO "{{name}}";