# Databases

The problems in this chapter that involve code are presented as just plain
sql with a file ('housing.sql') for the creation of the tables and the
seed data. I have tested the code against SQLite on
[SQLFiddle](http://sqlfiddle.com) (SQL.js, not WebSQL). All of the code
can just be copied, pasted, and run. Or you can just use SQLite CLI.

----------

Additionally, a few problems do not involve any code. These problems are
answered below:

* [4, types of joins](#4---types-of-joins)
* [5, denormalization](#5---denormalization)

----------

I've skipped the following problems from this chapter because I didn't think
that they were that interesting:

* 6, entity relationship diagram
* 7, student grades database design

----------

## 4 - Types of Joins
> What are the different types of joins? Please explain how they differ and
why certain types are better in certain situations.

An inner join (the default type of join) is an intersection between two data
separate sets. So joining two tables using a foreign key from one to match on
the primary key on another means finding all the records between both tables
where the values on that column (the keys) are the same (excluding null).

A full outer join is the union between two separate data sets. It will use
records from both data sets and try to match them together based on the column
that is being joined. If they cannot be matched, however, their corresponding
match will simply be null for either data set (left or right).

A left outer join also matches on a column between two data sets. If a record
from the left data set cannot be matched to a record from the right data set,
it will still be included and its matching record will be null. The inverse,
however, is not true.

A right outer join is the same as a left outer join, except reversed. All
right records are included and matched (or paired with null if there is no
match) but not all left records are included.

There is also a cross join which performs the cross product of the data sets.
Each record from first dataset is matched with each record of the second.

----------

## 5, Denormalization
> What is denormalization? Explain the pros and cons.

Denormalization is a trade off between space and speed. Data is stored
redundantly in a table so that a join does not need to be performed to retrieve
the data. Not having to perform a join optimizes the speed of the query at the
cost of wasted space. In addition, it is also dangerous since the redundant
data must now be kepy consistent against any further changes through extra
constraints. This slows down later operations that perform writes.

----------
