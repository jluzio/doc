## Serialize vars to Json while debugging
```java
// Include non-nulls
ObjectMapper objectMapper = new com.fasterxml.jackson.databind.ObjectMapper()
    .registerModule(new com.fasterxml.jackson.datatype.jsr310.JavaTimeModule())
    .registerModule(new com.fasterxml.jackson.datatype.jdk8.Jdk8Module())
    .disable(com.fasterxml.jackson.databind.SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
    .disable(com.fasterxml.jackson.databind.DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES)
    .setSerializationInclusion(com.fasterxml.jackson.annotation.JsonInclude.Include.NON_NULL)
    ;

// Include all
ObjectMapper objectMapper = new com.fasterxml.jackson.databind.ObjectMapper()
    .registerModule(new com.fasterxml.jackson.datatype.jsr310.JavaTimeModule())
    .registerModule(new com.fasterxml.jackson.datatype.jdk8.Jdk8Module())
    .disable(com.fasterxml.jackson.databind.SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
    .disable(com.fasterxml.jackson.databind.DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES)
    .setSerializationInclusion(com.fasterxml.jackson.annotation.JsonInclude.Include.NON_NULL)
    ;
```

```java
// Include non-nulls
new com.fasterxml.jackson.databind.ObjectMapper()
  .registerModule(new com.fasterxml.jackson.datatype.jsr310.JavaTimeModule())
  .registerModule(new com.fasterxml.jackson.datatype.jdk8.Jdk8Module())
  .disable(com.fasterxml.jackson.databind.SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
  .disable(com.fasterxml.jackson.databind.DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES)
  .setSerializationInclusion(com.fasterxml.jackson.annotation.JsonInclude.Include.NON_NULL)
  .writeValueAsString(varName)

// Include all
new com.fasterxml.jackson.databind.ObjectMapper()
  .registerModule(new com.fasterxml.jackson.datatype.jsr310.JavaTimeModule())
  .registerModule(new com.fasterxml.jackson.datatype.jdk8.Jdk8Module())
  .disable(com.fasterxml.jackson.databind.SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
  .disable(com.fasterxml.jackson.databind.DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES)
  .writeValueAsString(varName)
```


## Spring context
ContextLoader.getCurrentWebApplicationContext();
