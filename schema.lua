local typedefs = require "kong.db.schema.typedefs"

return {
    name = "oidc-acl",
    fields = { {
        consumer = typedefs.no_consumer
    }, {
        protocols = typedefs.protocols_http
    }, {
        config = {
            type = "record",
            fields = {
                { allow = { type = "array", elements = { type = "string" }, }, },
                { userinfo_header_name = { type = "string", required = false, default = "x-userinfo" }, },
            },
            entity_checks = { {
                only_one_of = { "config.allow", "config.deny" }
            }, {
                at_least_one_of = { "config.allow", "config.deny" }
            } }

        }
    } }
}
