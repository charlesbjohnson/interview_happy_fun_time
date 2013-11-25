# I don't really get how this is a sorting/searching problem.
# Only way I could think of it was as a dynamic programming problem,
# very similar to the stacking boxes problem from chapter 10.
# The book solution also seems incorrect.
#
# I read up about longest increasing subsequences, but I really
# don't understand how you implement it with pairs of data like these.
# Since it is possible for a person to be neither larger nor smaller than
# another (ie. [65, 66] vs [66, 65], who is smaller?) it makes the
# standard LIS algorithms incapable.
#
# Maybe I'm just dumb though.
module ChapterEleven
  module Seven

    # A circus is designing a tower routine consisting of people standing
    # atop one another's shoulders. For practical and aesthetic reasons,
    # each person must be both shorter and lighter than the person below him
    # or her. Given the heights and weights of each person in the circus,
    # write a method to compute the largest possible number of people in
    # such a tower.
    def tallest_human_tower(people)
      return 0 if people.empty?
      all_stats = proc { |p| p.respond_to?(:height) && p.respond_to?(:weight) }
      return 0 unless people.all?(&all_stats)

      r_tallest_human_tower(people.sort.reverse, nil, 0, {})
    end

    class Stats
      include Comparable

      attr_reader :height, :weight

      def initialize(h, w)
        @height, @weight = h, w
      end

      def hash
        [@height, @weight].hash
      end

      def ==(other)
        return false unless self.class == other.class
        same_height = @height == other.height
        same_weight = @weight == other.weight
        same_height && same_weight
      end

      alias_method :eql?, :==

      def <=>(other)
        return unless self.class == other.class

        if @height < other.height
          return -1
        elsif @height > other.height
          return 1
        end

        if @weight < other.weight
          return -1
        elsif @weight > other.weight
          return 1
        end

        0
      end

    end

    private

    def r_tallest_human_tower(people, top, from, cache)
      return 0 if from >= people.size

      cursor = people[from]
      next_i = from.succ

      with = 0
      if smaller?(cursor, top)
        with = cache[cursor]
        with ||= r_tallest_human_tower(people, cursor, next_i, cache) + 1
        cache[cursor] = with
      end

      # If we've already got a sequence of some length, don't bother
      # trying to hunt one down that can only possibly be shorter than
      # one we've already got
      without = 0
      if with < (people.size - next_i)
        without = r_tallest_human_tower(people, top, next_i, cache)
      end
      [with, without].max
    end

    def smaller?(first, second)
      return true if second.nil?

      shorter = first.height < second.height
      slimmer = first.weight < second.weight
      shorter && slimmer
    end

  end
end
