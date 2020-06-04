### Context
InnoDB uses the B-Tree of the primary key to stores the data, the table rows.
That means __a primary key is mandatory__ with InnoDB.
 
If there is no primary key for a table, InnoDB adds a hidden auto-incremented 6 bytes counter to the table
and use that hidden counter as the primary key. For non-primary-keys, you then have a double-lookup into secondary then primary.
 
More details: https://www.youtube.com/watch?time_continue=370&v=1hAp8tNcZLA

### Defining a standard primary key

It is usually advised add a dedicated pk columns:
`id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY`
(starting with MariaDB 10.3 you can make it _[INVISIBLE](https://openquery.com.au/blog/mariadb-10-3-use-case-hidden-primary-key-column-for-closed-legacy-applications)_ )

But note that it may conflict with partitioning since (https://www.vertabelo.com/blog/everything-you-need-to-know-about-mysql-partitions/  ;  https://dev.mysql.com/doc/mysql-partitioning-excerpt/5.7/en/partitioning-limitations-partitioning-keys-unique-keys.html):

> A PRIMARY KEY must include all columns in the table's partitioning function. 
> If a table has no unique keys—this includes having no primary key—then this restriction does not apply, and you may use any column or columns in the partitioning expression as long as the column type is compatible with the partitioning type.

### Defining a compound primary key

MySQL documentation states:

> A PRIMARY KEY is a unique index where all key columns must be defined as `NOT NULL`.
> If they are not explicitly declared as NOT NULL, MySQL declares them so implicitly (and silently).

which may error with inserting NULL rows, so you should add e.g. `DEFAULT ''`  so that NULLs are coerced on insertion.

Also, according to https://federico-razzoli.com/primary-key-in-innodb:

> A table rows are physically ordered by primary key.
> Therefore, for performance reasons, new values should be appended to the end of the key.
> If values are inserted in the middle, InnoDB will have to do [additional operations](https://www.percona.com/blog/2017/04/10/innodb-page-merging-and-page-splitting/) to make room for them. 
