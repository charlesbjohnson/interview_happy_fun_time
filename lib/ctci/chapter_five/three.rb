# Oh my god... These questions...
module CTCI::ChapterFive
  module Three
    # Given a positive integer, print the next smallest and the next
    # largest number that have the same number of 1 bits in their
    # binary representation.
    def equal_bits_around(n)
      { prev: equal_bits_prev(n), next: equal_bits_next(n) }
    end

    private

    def equal_bits_prev(n)
      index = last_non_trailing(1, n)

      return unless index

      n = clear_bit(index, n)

      prev = index.pred
      n = set_bit(prev, n)

      bits_to_move = count_set_bits_after(prev, n)
      n = clear_bits_after(prev, n)
      set_bits_from_most_significant(bits_to_move, prev, n)
    end

    def equal_bits_next(n)
      return nil if n == 0

      index = last_non_trailing(0, n)
      after_index = nil

      if index
        n = set_bit(index, n)
        after_index = index.pred
      else
        index = count_bits(n)
        after_index = index
        n <<= 1
      end

      bits_to_move = count_set_bits_after(after_index, n)
      n = clear_bits_after(index, n)
      set_bits_from_least_significant(bits_to_move, n)
    end

    # 0111 1100 with bit of 1 would return index of 2
    # 0111 0011 with bit of 0 would return index of 2
    def last_non_trailing(bit, n)
      bits = count_trailing_bits(bit, n)
      return nil unless bits

      complement_bits = count_trailing_bits(complement(bit), n, bits)
      return nil unless complement_bits

      bits + complement_bits
    end

    def count_trailing_bits(bit, n, after = 0)
      n >>= after

      count = 0
      while (n & 1) == bit
        return nil if n == bit

        n >>= 1
        count += 1
      end

      count
    end

    # 1 -> 0
    # 0 -> 1
    def complement(bit)
      bit.succ % 2
    end

    def set_bit(i, n)
      n | 1 << i
    end

    def count_set_bits_after(i, n)
      mask = (1 << i).pred
      n &= mask
      count_set_bits(n)
    end

    def count_set_bits(n)
      count = 0
      until n.zero?
        n &= n.pred
        count += 1
      end

      count
    end

    def count_bits(n)
      count = 0
      until n.zero?
        n >>= 1
        count += 1
      end

      count
    end

    def clear_bit(i, n)
      n & ~(1 << i)
    end

    def clear_bits_after(i, n)
      n & ~((1 << i).pred)
    end

    def set_bits_from_least_significant(bits, n)
      n | (1 << bits).pred
    end

    def set_bits_from_most_significant(bits, of, n)
      n | (((1 << bits.succ) - 2) << (of - bits).pred)
    end
  end
end
