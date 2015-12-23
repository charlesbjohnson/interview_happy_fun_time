require 'config_test'

module ChapterEleven
  class TestSeven < Minitest::Test
    include Seven

    def test_returns_height_of_tallest_human_tower
      p = [[65, 114],
           [58, 100],
           [70, 168]].map { |h, w| Stats.new(h, w) }
      assert_equal 3, tallest_human_tower(p)

      p = [[66, 103],
           [59, 101],
           [62, 111]].map { |h, w| Stats.new(h, w) }
      assert_equal 2, tallest_human_tower(p)

      p = [[70, 191],
           [66, 103],
           [66, 102],
           [68, 165],
           [66, 170]].map { |h, w| Stats.new(h, w) }
      assert_equal 3, tallest_human_tower(p)

      p = [[59, 101],
           [62, 111],
           [66, 103],
           [63, 109],
           [66, 102],
           [66, 170],
           [68, 165],
           [70, 191],
           [68, 166],
           [68, 175]].map { |h, w| Stats.new(h, w) }
      assert_equal 5, tallest_human_tower(p)
    end

    def test_returns_zero_if_empty
      p = []
      assert_equal 0, tallest_human_tower(p)

      p = [[], Stats.new(70, 180)]
      assert_equal 0, tallest_human_tower(p)
    end
  end
end
