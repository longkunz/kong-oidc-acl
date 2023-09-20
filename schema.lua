local typedefs = require "kong.db.schema.typedefs"

return {
    name = "oidc-acl",
    fields = {
        { consumer = typedefs.no_consumer },
        { protocols = typedefs.protocols_http },
        {
            config = {
                type = "record",
                fields = {
                    { whitelist = { type = "elements", required = false } },
                    { blacklist = { type = "elements", required = false } },
                    { userinfo_header_name = { type = "string", required = false, default = "x-userinfo" } }
                },
                entity_checks = {
                    { only_one_of = { "config.whitelist", "config.blacklist" }, },
                    { at_least_one_of = { "config.whitelist", "config.blacklist" }, },
                },

            },
        },
    }
}