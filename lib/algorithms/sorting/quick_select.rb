module Algorithms
  module Sorting
    module QuickSelect
      def select(i, a)
        return if a.empty? || !(0...a.size).include?(i)
        result = r_select(i, a, 0, a.size.pred)
        result && a[result]
      end

      private

      def r_select(i, a, low, high)
        pivot_i = partition!(a, low, high)

        if pivot_i > i
          r_select(i, a, low, pivot_i.pred)
        elsif pivot_i < i
          r_select(i, a, pivot_i.succ, high)
        else
          pivot_i
        end
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
