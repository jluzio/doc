# jq
https://stedolan.github.io/jq/
https://stedolan.github.io/jq/manual/

## Examples

{ properties: [ { "name": "n1", "value": "v1" }, { "name": "n2", "value": "v2" }, ] }
cat properties.json | jq '.properties.property[] | { (.name): .value }'

cat properties.json | jq '.properties.property | from_entries'

- Remove quotes from result (if string)
use: -r | --raw-output
echo '"hello"' | jq . -r
