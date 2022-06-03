## Serialize vars to Json while debugging
```java
ObjectMapper objectMapper = new com.fasterxml.jackson.databind.ObjectMapper()
    .registerModule(new com.fasterxml.jackson.datatype.jsr310.JavaTimeModule())
    .registerModule(new com.fasterxml.jackson.datatype.jdk8.Jdk8Module())
    .disable(com.fasterxml.jackson.databind.SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
    .disable(com.fasterxml.jackson.databind.DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
```

```java
new com.fasterxml.jackson.databind.ObjectMapper()
  .registerModule(new com.fasterxml.jackson.datatype.jsr310.JavaTimeModule())
  .registerModule(new com.fasterxml.jackson.datatype.jdk8.Jdk8Module())
  .disable(com.fasterxml.jackson.databind.SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
  .disable(com.fasterxml.jackson.databind.DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES)
  .writeValueAsString(varName)
```


## Spring context
ContextLoader.getCurrentWebApplicationContext();
