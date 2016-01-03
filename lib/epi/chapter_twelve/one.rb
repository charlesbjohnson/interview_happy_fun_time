module EPI::ChapterTwelve
  module One
    # Write a method that takes a sorted array A and a key k and returns the
    # index of the first occurrence of k in A. Return -1 if k does not appear
    # in A.
    #
    # Binary search is the core to solving this problem and the algorithm
    # for it is fairly standard. The additional work in finding the first
    # occurrence equates to having to perform subsequent binary searches,
    # even after an element was found. By keeping track of the farthest left
    # another occurrence could be (we can know this depending on how the binary
    # search branches), we can slightly optimize subsequent searches by reducing
    # their scope.
    def find_first(k, a)
      found_at_i, leftmost_possible_i = r_find(k, a, 0, a.size.pred)

      loop do
        break if found_at_i.nil? || leftmost_possible_i >= found_at_i.pred

        leftmost_found_at_i, leftmost_possible_i = r_find(k, a, leftmost_possible_i, found_at_i.pred)
        break if leftmost_found_at_i.nil?

        found_at_i = leftmost_found_at_i
      end

      found_at_i
    end

    private

    def r_find(k, a, low_i, high_i)
      return [nil, nil] if low_i > high_i || (low_i == high_i && a[low_i] != k)

      center_i = (high_i - low_i / 2).floor + low_i
      center = a[center_i]

      return [center_i, low_i] if center == k

      new_low_i = low_i
      new_high_i = center_i.pred

      if k > center
        new_low_i = center_i.succ
        new_high_i = high_i
      end

      r_find(k, a, new_low_i, new_high_i)
    end
  end
end
