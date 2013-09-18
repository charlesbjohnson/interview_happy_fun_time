require 'test_helper'

module ChapterOne
  class TestFive < MiniTest::Unit::TestCase

    def test_compresses_a_string
      s = "aabcccccaaa"
      actual = Five.compress(s)

      assert_equal("a2b1c5a3", actual)
    end

    def test_doesnt_compress_short_strings
      s = "aabc"
      actual = Five.compress(s)

      assert_equal("aabc", actual)
    end

    def test_empty_string_returns_empty_string
      s = ""
      actual = Five.compress(s)

      assert_equal("", actual)
    end
  end
end
