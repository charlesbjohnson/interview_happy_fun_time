require 'config_test'

module Algorithms
  module Sorting
    class TestMergeSort < Minitest::Test
      include MergeSort

      def test_returns_new_sorted_array
        a = [50, 18, 46, -10, 2, -9, 30, 25, 48]
        e = [-10, -9, 2, 18, 25, 30, 46, 48, 50]
        assert_equal e, sort(a)
        refute_equal a, sort(a)

        a = [31, 22, 6, -10, 25, 1, 7, -16, 36, -19]
        e = [-19, -16, -10, 1, 6, 7, 22, 25, 31, 36]
        assert_equal e, sort(a)
        refute_equal a, sort(a)
      end

      def test_returns_empty_array_when_empty
        assert_empty sort([])
      end

      def test_returns_array_when_single_element
        assert_equal [1], sort([1])
      end

    end
  end
end
