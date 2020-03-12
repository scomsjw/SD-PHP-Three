# MySQL - Relationships, Foreign Keys and Joins
This practical follows on from last week's. We will work with multiple tables and  implement a database based on the films example (Film, Certificate, Genre classes) from the lecture. First, have a look at the lecture slides so you are familiar with the class diagram, relationships and physical data model.

## Creating the tables
The order in which we create the tables is important e.g. we need to add a foreign key to the *films* table that references the *certificates* table, so we need to create the *certificates* table first.  The *film_genre* table references both the *films* table and *genres* table, so these two tables need to be set up before creating the *film_genre* table.

### Creating the *certificates* table
Enter the following SQL command to create the certificates table.

```sql
CREATE  TABLE certificates
(
id INT UNSIGNED NOT  NULL  AUTO_INCREMENT,
name VARCHAR(30 )  NOT  NULL ,
description TEXT  NOT  NULL ,
image VARCHAR(30)  NOT  NULL ,
CONSTRAINT PRIMARY KEY (id)
);
```

This is very similar to the examples we did last week.

### Setting up the foreign key in the *films* table
First we need to delete the existing data in the *films* table (we will get errors if we try to add a foreign column to the existing rows). Enter the following SQL command.

```sql
DELETE from films;
```

The SQL ALTER command allows us to modify the columns in a database table. Enter the following ALTER command to add a new column (note the data type of *certificate_id* matches the data type of the *id* column in *certificates* exactly.

```sql
ALTER TABLE films ADD certificate_id INT UNSIGNED
```

Next we want to state that *certificate_id* is a foreign key column. Enter the following SQL command.

```sql
ALTER TABLE films ADD CONSTRAINT fk_films_certificates_certificate_id
FOREIGN KEY (certificate_id)
REFERENCES certificates(id)
```
* The *films* table is now set-up.

### Creating the *genres* table
Enter the following SQL command to create the *genres* table. Again, this is very similar to the examples we looked at last week.

```sql
CREATE  TABLE genres
(
id INT UNSIGNED NOT  NULL  AUTO_INCREMENT,
name VARCHAR(30 )  NOT  NULL ,
description TEXT NOT  NULL ,
CONSTRAINT PRIMARY KEY (id)
);

```

### Creating the *film_genre* junction table
Creating the junction table is a bit different
* We need a composite primary
* We declare the foreign key constraints when creating the table.

Enter the following SQL:

```sql
CREATE  TABLE film_genre
(
film_id INT UNSIGNED NOT  NULL,
genre_id INT UNSIGNED NOT  NULL,
CONSTRAINT PRIMARY KEY (film_id,genre_id),
CONSTRAINT fk_film_genre_films_film_id FOREIGN KEY (film_id) REFERENCES films(id),
CONSTRAINT fk_film_genre_films_genre_id FOREIGN KEY (genre_id) REFERENCES genres(id)      
);

```
## Inserting data
We need to add data to these tables in a set order. We can't add films unless we have certificates for them to reference. We can't add values to the *film_genre* table unless we have films and genres to reference.

### Adding data to the *certificates* table
Run the following SQL command:

```sql
INSERT INTO certificates (id, name, description, image)
VALUES
(NULL, 'U', 'Suitable for all', 'u-cert.png'),
(NULL, 'PG', 'Some scenes may be unsuitable for young children', 'pg-cert.png'),
(NULL, '12', 'Suitable for people aged 12 and over.', '12-cert.png'),
(NULL, '15', 'Suitable for people aged 15 and over.', '15-cert.png'),
(NULL, '18', 'Suitable for people aged 18 and over.', '18-cert.png');
```

### Adding data to the *films* table
We can now insert data into the *films* table.
First we will reset the autoincrement value. You wouldn't normally bother but we do it now as it will keep your table consistent with the practical instructions.

```sql
ALTER TABLE films AUTO_INCREMENT = 1
```

And now we can insert into the *films* table (note the additional foreign key value specifying the certificate for the films).

```sql
INSERT INTO `films` (`id`, `title`, `year`, `duration`, `certificate_id`) VALUES
(1, 'Jaws', 1975, 124, 4),
(2, 'Winter\'s Bone', 2010, 100, 4),
(3, 'Do The Right Thing', 1989, 120, 4),
(4, 'The Incredibles', 2004, 115, 1),
(5, 'The Godfather', 1972, 177, 5),
(6, 'Dangerous Minds', 1995, 99, 4),
(7, 'Spirited Away', 2001, 124, 2),
(8, 'Moonlight', 2016, 111, 5),
(9, 'Life of PI', 2012, 127, 2),
(10, 'Gravity', 2013, 91, 3),
(11, 'Arrival', 2016, 116, 3),
(12, 'Wonder Woman', 2017, 141, 3),
(13, 'Mean Girls', 2004, 97, 4),
(14, 'Inception', 2010, 108, 3),
(15, 'Donnie Darko', 2001, 113, 4),
(16, 'Get Out', 2017, 103, 4);
```
* To make sure you understand how this works, try adding another film to the table.

### Adding data to the *genres* table
Run the following SQL command.

```sql
INSERT INTO `genres` (`id`, `name`, `description`) VALUES
(1, 'Drama', 'Drama is a genre of narrative fiction (or semi-fiction) intended to be more serious than humorous in tone, focusing on in-depth development of realistic characters who must deal with realistic emotional struggles.'),
(2, 'Thriller', 'A Thriller is a story that is usually a mix of fear and excitement. It has traits from the suspense genre and often from the action, adventure or mystery genres, but the level of terror makes it borderline horror fiction at times as well. '),
(3, 'Comedy', 'Comedy is a story that tells about a series of funny or comical events, intended to make the audience laugh.'),
(4, 'Fantasy', 'A fantasy story is about magic or supernatural forces, rather than technology, though it often is made to include elements of other genres, such as science fiction elements, if it happens to take place in a modern or future era.'),
(5, 'Crime', 'A crime story is about a crime that is being committed or was committed. It can also be an account of a criminal\'s life. It often falls into the action or adventure genres.'),
(6, 'Horror', 'A horror story is told to deliberately scare or frighten the audience, through suspense, violence or shock.'),
(7, 'Science Fiction', 'Science fiction (often shortened to Sci-Fi or SF) is a genre of speculative fiction, typically dealing with imaginative concepts such as advanced science and technology, spaceflight, time travel, and extraterrestrial life. ');
```

## Adding data to the *film_genre* table
Finally we can add data to the *film_genre* table.

```sql
INSERT INTO `film_genre` (`film_id`, `genre_id`) VALUES
(1, 2),
(2, 1),
(2, 2),
(3, 1),
(3, 3),
(4, 1),
(4, 3),
(4, 4),
(5, 5),
(6, 1),
(7, 4),
(8, 1),
(9, 1),
(10, 7),
(11, 7),
(12, 4),
(13, 1),
(13, 3),
(14, 2),
(14, 7),
(15, 1),
(16, 6);
```
Again, test your understanding by adding some additional rows to this table to specify genres for the the new film you have added.

## Getting data out using a join
Run the following SQL statement

```sql
SELECT films.title, certificates.name from films
INNER JOIN certificates
ON films.certificate_id=certificates.id;
```
You should get a list of all the films and their certificates. Now have a go writing SELECT statements that will do the following. You may need to refer to the additional lecture slides on SQL foreign keys and joins:
* Display the titles of all the 15 rated films

* Display all the 15 rated films that are less than 100 minutes in length

* Display a list of all films and their genres

* Display the genres associated with 'The Incredibles'

* Display a list of all the comedy films

* Display a list of all films that are categorised as thriller or crime

* Display the number of films classified under each certificate

* Display the number of films for each genre

* Display the complete details - certificate genres etc. for 'Dangerous Minds'


* Display all the 15 rated films that are categorised as comedies

* Display the average duration of the films classified under each certificate. Order this list by duration from longest to shortest.



## Deleting data
* Have a go at writing an SQL statement (or series of statements) that will delete a film from the database.

## On your own
* A lot of what we have done in the last two weeks using SQL can also be done using the phpmyadmin graphical user interface. Select the *films* table and have a go at the following:
* Click on the *insert* tab. See how you can use an HTML form to insert data into tables
* Click on *structure* and then *relations* and see how you edit the properties of foreign key relationships.  
