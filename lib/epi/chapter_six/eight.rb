module EPI::ChapterSix
  module Eight
    # Design an algorithm that takes a sequence of n three-dimensional coordinates to be traversed,
    # and returns the minimum battery capacity needed to complete the journey. The robot begins
    # with the battery fully charged.
    #
    # The robot expends energy going up and gains energy when going down but
    # the energy gained going down doesn't gain anything since it will be negated
    # by the additional energy required to go up. We can basically ignore it.
    # For simplicity, I'm also going to assume that the method be called only with heights.
    def capacity(heights)
      minimum_height = Float::INFINITY

      heights.reduce(0) do |capacity, height|
        capacity = [capacity, height - minimum_height].max
        minimum_height = [minimum_height, height].min

        capacity
      end
    end
  end
end
