require 'config_test'

module CTCI::ChapterOne
  class TestEight < Minitest::Test
    include Eight

    def test_returns_true_if_is_rotation
      s = 'waterbottle'
      t = 'erbottlewat'
      actual = rotation?(s, t)

      assert_equal(true, actual)
    end

    def test_returns_false_if_is_not_rotation
      s = 'shazbot'
      t = 'shbotaz'
      actual = rotation?(s, t)

      assert_equal(false, actual)
    end

    def test_returns_false_when_given_empty_string
      first_s = ''
      first_t = 'erbottlewat'
      second_s = 'waterbottle'
      second_t = ''
      third_s = ''
      third_t = ''

      first_actual = rotation?(first_s, first_t)
      second_actual = rotation?(second_s, second_t)
      third_actual = rotation?(third_s, third_t)

      assert_equal(false, first_actual)
      assert_equal(false, second_actual)
      assert_equal(false, third_actual)
    end
  end
end
