require 'config_test'

module CTCI::ChapterEleven
  class TestOne < Minitest::Test
    include One

    def test_returns_arrays_merged_into_single_array_in_sorted_order
      a = [1, 5, 6, 10, nil, nil, nil]
      b = [-1, 3, 23]
      assert_equal [-1, 1, 3, 5, 6, 10, 23], merge_sorted_order(a, b)

      a = [1, 3, 15, nil, nil, nil]
      b = [2, 6, 9]
      assert_equal [1, 2, 3, 6, 9, 15], merge_sorted_order(a, b)
    end

    def test_returns_b_if_a_empty
      a = []
      b = [1, 2, 3]
      assert_equal b, merge_sorted_order(a, b)
    end

    def test_returns_a_if_b_empty
      a = [1, 2, 3]
      b = []
      assert_equal a, merge_sorted_order(a, b)
    end

    def test_returns_empty_on_both_empty
      assert_empty merge_sorted_order([], [])
    end
  end
end
