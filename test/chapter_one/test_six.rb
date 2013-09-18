require 'test_helper'

module ChapterOne
  class SixTest < MiniTest::Unit::TestCase

    def test_rotates_square_matrix
      m = [[1, 2, 3],
           [4, 5, 6],
           [7, 8, 9]]
      actual = Six.rotate(m)
      expected = [[7, 4, 1],
                  [8, 5, 2],
                  [9, 6, 3]]

      assert_equal(expected, actual)
    end

    def test_rotates_rectangular_matrix
      m = [[1, 2],
           [3, 4],
           [5, 6]]
      actual = Six.rotate(m)
      expected = [[5, 3, 1],
                  [6, 4, 2]]

      assert_equal(expected, actual)
    end

    def test_returns_empty_array_on_invalid_matrix
      m = [[1],
           [2, 3],
           [4, 5, 6]]
      actual = Six.rotate(m)

      assert_equal([], actual)
    end

  end
end
