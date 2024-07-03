# MongoDB

https://www.mongodb.com/
https://hub.docker.com/_/mongo
https://www.mongodb.com/docs/manual/tutorial/getting-started/

## Data Types
https://www.mongodb.com/docs/manual/reference/bson-types/
https://www.mongodb.com/docs/manual/core/schema-validation/

# Config
https://docs.mongodb.com/manual/reference/configuration-options/
https://www.mongodb.com/docs/manual/reference/method/
https://docs.mongodb.com/manual/reference/program/mongod/

## Drivers
https://www.mongodb.com/docs/drivers/
- https://www.mongodb.com/docs/languages/java/
  - https://www.mongodb.com/docs/drivers/java/sync/current/
  - https://www.mongodb.com/docs/languages/java/reactive-streams-driver/current/
  - https://spring.io/projects/spring-data-mongodb
- https://www.mongodb.com/docs/languages/javascript/
  - https://www.mongodb.com/docs/drivers/node/current/
  - https://www.mongodb.com/docs/drivers/typescript/

## Notes
- databases and collections are created implicitly when saving documents

## Compass
- can create documents and select data types
- has mongosh
- can extract code for actions

## commands
- auth
~~~js
use admin
db.auth("root", "secret")
~~~
~~~js
mongosh admin --username root --password secret
mongosh admin -u root -p secret
mongosh --authenticationDatabase admin --username root --password secret
mongosh --authenticationDatabase admin --username root --password secret
~~~

### find (find, findOne, findOneAnd<Update|Replace|Delete>)
Returns the Cursor object. `it` command gets more items.
- find
~~~js
db.collectionName.find(filter)
db.collectionName.find(filter).pretty()

db.collectionName.find({field: "valueEq"}).pretty()
db.collectionName.find({field: {$gt: "value_greater_than"}}).pretty()

db.collectionName.find().forEach(doc => printjson(doc))

# find with array item = x
db.collectionName.find({arrayField: "itemValueEq"}).pretty()

# find with embedded document value
db.collectionName.find({embeddedDocumentField.field: "valueEq"}).pretty()
~~~

### projection
~~~js
db.passengers.find({}, {name: 1}).pretty()
db.passengers.find({}, {name: 1, _id: 0}).pretty()
db.passengers.find().projection({name: 1}).pretty()
~~~

### insert (insertOne, insertMany)
- insertOne
~~~js
db.collectionName.insertOne({prop: "value"})
db.collectionName.insertOne({prop: "value", _id: "customId"})
~~~

### update (update, updateOne, updateMany, replaceOne)
- updateMany
~~~js
db.collectionName.updateMany(filter, update, options)

// patching all documents (filter=all), to add/replace the field "someField"
db.collectionName.updateMany({}, {$set: {someField: "someValue"}})
~~~

- update
Works like updateMany but replaces the document.
~~~js
# replacing all documents (filter=all), to have the full document passed on
db.collectionName.updateMany({}, {someField: "someValue"})
~~~

### drop
~~~js
db.dropDatabase()
db.myCollection.drop()
~~~

### aggregate
~~~js
// first match, then lookup
db.myCollection.aggregate(
  [
    {
      $match: {
        name: "Mongo Book"
      }
    },
    {
      $lookup: {
        as: "authors",
        from: "authors",
        foreignField: "_id",
        localField: "authors"
      }
    }
  ]
)
~~~

### schema validation
~~~js
db.createCollection('posts', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      required: ['title', 'text', 'creator', 'comments'],
      properties: {
        title: {
          bsonType: 'string',
          description: 'must be a string and is required'
        },
        text: {
          bsonType: 'string',
          description: 'must be a string and is required'
        },
        creator: {
          bsonType: 'objectId',
          description: 'must be an objectid and is required'
        },
        comments: {
          bsonType: 'array',
          description: 'must be an array and is required',
          items: {
            bsonType: 'object',
            required: ['text', 'author'],
            properties: {
              text: {
                bsonType: 'string',
                description: 'must be a string and is required'
              },
              author: {
                bsonType: 'objectId',
                description: 'must be an objectid and is required'
              }
            }
          }
        }
      }
    }
  }
});

// or modify with validationAction (adds to logs)
db.runCommand({
  collMod: 'posts',
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      required: ['title', 'text', 'creator', 'comments'],
      properties: {
        title: {
          bsonType: 'string',
          description: 'must be a string and is required'
        },
        text: {
          bsonType: 'string',
          description: 'must be a string and is required'
        },
        creator: {
          bsonType: 'objectId',
          description: 'must be an objectid and is required'
        },
        comments: {
          bsonType: 'array',
          description: 'must be an array and is required',
          items: {
            bsonType: 'object',
            required: ['text', 'author'],
            properties: {
              text: {
                bsonType: 'string',
                description: 'must be a string and is required'
              },
              author: {
                bsonType: 'objectId',
                description: 'must be an objectid and is required'
              }
            }
          }
        }
      }
    }
  },
  validationAction: 'warn'
});

~~~