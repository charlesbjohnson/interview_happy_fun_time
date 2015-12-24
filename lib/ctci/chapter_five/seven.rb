# These are so unbelievably hard, I wouldn't be able to come up with this
# on the spot.
module CTCI::ChapterFive
  module Seven
    # An array A contains all the integers from 0 to n, except for one
    # number which is missing. In this problem, we cannot access an
    # entire integer in A with a single operation. The elements of A
    # are represented in binary, and the only operation we can use to
    # access them if "fetch the jth bit of A[i]," which takes
    # constant time. Write code to find the missing integer. Can you do it
    # in O(N) time?
    def find_missing(numbers)
      result = []
      active = numbers
      column = 0
      until active.empty?
        count = count_bits_at_column(column, active)
        column += 1

        zeros_count = count[:zero][:count]
        ones_count = count[:one][:count]
        zeros_count -= 1 if active.size.even?

        if zeros_count > ones_count
          active = count[:one][:matching]
          result.push(1)
        else
          active = count[:zero][:matching]
          result.push(0)
        end
      end

      stack_to_binary(result)
    end

    private

    def count_bits_at_column(c, numbers)
      result = { zero: { count: 0, matching: [] },
                 one: { count: 0, matching: [] } }

      numbers.each do |n|
        which = bit(c, n).zero? ? :zero : :one
        result[which][:count] += 1
        result[which][:matching].push(n)
      end

      result
    end

    def bit(i, n)
      n & (1 << i) >= 1 ? 1 : 0
    end

    def stack_to_binary(s)
      result = 0
      until s.empty?
        result <<= 1
        result |= s.pop
      end

      result
    end
  end
end
