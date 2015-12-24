module CTCI::ChapterNine
  module Three
    # A magic index in an array A[0...n-1] is defined to be an index such
    # that A[i] = i. Given a sorted array of distinct integers, write a method
    # to find a magic index, if one exists, in array A.
    #
    # FOLLOW UP
    # What if the values are not distinct?
    def magic_index(a)
      r_magic_index(a, 0, a.size.pred)
    end

    private

    def r_magic_index(a, low, high)
      return if low > high

      mid = (low + high) / 2
      at_mid = a[mid]
      return mid if at_mid == mid

      max_left = [at_mid, mid.pred].min
      min_right = [at_mid, mid.succ].max
      r_magic_index(a, low, max_left) || r_magic_index(a, min_right, high)
    end
  end
end
