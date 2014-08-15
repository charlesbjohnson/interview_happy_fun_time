module Algorithms
  module Sorting
    module QuickSort

      def sort(a)
        clone = Marshal.load(Marshal.dump(a))
        r_quicksort!(clone, 0, clone.size.pred)
      end

      def sort!(a)
        r_quicksort!(a, 0, a.size.pred)
      end

      private

      def r_quicksort!(a, low, high)
        return a if low >= high

        pivot_i = partition!(a, low, high)

        r_quicksort!(a, low, pivot_i.pred)
        r_quicksort!(a, pivot_i.succ, high)
      end

      def partition!(a, low, high)
        partition_i, left_i, right_i = low, low.succ, high

        loop do
          left_i += 1 until left_i > high || a[partition_i] < a[left_i]
          right_i -= 1 until right_i <= low || a[partition_i] > a[right_i]
          break if left_i >= right_i

          a[left_i], a[right_i] = a[right_i], a[left_i]
        end

        a[partition_i], a[right_i] = a[right_i], a[partition_i]

        right_i
      end

    end
  end
end
