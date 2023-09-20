# kong-plugin-oidc-acl
Restrict access to a Service or a Route by whitelisting or blacklisting user using arbitrary ACL role names. This plugin requires an [oidc](https://github.com/nokia/kong-oidc) plugin to have been already enabled on the Service or Route. This plugin is specifically build for [keycloak](https://www.keycloak.org/) 

## Install

Install luarocks and run the following command

```bash
luarocks install kong-plugin-oidc-acl
```
You also need to set the KONG_PLUGINS environment variable

```bash
export KONG_PLUGINS=bundled,oidc-acl
```

## Configuration

To enable the plugin only for one service:

```bash
curl -X POST http://localhost:8001/services/{ID}/plugins \
    --data "name=oidc-acl"  \
    --data "config.whitelist=admin" \
    --data "config.whitelist=user"
```

| Form Parameter         | Default    | Required        | Description                                                                                                                         |
|------------------------|------------|-----------------|-------------------------------------------------------------------------------------------------------------------------------------|
| `userinfo_header_name` | x-userinfo | *optional*      | The name of the HTTP header from where role names is going to be extracted. This should be same as what you have set in oidc plugin |
| `whitelist`            |            | *semi-optional* | The name of the role to allow                                                                                                       |
| `blacklist`            |            | *semi-optional* | The name of the role to not allow                                                                                                   |


## References

Prebuild by Pravin Rahangdale
Maintain & Upgrade by ME!
