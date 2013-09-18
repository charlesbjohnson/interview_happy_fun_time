require 'test_helper'

module ChapterOne
  class TestOne < MiniTest::Unit::TestCase

    def test_returns_true_when_all_characters_unique
      s = "abcde"
      result = One.unique_chars?(s)

      assert_equal(true, result)
    end

    def test_returns_false_when_not_all_characters_unique
      s = "abcade"
      result = One.unique_chars?(s)

      assert_equal(false, result)
    end

    def test_returns_true_when_empty_string
      s = ""
      result = One.unique_chars?(s)

      assert_equal(true, result)
    end

  end
end
