require 'config_test'

module EPI::ChapterSeven
  class TestOne < Minitest::Test
    include One

    def test_i_to_s_converts_an_integer_to_string
      i = 29
      result = i_to_s(i)
      assert_equal('29', result)
    end

    def test_i_to_s_converts_an_integer_to_string_when_negative
      i = -190
      result = i_to_s(i)
      assert_equal('-190', result)
    end

    def test_i_to_s_converts_an_integer_to_string_when_zero
      i = 0
      result = i_to_s(i)
      assert_equal('0', result)
    end

    def test_i_to_s_does_not_fail_on_non_integer_input
      i = 3.5
      result = i_to_s(i)
      assert_equal('3', result)
    end

    def test_s_to_i_converts_a_string_to_an_integer
      s = '3'
      result = s_to_i(s)
      assert_equal(3, result)
    end

    def test_s_to_i_converts_a_negative_string_to_an_integer
      s = '-5291'
      result = s_to_i(s)
      assert_equal(-5291, result)
    end

    def test_s_to_i_fails_on_unconvertable_input
      assert_raises { s_to_i '14fd59' }
    end
  end
end
