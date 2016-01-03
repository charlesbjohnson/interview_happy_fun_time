require 'config_test'

module EPI::ChapterTwelve
  class TestOne < Minitest::Test
    include One

    def test_find_first_returns_index_of_sole_element_occurrence
      a = [12, 15, 20, 25, 26, 31, 42, 43, 45, 48]
      result = find_first(20, a)
      assert_equal(2, result)
    end

    def test_find_first_returns_index_of_first_element_occurrence_in_left
      a = [12, 20, 20, 20, 26, 31, 42, 43, 45, 48]
      result = find_first(20, a)
      assert_equal(1, result)
    end

    def test_find_first_returns_index_of_first_element_occurrence_in_right
      a = [0, 1, 2, 3, 4, 5, 6, 8, 8, 8, 9, 10]
      result = find_first(8, a)
      assert_equal(7, result)
    end

    def test_find_first_returns_when_element_does_not_occur
      a = [12, 15, 20, 25, 26, 31, 42, 43, 45, 48]
      result = find_first(39, a)
      assert_nil(result)
    end

    def test_find_first_returns_when_the_array_is_empty
      result = find_first(9, [])
      assert_nil(result)
    end
  end
end
