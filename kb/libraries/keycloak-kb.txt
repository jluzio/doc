# Keycloak

## Examples
https://www.baeldung.com/spring-boot-keycloak

## Doc API
https://www.keycloak.org/docs/latest/authorization_services/index.html#_service_obtaining_permissions
https://www.keycloak.org/docs/latest/authorization_services/index.html#_service_protection_api

## Client and roles
https://medium.com/@mihirrajdixit/getting-started-with-service-accounts-in-keycloak-c8f6798a0675

## Service client
- create a client (e.g. manage-users-client)
- assign Service Accounts Enabled: true
- assign Access Type: confidential
- assign/view Credentials > Secret
- assign account roles
  - realm-management
    - manage-users
    - query-users
    - view-users
                                                                                                
## Import/Export
- export a realm in a environment
- create a environment locally, then select import file


## Direct grant login
Use a client with "Direct Access Grants Enabled" and client scopes that match the default login.


## Extensions
https://www.keycloak.org/docs/latest/server_development/index.html#_extensions
org.keycloak.services.resource.RealmResourceProviderFactory
Example for Backbase:
com.backbase.identity.authenticators.actions.RequiredActionsRealmResourceFactory
com.backbase.identity.resource.ProcessInactiveUsersResourceProviderFactory
com.backbase.identity.services.resource.CustomLoginActionsServiceProviderFactory
com.backbase.identity.resource.NativeLoginActionsResourceProviderFactory
com.backbase.identity.resource.ValidatePasswordResourceProviderFactory
com.backbase.identity.device.resource.FidoResourceProviderFactory


## redirect_uri
check "Valid Redirect URIs" on used client and use a valid one


## postman
{{callback-url}}
{{oidc-auth-url}}
{{oidc-token-url}}
{{client-id}}
{{client-secret}}

(secret is "" if client is public)

auth-root-url: http://localhost:8180
auth-url: {{auth-root-url}}/auth
realm-url: {{auth-url}}/realms/{{realm}}
oidc-auth-url: {{realm-url}}/protocol/openid-connect/auth
oidc-token-url: {{realm-url}}/protocol/openid-connect/token
realm: bnp
client-id: bb-web-client
client-secret: 
client-id-mobile: mobile-client
client-secret-mobile: 
callback-url: https://app.dev.bnp.live.backbaseservices.com/bnp-retail-app/
- check "Valid Redirect URIs" on used client and use a valid one


# Quarkus
https://quarkus.io/guides/logging
- Using env
QUARKUS_LOG_LEVEL: "INFO"
quarkus.log.category."org.keycloak.connections.jpa.updater.liquibase".level: "DEBUG"
