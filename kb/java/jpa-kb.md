# equals and hashCode
[Ultimate Guide to Implementing Equals & HashCode with Hibernate & JPA](https://www.youtube.com/watch?v=YoF3RcxbVQ4)

- use default

Requirement: if not working with multiple Hibernate sessions or detached entities

~~~java
@Entity
public class Book {

    @Id
    @GeneratedValue
    private Long id;

    private String title;

    //Getters and setters omitted for brevity
}
~~~

- use id 

Requirement: hashCode must be constant

~~~java
@Entity
public class Book {

    @Id
    @GeneratedValue
    private Long id;

    private String title;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null) return false;
        if (getClass() != o.getClass()) return false;
        if (!(o instanceof Book)) return false;
        Book book = (Book) o;
        return Objects.equals(id, book.getId());
    }

    @Override
    public int hashCode() {
        return getClass().hashCode();
        // or return 13;

    }

    //Getters and setters omitted for brevity
}
~~~

- business key 

Requirement: must be immutable

~~~java
@Entity
public class Book {

    @Id
    @GeneratedValue
    private Long id;

    private String title;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null) return false;
        if (getClass() != o.getClass()) return false;
        if (!(o instanceof Book)) return false;
        Book book = (Book) o;
        return Objects.equals(title, book.getTitle());
    }

    @Override
    public int hashCode() {
        return getClass().hashCode();
    }
    //Getters and setters omitted for brevity
}
~~~
