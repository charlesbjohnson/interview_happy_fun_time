module CTCI::ChapterFive
  module Five
    # Write a function to determine the number of bits required
    # to convert integer A to integer B
    # EXAMPLE
    # Input: 31, 14
    # Output: 2
    def bit_difference(a, b)
      count_set_bits(a ^ b)
    end

    private

    def count_set_bits(n)
      count = 0
      until n.zero?
        n &= n.pred
        count += 1
      end

      count
    end
  end
end
