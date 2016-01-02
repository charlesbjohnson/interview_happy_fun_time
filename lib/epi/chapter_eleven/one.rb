module EPI::ChapterTen
  module One
    # Design an algorithm that takes a set of files containing stock trades
    # sorted by increasing trade times, and writes a single file containing
    # the trades appearing in the individual files sorted in the same order.
    # The algorithm should use very little RAM, ideally of the order of a few
    # kilobytes.
    #
    # This can be accomplished with an n-way merge or with a heap.
    # In either case, we would keep the memory usage low by not reading
    # the entire files into memory.
    #
    # In the case of the n-way merge, we would use a buffered read from
    # each file (the size of the buffer would depend on the amount of files
    # we would need to have open), pick the minimum at each merge, and perform
    # a buffered write for every minimum found. The main inefficiency would
    # come from potentially having too many files to compare from. For example,
    # if there are 500 files, then we are performing a 500-way merge. Once we
    # find the minimum for that merge we would then backfill from the file from
    # which that minimum came to prepare for the next merge. However, the next
    # merge would then be comparing the same 499 entries from the previous merge.
    #
    # In the case of a heap, we would still use buffered reads and buffered writes
    # instead of reading entire files at a time, but we could also avoid
    # the redundant comparisons inherent to the n-way merge. We would read an entry
    # from each file into the heap, pop the minimum into a file, then backfill into
    # the heap another entry from the file in which a minimum just came. The
    # advantage here is that once we go to find the minimum again, we aren't
    # redundantly comparing every element to each other element because the constructed
    # heap has already ordered the previous elements in a nearly-sorted manner.
  end
end
