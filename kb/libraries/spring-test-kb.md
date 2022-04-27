# Tests

## Bugs
Usage of org.springframework.http.MediaType constants can make tests fail when running the test suite.

Example:
```java
assertThat(mediaTypeVar).isEqualTo(MediaType.APPLICATION_JSON)
```

Workaround is to use the string value:
```java
assertThat(mediaTypeVar).isEqualTo(MediaType.valueOf(MediaType.APPLICATION_JSON_VALUE)```
