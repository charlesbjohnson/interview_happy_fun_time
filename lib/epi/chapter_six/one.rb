module EPI::ChapterSix
  module One
    # Write a function that takes an array A of length n and an index i into A,
    # and rearranges the elements such that all elements less than A[i] appear first,
    # followed by elements equal to a A[i], followed by elements greater than A[i].
    # Your algorithm should have O(1) space complexity and O(n) time complexity.
    #
    # This can be achieved with just the partition step from a 3-way quicksort.
    def partition!(a, i)
      return a if a.empty?
      i = 0 unless (0...a.length).include?(i)

      pivot_e = a[i]

      left_i = 0
      right_i = a.length.pred
      cursor_i = left_i

      belongs_left_of_pivot = -> { a[cursor_i] < pivot_e }
      belongs_right_of_pivot = -> { a[cursor_i] > pivot_e }

      until cursor_i > right_i
        case
        when belongs_left_of_pivot.call
          a[cursor_i], a[left_i] = a[left_i], a[cursor_i]
          left_i += 1
          cursor_i += 1
        when belongs_right_of_pivot.call
          a[cursor_i], a[right_i] = a[right_i], a[cursor_i]
          right_i -= 1
        else
          cursor_i += 1
        end
      end

      a
    end
  end
end
