# Postman

## example login before request
let user = pm.environment.get('user')
let password = pm.environment.get('password')

pm.sendRequest({
    url: 'https://uat-ib.nbbonline.com/auth/realms/nbb-retail/protocol/openid-connect/token',
    method: 'POST',
    body: {
        mode: 'urlencoded',
        urlencoded: [
            {key: "username", value: user},
            {key: "password", value: password},
            {key: "grant_type", value: "password"},
            {key: "client_id", value: "test-client"}
        ]
    }
}, function (err, res) {
   pm.environment.set('access_token', res.json().access_token);
});


## example use response data
- pm.environment.set('userId', pm.response.json().id);
- pm.environment.set("XSRF-TOKEN", decodeURIComponent(pm.cookies.get("XSRF-TOKEN")))
