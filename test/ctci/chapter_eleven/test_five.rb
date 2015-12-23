require 'config_test'

module ChapterEleven
  class TestFive < Minitest::Test
    include Five

    def test_returns_index_of_string_among_empty_strings
      a = ['at', '', '', '', 'ball', '', '', 'car', '', '', 'dad', '', '']
      assert_equal 4, index_of('ball', a)

      a = ['at', '', '', '', 'ball', '', '', 'car', '', '', 'dad', '', '']
      assert_equal 0, index_of('at', a)

      a = ['at', '', '', '', 'ball', '', '', 'car', '', '', 'dad', '', '']
      assert_equal 10, index_of('dad', a)
    end

    def test_returns_nil_if_whole_array_empty
      a = ['', '', '', '', '', '', '', '', '', '', '', '', '']
      assert_nil index_of('array', a)
    end

    def test_returns_nil_if_string_doesnt_exist
      a = ['at', '', '', '', 'ball', '', '', 'car', '', '', 'dad', '', '']
      assert_nil index_of('array', a)
    end

    def test_returns_nil_if_empty
      assert_nil index_of('array', [])
    end
  end
end
