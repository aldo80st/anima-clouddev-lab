package clouddev

import rego.v1

default allow := false

allow if {
    input.action == "internal_development"
    input.scope == "sandbox"
    input.grant == true
}
