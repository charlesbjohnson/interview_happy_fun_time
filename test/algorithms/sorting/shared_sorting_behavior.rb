module Algorithms
  module Sorting
    module SharedSortingBehavior
      module Immutable
        def test_returns_new_sorted_array_when_odd_length
          a = [50, 18, 46, -10, 2, -9, 30, 25, 48]
          e = [-10, -9, 2, 18, 25, 30, 46, 48, 50]
          result = sort(a)
          assert_equal(e, result)
          refute_same(e, result)
        end

        def test_returns_new_sorted_array_when_even_length
          a = [31, 22, 6, -10, 25, 1, 7, -16, 36, -19]
          e = [-19, -16, -10, 1, 6, 7, 22, 25, 31, 36]
          result = sort(a)
          assert_equal(e, result)
          refute_same(e, result)
        end

        def test_returns_new_sorted_array_when_duplicates
          a = [83, 41, -25, 52, 46, -87, 41, 36, -12, -79, -25, 98, 41]
          e = [-87, -79, -25, -25, -12, 36, 41, 41, 41, 46, 52, 83, 98]
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
          a = [1]
          e = [1]
          result = sort(a)
          assert_equal(e, result)
          refute_same(a, result)
        end
      end

      module Mutable
        def test_returns_sorted_array_when_odd_length
          a = [50, 18, 46, -10, 2, -9, 30, 25, 48]
          e = [-10, -9, 2, 18, 25, 30, 46, 48, 50]
          result = sort!(a)
          assert_equal(e, result)
          assert_same(a, result)
        end

        def test_returns_sorted_array_when_even_length
          a = [31, 22, 6, -10, 25, 1, 7, -16, 36, -19]
          e = [-19, -16, -10, 1, 6, 7, 22, 25, 31, 36]
          result = sort!(a)
          assert_equal(e, result)
          assert_same(a, result)
        end

        def test_returns_new_sorted_array_when_duplicates
          a = [33, 2, 93, 57, -29, -42, 80, 2, 13, 66, -3, -11, -11]
          e = [-42, -29, -11, -11, -3, 2, 2, 13, 33, 57, 66, 80, 93]
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
          a = [1]
          e = [1]
          result = sort!(a)
          assert_equal(e, result)
          assert_same(a, result)
        end
      end
    end
  end
end
