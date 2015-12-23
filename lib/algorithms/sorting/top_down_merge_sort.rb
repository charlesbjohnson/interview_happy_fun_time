module Algorithms
  module Sorting
    module TopDownMergeSort
      def sort(a)
        sort!(a.clone)
      end

      def sort!(a)
        # could be more efficient, but chose to take Enumerable'ish approach
        r_merge_sort(a).each_with_index { |e, i| a[i] = e } unless a.size <= 1
        a
      end

      private

      def r_merge_sort(a)
        return a if a.size == 1

        low = 0
        high = a.size
        mid = (low + high) / 2

        left = a.take(mid)
        right = a.drop(mid)

        left_sorted = r_merge_sort(left)
        right_sorted = r_merge_sort(right)

        merge(left_sorted, right_sorted)
      end

      def merge(a, b)
        result = []

        a_i = b_i = 0
        until a_i >= a.size || b_i >= b.size
          if a[a_i] <= b[b_i]
            result.push(a[a_i])
            a_i += 1
          else
            result.push(b[b_i])
            b_i += 1
          end
        end

        if a_i >= a.size
          result.concat(b[b_i..-1])
        elsif b_i >= b.size
          result.concat(a[a_i..-1])
        end

        result
      end
    end
  end
end
