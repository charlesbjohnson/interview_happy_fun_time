module Algorithms
  module Sorting
    module BottomUpMergeSort
      def sort(a)
        sort!(a.clone)
      end

      def sort!(a)
        return a if a.size <= 1

        comparison_size = 1
        until comparison_size >= a.size
          low_start = 0
          high_start = low_start + comparison_size

          until high_start >= a.size
            low_end = low_start + comparison_size.pred
            high_end = min((high_start + comparison_size.pred), a.size.pred)

            merge(a, low_start, low_end, high_start, high_end)

            low_start = high_end.succ
            high_start = low_start + comparison_size
          end

          comparison_size *= 2
        end

        a
      end

      private

      def min(a, b)
        a <= b ? a : b
      end

      def merge(a, low_start, low_end, high_start, high_end)
        tmp = a.clone
        low_i = low_start
        high_i = high_start

        past_low_end = -> { low_i > low_end }
        past_high_end = -> { high_i > high_end }
        higher_is_smaller = -> { tmp[high_i] < tmp[low_i] }

        (low_start..high_end).each do |i|
          break if past_low_end.call && past_high_end.call

          if past_low_end.call || (!past_high_end.call && higher_is_smaller.call)
            a[i] = tmp[high_i]
            high_i += 1
          else
            a[i] = tmp[low_i]
            low_i += 1
          end
        end
      end
    end
  end
end
