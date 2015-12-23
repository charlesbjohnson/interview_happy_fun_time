require 'config_test'

module ChapterEleven
  class TestThree < Minitest::Test
    include Three

    def test_returns_element_if_in_array
      assert_equal 1, search_rotated_array(3, [2, 3, 1])
      assert_equal 3, search_rotated_array(2, [4, 5, 1, 2, 3])
      assert_equal 4, search_rotated_array(2, [4, 4, 1, 2, 2, 2])
      assert_equal 2, search_rotated_array(-1, [15, -9, -1, 3, 7])
      assert_equal 2, search_rotated_array(-1, [-9, -9, -1, 3, 7, -9])
    end

    def test_returns_nil_if_not_in_array
      assert_nil search_rotated_array(3, [])
    end
  end
end
