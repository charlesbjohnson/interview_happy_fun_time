require 'config_test'

module Algorithms
  module Sorting
    class TestBottomUpMergeSort < Minitest::Test
      include BottomUpMergeSort

      class TestImmutable < TestBottomUpMergeSort
        def test_returns_new_sorted_array_when_odd_length
          a = [-7, -13, 64, 45, 79, -98, 7, -65, -20]
          e = [-98, -65, -20, -13, -7, 7, 45, 64, 79]
          result = sort(a)
          assert_equal(e, result)
          refute_same(e, result)
        end

        def test_returns_new_sorted_array_when_even_length
          a = [-68, 35, -33, 60, -25, 53, 28, -11, 23, 3]
          e = [-68, -33, -25, -11, 3, 23, 28, 35, 53, 60]
          result = sort(a)
          assert_equal(e, result)
          refute_same(e, result)
        end

        def test_returns_new_sorted_array_when_duplicates
          a = [7, 31, 1, 22, 6, -10, 25, 1, 7, -16, 36, -19, 25]
          e = [-19, -16, -10, 1, 1, 6, 7, 7, 22, 25, 25, 31, 36]
          result = sort(a)
          assert_equal(e, result)
          refute_same(e, result)
        end

        def test_returns_new_empty_array_when_empty
          a = []
          result = sort(a)
          assert_empty(result)
          refute_same(a, result)
        end

        def test_returns_new_array_when_single_element
          a = [3]
          e = [3]
          result = sort(a)
          assert_equal(e, result)
          refute_same(a, result)
        end
      end

      class TestMutable < TestBottomUpMergeSort
        def test_returns_sorted_array_when_odd_length
          a = [-7, -13, 64, 45, 79, -98, 7, -65, -20]
          e = [-98, -65, -20, -13, -7, 7, 45, 64, 79]
          result = sort!(a)
          assert_equal(e, result)
          assert_same(a, result)
        end

        def test_returns_sorted_array_when_even_length
          a = [-68, 35, -33, 60, -25, 53, 28, -11, 23, 3]
          e = [-68, -33, -25, -11, 3, 23, 28, 35, 53, 60]
          result = sort!(a)
          assert_equal(e, result)
          assert_same(a, result)
        end

        def test_returns_new_sorted_array_when_duplicates
          a = [63, 63, 70, -100, -39, -98, -46, -88, -77, 75, 42, -69, -98]
          e = [-100, -98, -98, -88, -77, -69, -46, -39, 42, 63, 63, 70, 75]
          result = sort(a)
          assert_equal(e, result)
          refute_same(e, result)
        end

        def test_returns_empty_array_when_empty
          a = []
          result = sort!(a)
          assert_empty(result)
          assert_same(a, result)
        end

        def test_returns_array_when_single_element
          a = [3]
          e = [3]
          result = sort!(a)
          assert_equal(e, result)
          assert_same(a, result)
        end
      end

    end
  end
end
