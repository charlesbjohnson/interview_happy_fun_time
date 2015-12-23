module Algorithms
  module Sorting
    module ThreeWayQuickSort
      def sort(a)
        sort!(a.clone)
      end

      def sort!(a)
        r_sort!(a, 0, a.size.pred)
      end

      private

      def r_sort!(a, low, high)
        return a if low >= high

        left_pivot_i, right_pivot_i = partition!(a, low, high)

        r_sort!(a, low, left_pivot_i.pred)
        r_sort!(a, right_pivot_i.succ, high)
      end

      def partition!(a, low, high)
        pivot_e = a[low]
        left_i = i = low
        right_i = high

        should_be_left_of_pivot_e = -> { a[i] < pivot_e }
        should_be_right_of_pivot_e = -> { a[i] > pivot_e }

        until i > right_i
          if should_be_left_of_pivot_e.call
            a[left_i], a[i] = a[i], a[left_i]
            i += 1
            left_i += 1
          elsif should_be_right_of_pivot_e.call
            a[right_i], a[i] = a[i], a[right_i]
            right_i -= 1
          else
            i += 1
          end
        end

        [left_i, right_i]
      end
    end
  end
end
