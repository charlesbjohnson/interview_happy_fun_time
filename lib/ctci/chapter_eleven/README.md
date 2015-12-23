# Sorting and Searching

There is no code for the following problems:

4. [sorting strings in a large file](#4---sorting-strings-in-a-large-file)

Instead, the description of how to solve the problem is below.

----------

## 4. Sorting Strings In a Large File
> Imagine you have a 20 GB file with one string per line. Explain how you
would sort the file.

Since the file is so massive, it cannot be loaded into memory all at once.
The file must be divided into chunks that can be sorted individually. Once
each chunk is sorted individually we can perform a merge between all the
different chunks. Starting from the beginning of each chunk, read a line
from each chunk, find the minimum of the lines read, append the line
to the output file, and increment to the next line for the chunk from which
that line came from. Repeat until the merge is complete.

----------
