# Kafka


## References
- https://kafka.apache.org/
  - https://kafka.apache.org/documentation/
- https://spring.io/projects/spring-kafka
  - https://github.com/spring-projects/spring-kafka/tree/main/samples
- https://spring.io/projects/spring-cloud-stream
  - https://github.com/spring-cloud/spring-cloud-stream-samples/
- https://docs.confluent.io/kafka/operations-tools/kafka-tools.html

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
