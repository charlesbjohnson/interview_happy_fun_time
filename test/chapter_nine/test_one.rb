require 'config_test'

module ChapterNine
  class TestOne < Minitest::Test

    def test_returns_number_of_ways_to_skip_steps
      assert_equal 1, One.count_ways_to_skip_steps(1)
      assert_equal 2, One.count_ways_to_skip_steps(2)
      assert_equal 4, One.count_ways_to_skip_steps(3)
      assert_equal 7, One.count_ways_to_skip_steps(4)
      assert_equal 13, One.count_ways_to_skip_steps(5)
    end

    def test_returns_zero_if_none
      assert_equal 1, One.count_ways_to_skip_steps(0)
    end

  end
end
