require 'config_test'

module Algorithms
  module Sorting
    class TestQuickSelect < Minitest::Test
      include QuickSelect

      def test_returns_ith_element_when_odd_length
        assert_equal(-3, select(2, [56, 59, 94, 45, -11, -71, 15, 0, -3]))
      end

      def test_returns_ith_element_when_even_length
        assert_equal(93, select(8, [-45, -81, 55, 23, 96, 93, -57, 21, 41, -72]))
      end

      def test_returns_ith_largest_element_when_duplicates
        assert_equal(16, select(6, [-75, -41, -4, -4, 0, 3, 16, 16, 33, 60, 60, 88]))
      end

      def test_returns_nil_when_invalid
        assert_nil(select(4, [9, -6, 2]))
        assert_nil(select(-3, [9, 15, -3, 4]))
      end

      def test_returns_nil_when_empty_array
        assert_nil(select(3, []))
      end

    end
  end
end
