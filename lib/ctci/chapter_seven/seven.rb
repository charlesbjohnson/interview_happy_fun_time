# I don't like this chapter.
# Tried to make the solution easily expandable to other primes.
module CTCI::ChapterSeven
  module Seven
    LARGE_NUMBER = 2**(0.size * 8)

    # Design an algorithm to find the kth number such that the
    # only prime factors are 3,5, and 7.
    def kth_number_with_prime_factors(k)
      queues = [[3, [1]], [5, []], [7, []]]

      result = nil
      0.upto(k) do
        possible_minimums = queues.map.with_index do |(_, q), qi|
          [(q.first || LARGE_NUMBER), qi]
        end

        minimum = possible_minimums.min
        minimum_value = minimum[0]
        minimum_index = minimum[1]

        queues[minimum_index..-1].each { |qv, q| q.push(minimum_value * qv) }

        result = queues[minimum_index][1].shift
      end

      result
    end
  end
end
