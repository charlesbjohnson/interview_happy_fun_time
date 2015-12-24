module CTCI::ChapterNine
  module One
    @cache = [1]

    # A child is running up a staircase with n steps, and can hop either 1
    # step, 2 steps, or 3 steps at a time. Implement a method to count
    # how many possible ways the child can run up the stairs.
    def self.count_ways_to_skip_steps(steps)
      return 0 if steps < 0

      r = @cache[steps]
      return r if r

      one = count_ways_to_skip_steps(steps - 1)
      two = count_ways_to_skip_steps(steps - 2)
      three = count_ways_to_skip_steps(steps - 3)
      @cache[steps] = one + two + three
    end
  end
end
