module CTCI::ChapterEleven
  module Five
    # Given a sorted array of strings which is interspersed with empty
    # strings, write a method to find the location of a given string.
    #
    # EXAMPLE
    # Input: find 'ball' in ['at', '', '', '', 'ball', '', '', 'car', '', '',
    #                        'dad', '', '']
    # Output: 4
    def index_of(s, a)
      result = nil

      low_i = 0
      high_i = a.size.pred
      until low_i > high_i
        mid_i = (low_i + high_i) / 2
        mid_v = a[mid_i]

        if mid_v.empty?
          closest = closest_non_empty_from(mid_i, a)
          return nil if closest.nil?

          mid_i = closest
          mid_v = a[mid_i]
        end

        if s < mid_v
          high_i = mid_i.pred
        elsif s > mid_v
          low_i = mid_i.succ
        else
          result = mid_i
          break
        end
      end

      result
    end

    private

    def closest_non_empty_from(i, a)
      left = i.pred
      right = i.succ
      go_left = go_right = true
      while go_left || go_right
        go_left = false if left < 0
        go_right = false if right >= a.size

        return left if go_left && !a[left].empty?
        return right if go_right && !a[right].empty?

        left = left.pred if go_left
        right = right.succ if go_right
      end
    end
  end
end
