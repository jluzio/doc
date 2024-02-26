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

- Filter list by property
~~~bash
[.[] | select(.name | contains("query-text"))]
~~~

- round to n-decimal
n=2
~~~bash
.*100 | round/100
~~~

- sum
<expr-to-select-array> | add
