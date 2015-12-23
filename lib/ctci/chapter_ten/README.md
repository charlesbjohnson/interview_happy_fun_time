# Scalability and Memory Limits

This chapter is more focused on high level design/architecture than actual
code. As a result, there isn't any code (although there are some plain
english descriptions of code). They are:

1. [stock price data feed](#1---stock-price-data-feed)
2. [social network data structures](#2---social-network-data-structures)
3. [missing integer from billions](#3---missing-integer-from-billions)
4. [duplicate numbers in a large array](#4---duplicate-numbers-in-a-large-array)
5. [web crawler](#5---web-crawler)
6. [duplicate urls](#6---duplicate-urls)
7. [web server cache](#7---web-server-cache)

Instead, I've listed the answers to the questions below.

----------

## 1 - Stock Price Data Feed
> Imagine you are building some sort of service that will be called by up to
1000 client applications to get simple end-of-day stock price information
(open, close, high, low). You may assume that you already have the data, and
you can store it in any format you wish. How would you design the client-facing
service which provides the information to client applications? You are
responsible for the development, rollout, and ongoing monitoring and
maintenance of the feed. Describe the different methods you considered and why
you would recommend your approach. Your service can use any technologies you
wish, and can distribute the information to the client applications in any
mechanism you choose.

Store the data in a database. Create a RESTful web API over the database.
This would allow for fast queries since API calls map to SQL queries.
It is also safe since the client does not have access directly to the database.
Depending on the nature of the data, a relational database could be used or a
NoSQL database could be used.
This would also be very flexible in that the data could changed into different
formats if need be through the API layer.

----------

## 2 - Social Network Data Structures
> How would you design the data structures for a very large social network like
Facebook or LinkedIn? Describe how you would design an algorithm to show the
connection, or path, between two people (e.g., Me -> Bob -> Susan -> Jason -> You).

Each person is a node in a graph. Each outward edge represents a friend of that
specific node. Each outward edge from a node would be stored on that node as
each edge represents a friend of that person. Inward edges would not need to be
explicitly stored since they would already be stored as outward edges from the
node which the inward edge came from. TL;DR: a graph where nodes are people,
directed edges represent that a person is a friend (not mutual) with another
person.

Determining a path between people would be a breadth first search. Depth first
would be inefficient for connections between people who are close friends.
If a relationship between people was undirected, a BFS could also be performed
from both people simultaneously to increase speed.

Oh and some stuff about splitting person data across machines. Relationships
would have to reference a person by an id and the actual person data could be
retrieved from that id with some central person index that maps ids to machine
location where the actual data is stored. Not sure why any of that would be
particular to a social network though, you would have to use that technique
for lots of different types of data, even just plain relational data.

----------

## 3 - Missing Integer From Billions
> Given an input file with four billion non-negative integers, provide an
algorithm to generate an integer which is not contained in the file. Assume
you have 1 GB of memory available for this task.

>FOLLOW UP

> What if you have only 10 MB of memory? Assume that all the values are
distinct and we now have no more than one billion non-negative integers.

The algorithm is the same as if it were only 100 non-negative integers.
Create an array of booleans (or just bits) of size 2^32 (the maximum size an
integer from the file could be and also large enough to hold every number in
the file). Read in (or buffer several) integers from the file. Use the integer
that was read as an index for the bit/boolean array, and set its value to
1/true. Repeat for each number in the file. When the file has been read, go
through each index in the array until you reach a value that is 0/false.
The index of that value is the result.

With only 10 MB of memory you can only use an array of bits/booleans of size
2^23 or so.  The algorithm is the same, except with potentially multiple passes
of reading the file and you can only track integers in chunks of 2^23.
When you start, designate a value to represent the smallest number in the
chunk and another for the largest value in the chunk. So for the first pass
the min value is 0 and the max is 83,886,080. If there are no numbers in the
first pass, however, the chunk range will increment by 2^23 and the minimum
value will be 83,886,080 and the max will be 167,772,159. Likewise for the
second pass and so forth until the maximum value is the max value of an
integer (at which point there can be no larger integer than that).

For each number read, ignore it if it isnt between the chunk range otherwise
subtract the min value from it and set the value at that index in the array
to 1/true. Once the entire file has been read, look through the array at each
index to see if a value is 0/false. If there is one, return that index.
Otherwise shift the chunk and repeat the outlined process.

----------

## 4 - Duplicate Numbers In a Large Array
> You have an array with all the numbers from 1 to N, where N is at most
32,000. The array may have duplicate entries and you do not know what N is.
With only 4 kilobytes of memory available, how would you print all duplicate
elements in the array?

Four kilobytes is sufficient to create a bit/boolean array that can track
more than 32,000 numbers. Create an array of size 32,000 initialized
to 0/false for each value. Then go through each number in the input array
and use it as an index for the bit array. If the value at that index is
0/false, set it. If it already set, however, print the number. Repeat
for every number in the array.

----------

## 5 - Web Crawler
> If you were designing a web crawler, how would you avoid getting into
infinite loops?

You would have to store pages that you've already visited. You could store URLs
but that could be a problem if a server responds to a URL with different query
parameters by rendering the same page. At that point you don't have a clean
1-to-1 mapping from URLs to actual pages. You could have a page that links
to the same page but with a random query parameter in the URL, thereby
causing an infinite loop.

You also try to store the page itself (or a unique hash of its contents)
but that would also not work since the same page could have different content
at different times, such as a page with a twitter feed embedded into it.

You would need to identify a page based on its URL and the parts of the page's
content that do not change often (meta tag keywords or description attributes,
title tag contents, h1 to h6 tag contents, etc.). You could check against the
URL and then against a unique hash of these contents of the page.

----------

## 6 - Duplicate URLs
> You have 10 billion URLs. How do you detect the duplicate documents? In
this case, assume that 'duplicate' means that the URLs are identical.

The algorithms is based on using a hash to track items that have already
been seen, except it is split across multiple machines. Each machine
takes a group of URLs and performs the the tracking algorithm independently,
reporting their results back to an orchestrating machine when they are done.
URLs can be delegated to a specific machine based on the hash of the URL % the
number of machines available. That way it is likely that each machine will
be given the same URLs (or similar enough that they hash to the same value).

----------

## 7 - Web Server Cache
> Imagine a web server for a simplified search engine. This system as 100
machines to respond to search queries, which may then call out using
processSearch(string query) to another cluster of machines to actually get
the result. The machine which responds to a given query is chosen at random,
so you can not guarantee that the same machine will always respond to the
same request. The method processSearch is very expensive. Design a caching
mechanism for the most recent queries. Be sure to explain how you would
update the cache when data changes.

Create a cache server shared between clusters. Preferably use an existing one
(ie. a NoSQL datastore). The server could split cached data across multiple
machines if the cache is sufficiently large.

Any value that is cached could also be set to expire after a certain duration.
Additionally, you would need to keep track of the contents at a URL returned
by a search in case it changes. A separate process could run that compared
the identifiers stored vs the identifiers recently retrieved for a given URL.
If they differ then any cached query containing that URL as one of its results
becomes must be reevaluated.

----------
