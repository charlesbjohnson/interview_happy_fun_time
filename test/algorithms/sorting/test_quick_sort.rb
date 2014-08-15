require 'config_test'

module Algorithms
  module Sorting
    class TestQuickSort < Minitest::Test
      include QuickSort

        def test_returns_new_sorted_array_odd_size
          a = [50, 18, 46, -10, 2, -9, 30, 25, 48]

          actual = sort(a)

          expected = a.sort
          assert_equal expected, actual
          refute_equal actual, a
        end

        def test_returns_new_sorted_array_even_size
          a = [31, 22, 6, -10, 25, 1, 7, -16, 36, -19]

          actual = sort(a)

          expected = a.sort
          assert_equal expected, actual
          refute_equal actual, a
        end

        def test_returns_new_sorted_array_duplicates
          a = [6, 4, 8, 2, 2, 8, 7, 0, 2]

          actual = sort(a)

          expected = a.sort
          assert_equal expected, actual
          refute_equal actual, a
        end

        def test_returns_array_sorted_odd_size
          a = [50, 18, 46, -10, 2, -9, 30, 25, 48]

          actual = sort!(a)

          expected = a.sort
          assert_equal expected, actual
          assert_equal expected, a
          assert_same actual, a
        end

        def test_returns_array_sorted_even_size
          a = [31, 22, 6, -10, 25, 1, 7, -16, 36, -19]

          actual = sort!(a)

          expected = a.sort
          assert_equal expected, actual
          assert_equal expected, a
          assert_same actual, a
        end

        def test_returns_array_sorted_duplicates
          a = [2, 1, 5, 7, 7, 2, 0, 8, 0]

          actual = sort!(a)

          expected = a.sort
          assert_equal expected, actual
          assert_equal expected, a
          assert_same actual, a

        end

        def test_returns_new_empty_array_when_empty
          a = []
          actual = sort(a)
          assert_empty actual
          refute_same a, actual
        end

        def test_returns_array_when_empty
          a = []
          actual = sort!(a)
          assert_empty actual
          assert_same a, actual
        end

        def test_returns_new_array_when_single_element
          a = [1]
          actual = sort(a)
          assert_equal a, actual
          refute_same a, actual
        end

        def test_returns_array_when_single_element
          a = [1]
          actual = sort!(a)
          assert_equal a, actual
          assert_same a, actual
        end

    end
  end
end
