module Algorithms
  module Sorting
    module QuickSort
      def sort(a)
        sort!(a.clone)
      end

      def sort!(a)
        r_sort!(a, 0, a.size.pred)
      end

      private

      def r_sort!(a, low, high)
        return a if low >= high

        pivot_i = partition!(a, low, high)

        r_sort!(a, low, pivot_i.pred)
        r_sort!(a, pivot_i.succ, high)
      end

      def partition!(a, low, high)
        pivot_i = low
        left_i = low.succ
        right_i = high
        should_be_right_of_pivot_i = -> { a[left_i] > a[pivot_i] }
        should_be_left_of_pivot_i = -> { a[right_i] < a[pivot_i] }

        loop do
          left_i += 1 until left_i > high || should_be_right_of_pivot_i.call
          right_i -= 1 until right_i <= low || should_be_left_of_pivot_i.call

          break if left_i >= right_i

          a[left_i], a[right_i] = a[right_i], a[left_i]
        end

        a[pivot_i], a[right_i] = a[right_i], a[pivot_i]

        right_i
      end
    end
  end
end
