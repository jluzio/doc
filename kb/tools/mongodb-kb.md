# MongoDB

https://www.mongodb.com/
https://hub.docker.com/_/mongo
https://www.mongodb.com/docs/manual/tutorial/getting-started/

## Data Types
https://www.mongodb.com/docs/manual/reference/bson-types/
https://www.mongodb.com/docs/manual/reference/mongodb-extended-json/#bson-data-types-and-associated-representations
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
~~~js
db.collection.find( <query>, <projection>, <options> )
~~~
~~~md
- More on find(): https://docs.mongodb.com/manual/reference/method/db.collection.find/
- More on Cursors: https://docs.mongodb.com/manual/tutorial/iterate-a-cursor/
- Query Operator Reference: https://docs.mongodb.com/manual/reference/operator/query/
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
~~~js
db.collection.insertMany(
   [ <document 1> , <document 2>, ... ],
   {
      writeConcern: <document>,
      ordered: <boolean>
   }
)
~~~
~~~md
- insertOne(): https://docs.mongodb.com/manual/reference/method/db.collection.insertOne/
- insertMany(): https://docs.mongodb.com/manual/reference/method/db.collection.insertMany/
- Atomicity: https://docs.mongodb.com/manual/core/write-operations-atomicity/#atomicity
- Write Concern: https://docs.mongodb.com/manual/reference/write-concern/
- Using mongoimport: https://docs.mongodb.com/manual/reference/program/mongoimport/index.html
~~~

### update (update, updateOne, updateMany, replaceOne)
- updateMany
~~~js
db.collectionName.updateMany(filter, update, options)
// patching all documents (filter=all), to add/replace the field "someField"
db.collectionName.updateMany({}, {$set: {someField: "someValue"}})
~~~
~~~js
db.collection.updateMany(
   <filter>,
   <update>,
   {
     upsert: <boolean>,
     writeConcern: <document>,
     collation: <document>,
     arrayFilters: [ <filterdocument1>, ... ],
     hint:  <document|string>,
     let: <document>
   }
)
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

### delete (deleteOne, deleteMany)
~~~js
db.collection.deleteMany(
   <filter>,
   {
      writeConcern: <document>,
      collation: <document>
   }
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


### cursors
- Non-Tailable Cursors: Do not include documents inserted after the cursor is created.
- Tailable Cursors: Can include newly inserted documents if they meet the query criteria, and the cursor remains open.

Note: Capped collections are fixed-size collections that insert and retrieve documents based on insertion order. Capped collections work similarly to circular buffers: once a collection fills its allocated space, it makes room for new documents by overwriting the oldest documents in the collection.

## capped collection
~~~js
db.createCollection("mycol", {capped: true, max: <maxDocs>, size: <maxStoredSize>})
~~~

### mongoimport
~~~js
mongoimport tv-shows.json --authenticationDatabase admin -u root -p secret -d course_testdb -c tvshows --jsonArray --drop
~~~


### operators
- https://www.mongodb.com/docs/manual/reference/operator/
  - https://www.mongodb.com/docs/manual/reference/operator/query/
  - https://www.mongodb.com/docs/manual/reference/operator/update/ 

#### query operators
~~~js
// $eq
db.inventory.find( { qty: { $eq: 20 } } )
db.inventory.find( { qty: 20 } )
// $eq in array
db.inventory.find( { tags: { $eq: [ "A", "B" ] } } )
// $eq using regex
db.companies.find( { company: /MongoDB/ }, {_id: 0 })
db.companies.find( { company: { $regex: /MongoDB/ } }, {_id: 0 } )
~~~
~~~md
# comparison
- $eq: Matches values that are equal to a specified value.
- $gt: Matches values that are greater than a specified value.
- $gte: Matches values that are greater than or equal to a specified value.
- $in: Matches any of the values specified in an array.
- $lt: Matches values that are less than a specified value.
- $lte: Matches values that are less than or equal to a specified value.
- $ne: Matches all values that are not equal to a specified value.
- $nin: Matches none of the values specified in an array.

# logical
- $and: Joins query clauses with a logical AND returns all documents that match the conditions of both clauses.
- $not: Inverts the effect of a query expression and returns documents that do not match the query expression.
- $nor: Joins query clauses with a logical NOR returns all documents that fail to match both clauses.
- $or: Joins query clauses with a logical OR returns all documents that match the conditions of either clause.

# element
- $exists: Matches documents that have the specified field.
- $type: Selects documents if a field is of the specified type.

# evaluation
- $expr: Allows use of aggregation expressions within the query language.
- $jsonSchema: Validate documents against the given JSON Schema.
- $mod: Performs a modulo operation on the value of a field and selects documents with a specified result.
- $regex: Selects documents where values match a specified regular expression.
- $text: Performs text search.
- $where: Matches documents that satisfy a JavaScript expression.

# geospacial
## query
- $geoIntersects: Selects geometries that intersect with a GeoJSON geometry. The 2dsphere index supports $geoIntersects.
- $geoWithin: Selects geometries within a bounding GeoJSON geometry. The 2dsphere and 2d indexes support $geoWithin.
- $near: Returns geospatial objects in proximity to a point. Requires a geospatial index. The 2dsphere and 2d indexes support $near.
- $nearSphere: Returns geospatial objects in proximity to a point on a sphere. Requires a geospatial index. The 2dsphere and 2d indexes support $nearSphere.
## geometry
- $box: Specifies a rectangular box using legacy coordinate pairs for $geoWithin queries. The 2d index supports $box.
- $center: Specifies a circle using legacy coordinate pairs to $geoWithin queries when using planar geometry. The 2d index supports $center.
- $centerSphere: Specifies a circle using either legacy coordinate pairs or GeoJSON format for $geoWithin queries when using spherical geometry. The - 2dsphere and 2d indexes support $centerSphere.
- $geometry: Specifies a geometry in GeoJSON format to geospatial query operators.
- $maxDistance: Specifies a maximum distance to limit the results of $near and $nearSphere queries. The 2dsphere and 2d indexes support $maxDistance.
- $minDistance: Specifies a minimum distance to limit the results of $near and $nearSphere queries. For use with 2dsphere index only.
- $polygon: Specifies a polygon to using legacy coordinate pairs for $geoWithin queries. The 2d index supports $center.

# array
- $all: Matches arrays that contain all elements specified in the query.
- $elemMatch: Selects documents if element in the array field matches all the specified $elemMatch conditions.
- $size: Selects documents if the array field is a specified size.

# bitwise
- $bitsAllClear: Matches numeric or binary values in which a set of bit positions all have a value of 0.
- $bitsAllSet: Matches numeric or binary values in which a set of bit positions all have a value of 1.
- $bitsAnyClear: Matches numeric or binary values in which any bit from a set of bit positions has a value of 0.
- $bitsAnySet: Matches numeric or binary values in which any bit from a set of bit positions has a value of 1.

# projection
- $: Projects the first element in an array that matches the query condition.
- $elemMatch: Projects the first element in an array that matches the specified $elemMatch condition.
- $meta: Projects the available per-document metadata.
- $slice: Limits the number of elements projected from an array. Supports skip and limit slices.
~~~

#### update operators
~~~md
# field
- $currentDate: Sets the value of a field to current date, either as a Date or a Timestamp.
- $inc: Increments the value of the field by the specified amount.
- $min: Only updates the field if the specified value is less than the existing field value.
- $max: Only updates the field if the specified value is greater than the existing field value.
- $mul: Multiplies the value of the field by the specified amount.
- $rename: Renames a field.
- $set: Sets the value of a field in a document.
- $setOnInsert: Sets the value of a field if an update results in an insert of a document. Has no effect on update operations that modify existing - documents.
- $unset: Removes the specified field from a document.

# array
- $: Acts as a placeholder to update the first element that matches the query condition.
- $[]: Acts as a placeholder to update all elements in an array for the documents that match the query condition.
- $[<identifier>]: Acts as a placeholder to update all elements that match the arrayFilters condition for the documents that match the query condition.
- $addToSet: Adds elements to an array only if they do not already exist in the set.
- $pop: Removes the first or last item of an array.
- $pull: Removes all array elements that match a specified query.
- $push: Adds an item to an array.
- $pullAll: Removes all matching values from an array.

# modifiers
- $each: Modifies the $push and $addToSet operators to append multiple items for array updates.
- $position: Modifies the $push operator to specify the position in the array to add elements.
- $slice: Modifies the $push operator to limit the size of updated arrays.
- $sort: Modifies the $push operator to reorder documents stored in an array.

# bitwise
- $bit: Performs bitwise AND, OR, and XOR updates of integer values.
~~~

### indexes
- explain
~~~js
db.collection.explain().<find|update|etc>
db.collection.<find|update|etc>.explain()

db.collection.explain(<mode>)
mode = queryPlanner (default) | executionStats | allPlansExecutions
~~~

- createIndex
~~~js
db.collection.createIndex( <keys>, <options>, <commitQuorum>)

db.collection.createIndex(
  {
      "a": 1
  },
  {
      unique: true,
      sparse: true,
      expireAfterSeconds: 3600
  }
)
~~~
~~~md
Options for all:
- unique: unique constraint
- partialFilterExpression: Optional. If specified, the index only references documents that match the filter expression.
- name: Optional. The name of the index. If unspecified, MongoDB generates an index name by concatenating the names of the indexed fields and the sort order.
- sparse: Optional. If true, the index only references documents with the specified field. These indexes use less space but behave differently in some situations (particularly sorts). The default value is false. 
- expireAfterSeconds: Optional. Specifies a value, in seconds, as a time to live (TTL) to control how long MongoDB retains documents in this collection. This option only applies to TTL indexes.
- <others>

NOTE: 
- If queries return most of the documents, it's slower with an index, since it has an extra step, while almost doing a COLSCAN.
- A compound index (2+ fields), is also used from left to right, i.e. can use the first field in search, besides using all fields in index.
~~~

- text index
~~~js
db.blog.createIndex( { "content": "text" } )

db.blog.find({$text: {$search: "keyword1 keyword2 ..."}, {score: {$meta: "textScore"}}}).sort({score: -1})

// project the text search score, and also sort by it
db.blogs.find({$text: {$search: "keyword1 keyword2 ..."}}).projection({score: {$meta: "textScore"}}).sort({score: {$meta: "textScore"}})   
~~~
~~~md
Note: can only have one text index, but it can have more than one field used in that index.

Options for text indexes:
- weights: Optional. For text indexes, a document that contains field and weight pairs. The weight is an integer ranging from 1 to 99,999 and denotes the significance of the field relative to the other indexed fields in terms of the score. You can specify weights for some or all the indexed fields. See Assign Weights to Text Search Results to adjust the scores. The default value is 1.
- default_language: Optional. For text indexes, the language that determines the list of stop words and the rules for the stemmer and tokenizer. See Text Search Languages for the available languages and Specify the Default Language for a Text Index for more information and examples. The default value is english.
- language_override: Optional. For text indexes, the name of the field, in the collection's documents, that contains the override language for the document. The default value is language. See Specify the Default Language for a Text Index for an example.
- textIndexVersion: Optional. The text index version number. Users can use this option to override the default version number.
~~~

- covered queries
If a query filters and returns only the fields of the index, it is covered by the index only, and it's faster.

- winning plans
Use all approaches for "100" records, and determine which is faster. Cache the winning plan for some time, until some X inserted records, change indexes or restart MongoDB.

### geospacial data
~~~js
// needs index
db.places.createIndex({location, "2dsphere"})

// find
// coordinates: [lon, lat]

db.places.find(
   {
     location:
       { $near :
          {
            $geometry: { type: "Point",  coordinates: [ -73.9667, 40.78 ] },
            $minDistance: 1000,
            $maxDistance: 5000
          }
       }
   }
)

// coordinates is array of array of points (array with 2 elems)
db.places.find(
   {
     location: {
       $geoWithin: {
          $geometry: {
             type : "Polygon" ,
             coordinates: [ [ [ 0, 0 ], [ 3, 6 ], [ 6, 1 ], [ 0, 0 ] ] ]
          }
       }
     }
   }
)
~~~

## aggregate
~~~js
db.collection.aggregate( <pipeline>, <options> )
~~~

~~~md
- Aggregation Operations: https://www.mongodb.com/docs/manual/aggregation/
  - Aggregation Reference: https://www.mongodb.com/docs/manual/reference/aggregation/
  - Aggregation Stages : https://www.mongodb.com/docs/manual/reference/operator/aggregation-pipeline/
  - Aggregation Operators : https://www.mongodb.com/docs/manual/reference/operator/aggregation/
  - Optimizations: https://www.mongodb.com/docs/manual/core/aggregation-pipeline-optimization/
~~~

### examples
~~~js
db.persons.aggregate(
  [
    {
      $project: {
        _id: 0,
        email: 1,
        gender: 1,
        birthDate: { $toDate: "$dob.date" },
        age: "$dob.age",
        location: {
          type: "Point",
          coordinates: [
            { $convert: { input: "$location.coordinates.longitude", to: "double" } },
            { $convert: { input: "$location.coordinates.latitude", to: "double" } }
          ]
        },
        fullName: {
          $concat: [
            { $toUpper: { $substrCP: ["$name.first", 0, 1] } },
            {
              $substrCP: [
                "$name.first",
                1,
                { $subtract: [{ $strLenCP: "$name.first" }, 1] }]
            },
            " ",
            { $toUpper: { $substrCP: ["$name.last", 0, 1] } },
            {
              $substrCP: [
                "$name.last",
                1,
                { $subtract: [{ $strLenCP: "$name.last" }, 1] }]
            },
          ]
        }
      }
    },
    {
      $group: {
        _id: { birthYear: {$isoWeekYear: "$birthDate"} },
        totalPersons: {$sum: 1}
      }
    }
  ]
)

// unwind to ungroup hobbies array, and then add them to set (only unique values)
db.friends.aggregate(
  [
    { $unwind: "$hobbies" },
    { $group: { _id: { age: "$age" }, allHobbies: {$addToSet: "$hobbies" } } }
  ]
)

// filter array items
db.friends.aggregate([
  {
    $project: {
      _id: 0,
      scores: { $filter: { input: '$examScores', as: 'sc', cond: { $gt: ["$$sc.score", 60] } } }
    }
  }
]).pretty();

// get best exam score
db.friends.aggregate([
  { $unwind: "$examScores" },
  { $project: { _id: 1, name: 1, age: 1, score: "$examScores.score" } },
  { $sort: { score: -1 } },
  { $group: { _id: "$_id", name: { $first: "$name" }, maxScore: { $max: "$score" } } },
  { $sort: { maxScore: -1 } }
]).pretty();

// buckets
db.persons
  .aggregate([
    {
      $bucket: {
        groupBy: '$dob.age',
        boundaries: [18, 30, 40, 50, 60, 120],
        output: {
          numPersons: { $sum: 1 },
          averageAge: { $avg: '$dob.age' }
        }
      }
    }
  ])
  .pretty();

db.persons.aggregate([
    {
      $bucketAuto: {
        groupBy: '$dob.age',
        buckets: 5,
        output: {
          numPersons: { $sum: 1 },
          averageAge: { $avg: '$dob.age' }
        }
      }
    }
  ]).pretty();

// limit and skip to get top 10 to 20
db.persons.aggregate([
    { $match: { gender: "male" } },
    { $project: { _id: 0, gender: 1, name: { $concat: ["$name.first", " ", "$name.last"] }, birthdate: { $toDate: "$dob.date" } } },
    { $sort: { birthdate: 1 } },
    { $skip: 10 },
    { $limit: 10 }
  ]).pretty();

// write to another collection
db.persons.aggregate([
    {
      $project: {
        _id: 0,
        name: 1,
        email: 1,
        birthdate: { $toDate: '$dob.date' },
        age: "$dob.age",
    },
    { $out: "transformedPersons" }
  ]).pretty();

db.transformedPersons.aggregate([
    {
      $geoNear: {
        near: {
          type: 'Point',
          coordinates: [-18.4, -42.8]
        },
        maxDistance: 1000000,
        num: 10,
        query: { age: { $gt: 30 } },
        distanceField: "distance"
      }
    }
  ]).pretty();

~~~

## users
https://www.mongodb.com/docs/manual/reference/method/js-user-management/
https://www.mongodb.com/docs/manual/reference/built-in-roles/#std-label-built-in-roles

- createUser
~~~js
db.createUser(user, writeConcern)

// example
db.createUser({user: 'dev', pwd: 'pass', roles: ['readWrite']})

// user
{
  user: "<name>",
  pwd: passwordPrompt(),      // Or  "<cleartext password>"
  customData: { <any information> },
  roles: [
    { role: "<role>", db: "<database>" } | "<role>",
    ...
  ],
  authenticationRestrictions: [
     {
       clientSource: ["<IP>" | "<CIDR range>", ...],
       serverAddress: ["<IP>" | "<CIDR range>", ...]
     },
     ...
  ],
  mechanisms: [ "<SCRAM-SHA-1|SCRAM-SHA-256>", ... ],
  passwordDigestor: "<server|client>"
}
~~~

- updateUser
~~~js
db.updateUser( username, update, writeConcern )

// example
db.updateUser("dev", {roles: ["readWrite", { role: "readWrite", db: "blog" }]})
~~~

## SSL
~~~powershell
# if using GIT, can just use a alias for openssl without installing another one
Set-Alias openssl 'C:\Program Files\Git\usr\bin\openssl.exe'
~~~

~~~bash
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 365
openssl req -x509 -newkey rsa:2048 -nodes -keyout mongodbkey.key -days 365 -out mongodbkey.crt
~~~


## Transactions
https://www.mongodb.com/docs/manual/core/transactions/
Requires replicas to be configured.

~~~js
use tx
db.users.insertOne({_id: 'user1', name: 'user1'})
db.posts.insertMany([{_id: 'post1', title: 'post1', userId: 'user1'}, {_id: 'post2', title: 'post2', userId: 'user1'}])

const session = db.getMongo().startSession()
const users = session.getDatabase('tx').users
const posts = session.getDatabase('tx').posts

session.startTransaction()

users.deleteMany({_id: 'user1'})
posts.deleteMany({userId: 'user1'})

session.commitTransaction()
// session.abortTransaction()
~~~

# Atlas
~~~md
Managed cloud solution, using AWS, Azure or Google Cloud.
Configures the cluster with security, backups, replicas, sharding, monitoring, alerts, etc.

Configured with dev account.

Note: Need to whitelist IP for access.
~~~
