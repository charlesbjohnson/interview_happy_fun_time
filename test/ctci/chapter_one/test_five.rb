require 'config_test'

module CTCI::ChapterOne
  class TestFive < Minitest::Test
    include Five

    def test_compresses_a_string
      s = 'aabcccccaaa'
      actual = compress(s)

      assert_equal('a2b1c5a3', actual)
    end

    def test_doesnt_compress_short_strings
      s = 'aabc'
      actual = compress(s)

      assert_equal('aabc', actual)
    end

    def test_empty_string_returns_empty_string
      s = ''
      actual = compress(s)

      assert_equal('', actual)
    end
  end
end
