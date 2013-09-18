require 'test_helper'

module ChapterOne
  class TestEight < MiniTest::Unit::TestCase

    def test_returns_true_if_is_rotation
      s, t = "waterbottle", "erbottlewat"
      actual = Eight.rotation?(s, t)

      assert_equal(true, actual)
    end

    def test_returns_false_if_is_not_rotation
      s, t = "shazbot", "shbotaz"
      actual = Eight.rotation?(s, t)

      assert_equal(false, actual)
    end

    def test_returns_false_when_given_empty_string
      first_s, first_t = "", "erbottlewat"
      second_s, second_t = "waterbottle", ""
      third_s, third_t = "", ""

      first_actual = Eight.rotation?(first_s, first_t)
      second_actual = Eight.rotation?(second_s, second_t)
      third_actual = Eight.rotation?(third_s, third_t)

      assert_equal(false, first_actual)
      assert_equal(false, second_actual)
      assert_equal(false, third_actual)
    end

  end
end
