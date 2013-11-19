require 'config_test'

module ChapterNine
  class TestEight < Minitest::Test
    include Eight

    def test_returns_number_of_ways_to_represent_cent_value
      assert_equal 1, count_cent_representations(1)
      assert_equal 2, count_cent_representations(5)
      assert_equal 4, count_cent_representations(10)
      assert_equal 13, count_cent_representations(25)
    end

    def test_returns_zero_for_zero
      assert_equal 0, count_cent_representations(0)
    end

  end
end
