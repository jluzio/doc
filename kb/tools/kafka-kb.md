# Kafka


## References
- https://kafka.apache.org/
  - https://kafka.apache.org/documentation/
- https://spring.io/projects/spring-kafka
  - https://github.com/spring-projects/spring-kafka/tree/main/samples
- https://spring.io/projects/spring-cloud-stream
  - https://github.com/spring-cloud/spring-cloud-stream-samples/
- https://docs.confluent.io/kafka/operations-tools/kafka-tools.html

### Connectors
- https://www.confluent.io/product/connectors/
- https://www.confluent.io/hub/

### Conduktor
- https://www.conduktor.io/kafka/java-kafka-programming/
- https://www.conduktor.io/kafka/advanced-kafka-consumer-with-java/


## Main Concepts
Apache Kafka is a distributed streaming platform used for building real-time data pipelines and streaming applications. It is designed to handle high throughput, low-latency, and fault-tolerant data streaming. Here are the main concepts in Kafka:

### 1. **Topics**
- **Definition:** A topic is a category or feed name to which records are sent. It is the core abstraction in Kafka.
- **Function:** Topics allow for the organization of data streams. Each topic can have multiple producers (data sources) and consumers (data sinks).

### 2. **Producers**
- **Definition:** Producers are the programs or applications that publish (write) data to Kafka topics.
- **Function:** They push data records to specific topics. Producers can choose the partition within a topic to send the records to.

### 3. **Consumers**
- **Definition:** Consumers are the programs or applications that read (consume) data from Kafka topics.
- **Function:** They pull data records from topics, usually in the order they were produced. Consumers can belong to consumer groups, allowing for load-balanced processing.

### 4. **Partitions**
- **Definition:** Each topic is split into partitions, which are the basic unit of parallelism in Kafka.
- **Function:** Partitions allow Kafka to scale horizontally. Each partition is an ordered, immutable sequence of records and is distributed across the Kafka cluster.

### 5. **Offsets**
- **Definition:** An offset is a unique identifier for each record within a partition.
- **Function:** Offsets keep track of the position of each record within the partition, enabling consumers to read records sequentially and to resume from a specific point in case of failures.

### 6. **Brokers**
- **Definition:** A Kafka broker is a server that stores data and serves client requests.
- **Function:** Brokers handle data ingestion, storage, and retrieval. A Kafka cluster is composed of multiple brokers to ensure fault tolerance and scalability.

### 7. **Clusters**
- **Definition:** A Kafka cluster consists of multiple brokers working together.
- **Function:** Clusters provide redundancy and high availability. Data is replicated across multiple brokers to ensure durability and reliability.

### 8. **Consumer Groups**
- **Definition:** A consumer group is a collection of consumers that work together to consume records from one or more topics.
- **Function:** Consumer groups enable load balancing and parallel data processing. Each record is delivered to only one consumer in the group.

### 9. **Leaders and Followers**
- **Definition:** Each partition has one leader and zero or more followers.
- **Function:** The leader handles all read and write requests for the partition. Followers replicate the leader's data and take over in case the leader fails.

### 10. **Replication**
- **Definition:** Data in Kafka is replicated across multiple brokers.
- **Function:** Replication ensures fault tolerance and high availability by keeping multiple copies of the data in different brokers.

### 11. **ZooKeeper**
- **Definition:** Apache ZooKeeper is a coordination service for distributed applications.
- **Function:** Kafka uses ZooKeeper to manage cluster metadata, such as broker information, topic configurations, and partition leadership.

### 12. **Streams API**
- **Definition:** The Streams API is a library for building real-time streaming applications.
- **Function:** It allows for processing data records in a stream, performing operations like filtering, joining, and aggregating.

### 13. **Connect API**
- **Definition:** The Connect API is a framework for integrating Kafka with other systems.
- **Function:** It simplifies the process of moving large collections of data into and out of Kafka with pre-built connectors for various data sources and sinks.

Understanding these key concepts is essential for working effectively with Kafka, as they form the foundation of its architecture and functionality.


## Encoding/Decoding messages
In Apache Kafka, encoding and decoding of messages are crucial processes that ensure data is correctly serialized for transmission and deserialized for consumption. Here's a detailed explanation of how this works:

### 1. **Serialization (Encoding)**

**Serialization** is the process of converting an object or data structure into a byte stream, which can be easily transmitted over the network or stored. In Kafka, this process happens on the producer side before sending the data to the Kafka broker.

#### Steps for Serialization:
- **Choose a Serializer:** Kafka producers must use a serializer to convert the message data into bytes. Kafka provides several serializers, and users can also implement custom serializers.
- **Serialization Formats:**
  - **StringSerializer:** Converts strings to byte arrays.
  - **ByteArraySerializer:** Used if the data is already in byte array format.
  - **AvroSerializer:** Serializes data using the Apache Avro format, which includes a schema for defining the data structure.
  - **JSON Serializer:** Converts data into JSON format and then into a byte array.
  - **Protocol Buffers:** Google's language-neutral, platform-neutral mechanism for serializing structured data.
- **Serialize the Message:** The chosen serializer is used to convert the message (key and value) into a byte array.
- **Send to Broker:** The serialized byte array is sent to the Kafka broker, where it is stored in the appropriate partition of the topic.

### 2. **Deserialization (Decoding)**

**Deserialization** is the process of converting a byte stream back into an object or data structure. In Kafka, this process occurs on the consumer side after the data is fetched from the Kafka broker.

#### Steps for Deserialization:
- **Choose a Deserializer:** Kafka consumers must use a deserializer to convert the byte array back into the original message format. Kafka provides several deserializers, and users can also implement custom deserializers.
- **Deserialization Formats:**
  - **StringDeserializer:** Converts byte arrays back to strings.
  - **ByteArrayDeserializer:** Used if the data is to be consumed as a byte array.
  - **AvroDeserializer:** Deserializes data from the Avro format using the schema.
  - **JSON Deserializer:** Converts the byte array back into JSON format and then into the original data structure.
  - **Protocol Buffers:** Converts byte arrays back into structured data using Protocol Buffers.
- **Deserialize the Message:** The chosen deserializer is used to convert the byte array back into the original message (key and value).
- **Process the Data:** The deserialized message is then processed by the consumer application.

### Example of Serialization and Deserialization:
Suppose a producer is sending user information (e.g., user ID and name) to a Kafka topic.

#### Producer Side (Serialization):
```java
Properties props = new Properties();
props.put("bootstrap.servers", "localhost:9092");
props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");

KafkaProducer<String, String> producer = new KafkaProducer<>(props);

String userId = "user123";
String userName = "John Doe";

ProducerRecord<String, String> record = new ProducerRecord<>("users", userId, userName);
producer.send(record);
producer.close();
```

#### Consumer Side (Deserialization):
```java
Properties props = new Properties();
props.put("bootstrap.servers", "localhost:9092");
props.put("group.id", "user-consumer-group");
props.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
props.put("value.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");

KafkaConsumer<String, String> consumer = new KafkaConsumer<>(props);
consumer.subscribe(Collections.singletonList("users"));

while (true) {
    ConsumerRecords<String, String> records = consumer.poll(Duration.ofMillis(100));
    for (ConsumerRecord<String, String> record : records) {
        String userId = record.key();
        String userName = record.value();
        System.out.printf("Consumed record with key %s and value %s%n", userId, userName);
    }
}
```

### Custom Serializers and Deserializers:
Users can implement their own serializers and deserializers by implementing the `Serializer` and `Deserializer` interfaces, respectively. This flexibility allows Kafka to handle various data formats and structures efficiently.

### Summary:
- **Serialization:** Converts data from its original format into a byte array for transmission or storage.
- **Deserialization:** Converts byte arrays back into their original data format for processing.
- **Built-in Serializers/Deserializers:** Kafka provides common serializers and deserializers, but custom ones can be implemented as needed.

This process ensures that data is correctly transmitted between producers and consumers in a Kafka ecosystem.


## Bootstrap Server
**Bootstrap Server**: The bootstrap server is a list of one or more Kafka broker addresses provided by the client (producer or consumer) to initialize the connection to the Kafka cluster. These addresses are used by the client to discover the rest of the Kafka cluster.

### How It Works

1. **Client Configuration**:
    - When a Kafka client (producer or consumer) is configured, it requires a property called `bootstrap.servers`.
    - This property is a comma-separated list of host:port pairs of Kafka brokers.
    - Example: `bootstrap.servers = "broker1:9092,broker2:9092,broker3:9092"`

2. **Cluster Discovery**:
    - The client connects to one of the specified bootstrap servers.
    - The bootstrap server returns metadata about the Kafka cluster, including information about all brokers, topics, and partitions.
    - The client uses this metadata to establish connections to the appropriate brokers that hold the partitions it needs to produce to or consume from.

3. **Subsequent Interactions**:
    - After the initial connection and metadata retrieval, the client does not need to rely solely on the bootstrap servers.
    - The client maintains connections to the relevant brokers in the cluster and periodically refreshes the metadata to adapt to any changes (like new brokers being added or existing brokers failing).

### Key Points

- **Not a Full List**: The bootstrap servers list does not need to contain all brokers in the cluster. It just needs enough brokers to retrieve the complete cluster metadata.
- **Fault Tolerance**: If some of the bootstrap servers are down or unreachable, the client can still connect to the cluster using the other specified servers.
- **Simplified Client Configuration**: By providing only a few broker addresses, client configuration is simplified while still ensuring the client can discover the full cluster.

### Summary

- **Bootstrap Server**: A set of broker addresses used by clients to connect to the Kafka cluster initially.
- **Purpose**: Enables clients to retrieve cluster metadata and discover the full Kafka cluster.
- **Configuration**: Specified using the `bootstrap.servers` property in client configurations.
- **Redundancy**: Ensures high availability and fault tolerance by allowing clients to connect even if some brokers are down. 

This mechanism simplifies the process of client initialization and cluster discovery in a distributed environment, making Kafka a robust and scalable streaming platform.


## Transaction acknowledgement
- acks=0 : do not require
- acks=1 : leader
- acks=all (or -1) : leader and replicas (default for Kafka 3+)
  - min.insync.replicas
    - 1: only leader (default)
    - 2: leader and one replica (recommended along with 3 replicas)

## Availability
Considering replication factor = 3
- acks=0 and acks=1: if 1 partition is up and considered an ISR, the topic will be available for writes
- acks=all:
  - min.insync.replicas=1 (default): topic must have at least 1 partition as an ISR (that includes the leader) and so we can tolerate 2 brokers down
  - min.insync.replicas=2: topic must have at least 2 ISR up, and we tolerate 1 broker down
  - min.insync.replicas=3: wouldn't make sense to not allow any broker go down, since it might be replaced
  - in summary: when acks=all, replication.factor=N and min.insync.replicas=M, we tolerate N-M brokers being down for the topic to be considered available


## Consumers
### Polling
- that's when partition rebalance might occur
- commit offsets if auto commit is enabled, after the assigned interval
~~~
enable.auto.commit = true
auto.commit.interval.ms = 5000
~~~

## Producers
### Retries
- Auto retries defaults to `INTEGER.MAX_VALUE` for Kafka 2.1+.
- `retry.backoff.ms` default is 100
- until it exceeds producer timeout `delivery.timeout.ms=120000` (2m)
- if not using an idempotent producer (not recommended, old Kafka), messages can be sent out of order
  - use `max.in.flight.requests.per.connection` to 1 (default is 5) to avoid this 

### Idempotent Producer
- doesn't write duplicate messages due to retries on network errors
- default for Kafka 3.0
~~~
enable.idempotence=true
~~~

if enabled results in:
- retries=MAX
- max.in.flight.requests.per.connection=5 (Kafka 1+)
- acks=all

### Producer defaults
Since Kafka 3.0, producers are safe by default.
- acks=all
- enable.idempotence=true

Kafka < 3
- acks=1
- enable.idempotence=false

Recommended for Kafka < 3
~~~
acks=all
min.insync.replicas=2
enable.idempotence=true
retries=MAX
delivery.timeout.ms=120000
max.in.flight.requests.per.connection=5
~~~

### Message compression
- Producer level
`compression.type`
  - none (default)
  - gzip
  - snappy
  - lz4
  - zstd
Note: messages are stored compressed, and consumers must decompress the message
Consider using snappy or lz4 for optimal speed

- Broker level
`compression.type`
  - producer (default): messages are stored as sent by the producer
  - none: batches are decompressed by the broker
  - <algorithm>: if the same from the producer stores as is, if different decompressed message and compresses with new algorithm

### Batch
- linger.ms (default=0): time to wait until sending the batch
- batch.size: max number of bytes (default 16KB) to send in a batch
  - batch is allocated by partion, so don't set it too high
  - can monitor Kafka Producer metrics

### Default partitioner
Kafka 2.4+: Sticky Partitioner (improves performance when key=null)
Kafka 2.4-: Round Robin (more partitions to send, more batches, less performance)


## Consumer
### Delivery Semantics
- At most once: offsets are committed when batch is received, if the consumer crashes before processing all messages, messages are lost
- At least once: offsets are committed when batch is processed, if the consumer crashes before processing all messages, messages will be processed twice. Processing of a message must be idempotent.
- Exactly once: For Kafka => Kafka, can be achieved using the Transactional API (easy with Kafka Streams API). For Kafka => Sink workflows, use a idempotent consumer.

### Offset commit behaviour
- auto (enable.auto.commit=true)
Regular commit of offsets (enables "At least once" by default). 
Commits on poll when `auto.commit.interval.ms` has passed.
Make sure messages are successfully processed when calling again poll to ensure "At least once".

- manual
Called on consumer with `commitSync` or `commitAsync`.

### Offset reset behaviour
- auto.offset.reset
  - latest: read at the end of the log
  - earliest: read at the start of the log
  - none: use saved offset or throw exception if there isn't any

- offset.retention.minutes: Offsets are preserved for 7 days (v 2.0+).

### Heartbeat
- heartbeat.interval.ms: default 3s
How often to send heartbeats

- session.timeout.ms: default 45s (v >= 3.0)
if no heartbeat is sent during this time, the consumer is considered dead

### Polling
- max.poll.interval.ms: default 5m
max time between polls to consider the consumer dead

- max.poll.records: default 500
how many records per poll request
consider lowering if we take lots of time to process messages, or increasing if we process messages really quick

- fetch.min.bytes: default 1
how much we pull per request

- fetch.max.wait.ms: default 500
max amount of time broker will block before answering the fetch request if there isn't sufficient data

- max.partition.fetch.bytes: default 1MB
max amount of data per partition on fetch

- fetch.max.bytes: default 55MB
max data size return per fetch

### Consumer Rack Awareness
Consumers can read from the nearest replica on Kafka v >= 2.4, to reduce latency or additional costs (cloud).

Broker settings:
- rack.id: data center id
- replica.selector.class: org.apache.kafka.common.replica.RackAwareReplicaSelector

Consumer settings:
- client.rack: set with data center id


# Kafka Connect
A Kafka connector is a component used within the Kafka Connect framework, which is part of the Apache Kafka ecosystem. Kafka Connect is a tool for scalably and reliably streaming data between Apache Kafka and other systems. It enables the integration of various data sources and sinks with Kafka.

Kafka connectors come in two main types:

1. **Source Connectors**: These connectors import data from an external system into Kafka topics. They can read data from databases, message queues, file systems, cloud storage, and other sources.

2. **Sink Connectors**: These connectors export data from Kafka topics to an external system. They can write data to databases, search indexes, file systems, cloud storage, and other destinations.

### Key Features of Kafka Connect

- **Scalability**: Kafka Connect can scale to accommodate a high volume of data flows.
- **Fault Tolerance**: It provides built-in fault tolerance, which ensures the reliability of data transfers.
- **Distributed and Standalone Modes**: Kafka Connect can run in distributed mode for production environments or standalone mode for simpler use cases or testing.
- **Configuration and Management**: Connectors are configured using JSON files or REST API, making it easy to set up and manage.
- **Schema Management**: It supports schema management and can enforce schema compatibility using Confluent Schema Registry.

### Use Cases

- **Database Ingestion**: Continuously ingest data from databases into Kafka topics.
- **Streaming Data to Data Warehouses**: Stream data from Kafka topics to data warehouses like Amazon Redshift, Google BigQuery, etc.
- **Log Aggregation**: Collect and aggregate logs from various sources into Kafka for centralized processing.
- **Real-Time Analytics**: Stream data from Kafka topics to analytic engines for real-time analysis.

### Example

Here is an example of how you might configure a Kafka source connector to pull data from a MySQL database:

```json
{
  "name": "mysql-source-connector",
  "config": {
    "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
    "tasks.max": "1",
    "connection.url": "jdbc:mysql://localhost:3306/mydatabase",
    "connection.user": "myuser",
    "connection.password": "mypassword",
    "table.whitelist": "mytable",
    "mode": "incrementing",
    "incrementing.column.name": "id",
    "topic.prefix": "mysql-",
    "poll.interval.ms": "1000"
  }
}
```

This configuration specifies a Kafka Connect source connector that pulls data from a MySQL database table called `mytable` and writes it to a Kafka topic prefixed with `mysql-`.

Kafka connectors significantly simplify the process of integrating various data systems with Kafka, allowing for the seamless and efficient movement of data across different platforms.

### Commands
- connect-standalone.sh 
- connect-distributed.sh
- ...

### Connectors
- Connector Hub: https://www.confluent.io/hub
  - Elastic Search: https://www.confluent.io/hub/confluentinc/kafka-connect-elasticsearch
- Wikimedia: https://github.com/conduktor/kafka-connect-wikimedia

### User guide
https://docs.confluent.io/platform/current/connect/userguide.html
Where to install plugins (connectors), how to run, etc.


# Kafka Streams
Kafka Streams is a powerful and lightweight Java library provided by Apache Kafka for building real-time, event-driven applications and microservices. It allows developers to process data streams in real-time, leveraging the capabilities of Kafka's distributed messaging system.

### Key Features of Kafka Streams

1. **Stream Processing**: Kafka Streams enables the processing of continuous real-time streams of data.
2. **Scalability**: It can be scaled horizontally by running multiple instances of the application.
3. **Fault Tolerance**: Kafka Streams ensures fault tolerance through Kafka's replication and persistent storage.
4. **Stateful and Stateless Processing**: It supports both stateless and stateful operations, including aggregations, joins, and windowed operations.
5. **Exactly Once Semantics**: Kafka Streams provides strong guarantees around message processing, ensuring that messages are processed exactly once.
6. **Interactive Queries**: It allows querying the state of your application directly, providing a way to interactively query the stream processing application's state.

### Core Concepts

1. **Streams and Tables**: 
   - A **stream** is an unbounded sequence of records, each with a key, value, and timestamp.
   - A **table** is a collection of key-value pairs where the latest value for each key is kept, essentially representing the latest state.

2. **KStream and KTable**:
   - **KStream**: Represents a stream of records. It is used for stateless transformations like filtering, mapping, etc.
   - **KTable**: Represents a changelog stream, where each record is an update to the state of a key.

3. **Topology**:
   - A topology is a directed acyclic graph of stream processing nodes that defines the processing logic of your application.
   - It consists of **source processors**, **stream processors**, and **sink processors**.

### Example of Kafka Streams

Here's a simple example of a Kafka Streams application that reads from an input topic, processes the data, and writes the results to an output topic.

```java
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.KafkaStreams;
import org.apache.kafka.streams.StreamsBuilder;
import org.apache.kafka.streams.StreamsConfig;
import org.apache.kafka.streams.kstream.KStream;

import java.util.Properties;

public class WordCountApplication {
    public static void main(String[] args) {
        Properties props = new Properties();
        props.put(StreamsConfig.APPLICATION_ID_CONFIG, "wordcount-application");
        props.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");
        props.put(StreamsConfig.DEFAULT_KEY_SERDE_CLASS_CONFIG, Serdes.String().getClass().getName());
        props.put(StreamsConfig.DEFAULT_VALUE_SERDE_CLASS_CONFIG, Serdes.String().getClass().getName());

        StreamsBuilder builder = new StreamsBuilder();

        KStream<String, String> textLines = builder.stream("input-topic");

        KStream<String, Long> wordCounts = textLines
            .flatMapValues(textLine -> Arrays.asList(textLine.toLowerCase().split("\\W+")))
            .groupBy((key, word) -> word)
            .count()
            .toStream();
        wordCounts.to("output-topic");

        KafkaStreams streams = new KafkaStreams(builder.build(), props);
        streams.start();
    }
}
```

### Explanation of the Example

1. **Configuration**: Sets up the properties needed for the Kafka Streams application.
2. **Stream Definition**: Defines a stream from the `input-topic`.
3. **Processing**: 
   - Splits the text lines into words.
   - Groups by words and counts the occurrences.
4. **Output**: Writes the word counts to the `output-topic`.
5. **Execution**: Starts the Kafka Streams application.

Kafka Streams simplifies the development of real-time stream processing applications, providing a robust, scalable, and fault-tolerant platform that integrates seamlessly with Kafka.


## Schema Registry
The Schema Registry is a critical component in the Apache Kafka ecosystem, particularly when working with Kafka's serialization formats such as Avro, Protobuf, and JSON Schema. It provides a centralized repository for managing schemas and ensures that data being written to and read from Kafka topics adheres to these schemas.

### Key Features of the Schema Registry

1. **Centralized Schema Management**: Stores and retrieves schemas for Kafka topics, ensuring consistency and reusability.
2. **Schema Versioning**: Supports versioning of schemas, allowing for backward, forward, and full compatibility checks.
3. **Compatibility Enforcement**: Ensures that any changes to schemas are compatible with previous versions, preventing data inconsistencies and serialization errors.
4. **RESTful Interface**: Provides a REST API for registering, retrieving, and managing schemas.
5. **Integration with Kafka Clients**: Works seamlessly with Kafka producers and consumers, making it easy to serialize and deserialize messages according to the stored schemas.

### Benefits of Using the Schema Registry

- **Data Quality and Consistency**: Ensures that data conforms to predefined schemas, preventing errors and inconsistencies.
- **Ease of Evolution**: Manages schema versions and compatibility, making it easier to evolve data formats without breaking existing applications.
- **Interoperability**: Facilitates integration between different systems by standardizing data formats.

### Example Use Case

Consider a scenario where you are using Avro serialization for messages in Kafka. Here's how the Schema Registry fits into the process:

1. **Schema Definition**: Define an Avro schema for your data.
2. **Register Schema**: Register the schema with the Schema Registry using its REST API.
3. **Produce Messages**: When producing messages, the Kafka producer retrieves the schema from the Schema Registry and uses it to serialize the data.
4. **Consume Messages**: When consuming messages, the Kafka consumer retrieves the schema from the Schema Registry and uses it to deserialize the data.

### Example Workflow

1. **Register a Schema**:

```sh
curl -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" \
    --data '{"schema": "{\"type\": \"record\", \"name\": \"User\", \"fields\": [{\"name\": \"name\", \"type\": \"string\"}, {\"name\": \"age\", \"type\": \"int\"}]}"}' \
    http://localhost:8081/subjects/User-value/versions
```

2. **Retrieve a Schema**:

```sh
curl -X GET http://localhost:8081/subjects/User-value/versions/latest
```

3. **Producer Code Example**:

```java
Properties props = new Properties();
props.put("bootstrap.servers", "localhost:9092");
props.put("key.serializer", "io.confluent.kafka.serializers.KafkaAvroSerializer");
props.put("value.serializer", "io.confluent.kafka.serializers.KafkaAvroSerializer");
props.put("schema.registry.url", "http://localhost:8081");

Producer<String, GenericRecord> producer = new KafkaProducer<>(props);

String topic = "users";
Schema schema = new Schema.Parser().parse(new File("user.avsc"));
GenericRecord user = new GenericData.Record(schema);
user.put("name", "Alice");
user.put("age", 30);

ProducerRecord<String, GenericRecord> record = new ProducerRecord<>(topic, "key1", user);
producer.send(record);
producer.close();
```

4. **Consumer Code Example**:

```java
Properties props = new Properties();
props.put("bootstrap.servers", "localhost:9092");
props.put("group.id", "user-consumer-group");
props.put("key.deserializer", "io.confluent.kafka.serializers.KafkaAvroDeserializer");
props.put("value.deserializer", "io.confluent.kafka.serializers.KafkaAvroDeserializer");
props.put("schema.registry.url", "http://localhost:8081");

Consumer<String, GenericRecord> consumer = new KafkaConsumer<>(props);
consumer.subscribe(Collections.singletonList("users"));

while (true) {
    ConsumerRecords<String, GenericRecord> records = consumer.poll(Duration.ofMillis(100));
    for (ConsumerRecord<String, GenericRecord> record : records) {
        System.out.println(record.value());
    }
}
```

In this workflow, the Schema Registry ensures that both the producer and consumer use the correct schema for serialization and deserialization, enabling seamless and consistent data exchange.


# Real world insights and Case studies

## Partitions Count and Replication factor
Best to get it right on the start, since changing partitions breaks distribution with keys.

### Partitions
More partitions implies:
- better parallelism and throughput
- ability to run consumers in a group to scale
- ability to leverage more brokers
- more elections (if using Zookeper)
- more files opened

Guidelines:
- (intuition) small cluster (< 6 brokers): 3 * brokers
- (intuition) large cluster (> 12 brokers): 2 * brokers
- adjust for number of consumers you need to run in parallel at peak throughput
- adjust for producer throughput (increase if very high or expected to increase in the next 2 years)
- TEST!

### Replication Factor
Should be at least 2, usually 3, max 4.

The higher it is:
- better durability
- better availability
- more replication, higher latency
- more disk space


# Topics naming convenction
https://cnr.sh/essays/how-paint-bike-shed-kafka-topic-naming-conventions

<message type>.<dataset name>.<data name>.<data format>
(other: <message type>.<dataset name>.<data name>)

Here, valid message type values are left up to the organization to define. 
Typical types include:
- logging: For logging data (slf4j, syslog, etc)
- queuing: For classical queuing use cases.
- tracking: For tracking events such as user clicks, page views, ad views, etc.
- etl/db: For ETL and CDC use cases such as database feeds.
- streaming: For intermediate topics created by stream processing pipelines.
- push: For data that’s being pushed from offline (batch computation) environments into online environments.
- user: For user-specific data such as scratch and test topics.

`dataset name`: is analogous to database name in databases, a category to group topics.
`data name`: is analogous to the table in databases.
`data format`: for example avro, json, etc.

Use snake case.


# Monitoring
https://kafka.apache.org/documentation/#monitoring
https://docs.confluent.io/platform/current/kafka/monitoring.html
https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/


# Security
## Authentication
- SSL Authentication: authentication using certificates
- SASL/PLAINTEXT: username+password, weak but easy to setup
- SASL/SCRAM: username+password, with salt, more secure.
- Kerberos: strong but hard to setup
- SASL/OAUTHBEARER: OAUTH 2 tokens

## Authorization
ACL (Access control lists)


# advertised.listeners
- Kafka has defined an advertised.listeners endpoint, which will be requested for consumers and producers to use.
- This endpoint must be accessible to the client, otherwise communications will fail.


# Advanced topics
## Editing configuration
~~~bash
kafka-topics.sh --bootstrap-server localhost:9092 --topic some_topic --create --partitions 3 --replication-factor 1
kafka-topics.sh --bootstrap-server localhost:9092 --topic some_topic --describe

# dynamic configuration
kafka-configs.sh --bootstrap-server localhost:9092 --entity-type topics --entity-name some_topic --describe
kafka-configs.sh --bootstrap-server localhost:9092 --entity-type topics --entity-name some_topic --alter --add-config min.insync.replicas=2
kafka-configs.sh --bootstrap-server localhost:9092 --entity-type topics --entity-name some_topic --alter --delete-config min.insync.replicas

# cleanup
kafka-topics.sh --bootstrap-server localhost:9092 --topic some_topic --delete
~~~

## Segments
Offset data stored in files, grouped by segment files.
- log.segment.bytes: total size before creating new segment
- log.segment.ms: time until creating new segment

## Log cleanup
### Policies (log.cleanup.policy)
- delete: delete based on time (default: 1 week) and based on size (default: unlimited)
~~~md
- log.retention.hours: default=168
- log.retention.minutes
- log.retention.ms
- log.retention.bytes: default=-1
~~~~
- compact (used on `__consumer_offsets`): delete based on keys
~~~md
- segment.ms: default=7d
- segment.bytes: default=1GB
- min.compaction.lag.ms: default=0
- delete.retention.ms: default=24h
- min.cleanable.dirty.ratio: default=0.5
~~~

`log.cleaner.backoff.ms`: time to check for cleaning work.


## Large messages
Default limit is 1 MB per message.
Can use:
- Store large message in external system and reference that in Kafka messaeg
- Configure Kafka to handle bigger sizes
  - broker: message.max.bytes, replication.fetch.max.bytes
  - topic: max.message.bytes
  - consumer: max.partition.fetch.bytes
  - producer: max.request.size