require 'config_test'

module ChapterEleven
  class TestSix < Minitest::Test
    include Six

    def test_returns_column_and_row_indices_of_element_in_matrix
      m = [[1,   2,  3],
           [7,  11, 34],
           [15, 16, 40]]
      assert_equal [1, 0], locate_in_matrix(7, m)

      m = [[1, 2, 3],
           [2, 3, 4],
           [3, 4, 5]]
      assert_equal [1, 2], locate_in_matrix(4, m)

      m = [[-8,  4,  5,  9, 11],
           [-7,  6,  6, 11, 12],
           [-5,  6, 12, 14, 17],
           [-1,  7, 13, 18, 26],
           [-1,  9, 15, 22, 58]]
      assert_equal [3, 2], locate_in_matrix(13, m)
      assert_equal [3, 4], locate_in_matrix(26, m)

      m = [[15, 20,  40,  85],
           [20, 35,  80,  95],
           [30, 55,  95, 105],
           [40, 80, 100, 120]]
      assert_equal [2, 1], locate_in_matrix(55, m)
    end

    def test_returns_nil_if_matrix_doesnt_contain_element
      m = [[1,   2,  3],
           [7,  11, 34],
           [15, 16, 40]]
      assert_nil locate_in_matrix(5, m)
    end

    def test_returns_nil_on_empty
      assert_nil locate_in_matrix(1, [])
      assert_nil locate_in_matrix(2, [[]])
    end

  end
end
