require 'config_test'

module ChapterFive
  class TestSeven < Minitest::Test
    include Seven

    def test_returns_missing_number_from_array_even_amount
      [1,3,7].each do |expected|
        array = (0..9).to_a
        array.delete(expected)
        assert_equal expected, find_missing(array)
      end
    end

    def test_returns_missing_number_from_array_odd_amount
      [1,3,7].each do |expected|
        array = (0..10).to_a
        array.delete(expected)
        assert_equal expected, find_missing(array)
      end
    end

    def test_returns_next_for_missing_at_end
      assert_equal 10, find_missing((0..9).to_a)
    end

    def test_returns_prev_for_missing_at_start
      assert_equal 0, find_missing((1..9).to_a)
    end

    def test_returns_zero_for_empty
      assert_equal 0, find_missing([])
    end

  end
end
