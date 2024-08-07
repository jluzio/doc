# OpenSearch

osPass='OPENsearch123!'
curl -X GET "https://localhost:9200" -ku admin:$osPass
curl -X GET "https://localhost:9200/_cat/nodes?v" -ku admin:$osPass
curl -X GET "https://localhost:9200/_cat/plugins?v" -ku admin:$osPass

## Getting Started
https://opensearch.org/docs/latest/getting-started/quickstart/
https://opensearch.org/docs/latest/getting-started/communicate/

### examples
- Indexing documents
~~~
PUT /students/_doc/1
{
  "name": "John Doe",
  "gpa": 3.89,
  "grad_year": 2022
}
~~~

- Get mapping
~~~
GET /students/_mapping
~~~

- Updating documents
~~~
PUT /students/_doc/1
{
  "name": "John Doe",
  "gpa": 3.91,
  "grad_year": 2022,
  "address": "123 Main St."
}
~~~

- Deleting a document
~~~
DELETE /students/_doc/1
~~~

- Deleting a indx
~~~
DELETE /students
~~~

- Index mapping and settings
~~~
PUT /students
{
  "settings": {
    "index.number_of_shards": 1
  }, 
  "mappings": {
    "properties": {
      "name": {
        "type": "text"
      },
      "grad_year": {
        "type": "date"
      }
    }
  }
}
~~~

- Ingest bulk
~~~
POST _bulk
{ "create": { "_index": "students", "_id": "1" } }
{ "name": "John Doe", "gpa": 3.89, "grad_year": 2022}
{ "create": { "_index": "students", "_id": "2" } }
{ "name": "Jonathan Powers", "gpa": 3.85, "grad_year": 2025 }
{ "create": { "_index": "students", "_id": "3" } }
{ "name": "Jane Doe", "gpa": 3.52, "grad_year": 2024 }
~~~

- Searching documents
https://opensearch.org/docs/latest/getting-started/search-data/

~~~
GET /students/_search

# Same as
GET /students/_search
{
  "query": {
    "match_all": {}
  }
}

GET /students/_search?q=name:john

GET /students/_search
{
  "query": {
    "match": {
      "name": "john"
    }
  }
}

GET /students/_search
{
  "query": {
    "match": {
      "name.keyword": "john"
    }
  }
}

GET students/_search
{
  "query": { 
    "bool": { 
      "filter": [ 
        { "range": { "gpa": { "gt": 3.6 }}}
      ]
    }
  }
}

GET students/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "name": "doe"
          }
        },
        { "range": { "gpa": { "gte": 3.6, "lte": 3.9 } } },
        { "term":  { "grad_year": 2022 }}
      ]
    }
  }
}

GET students/_search
{
  "query": {
    "bool": {
      "must": {
        "match": {
          "user.id": "User-2"
        }
      }
    }
  }
}
~~~
