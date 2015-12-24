module CTCI::ChapterEleven
  module Three
    # Given a sorted array of n integers that has been rotated an unknown
    # number of times, write code to find an element in the array. You may
    # assume that the array was originally sorted in increasing order.
    def search_rotated_array(e, a)
      return if a.empty?

      result = nil

      min_i = a.index(a.min)
      size = a.size
      low_i = 0
      high_i = size.pred
      until low_i > high_i
        mid_i = (low_i + high_i) / 2
        actual_mid_i = (min_i + mid_i) % size
        actual_mid = a[actual_mid_i]

        if e < actual_mid
          high_i = mid_i.pred
        elsif e > actual_mid
          low_i = mid_i.succ
        else
          result = actual_mid_i
          break
        end

      end

      result
    end
  end
end
