require 'config_test'

module CTCI::ChapterFive
  class TestTwo < Minitest::Test
    include Two

    def test_returns_binary_string_of_number
      assert_equal '0.101', to_binary_s(0.625)
    end

    def test_returns_binary_string_when_one_digit
      assert_equal '0.1', to_binary_s(0.5)
    end

    def test_returns_binary_string_when_zeroes
      assert_equal '0.00001111', to_binary_s(0.05859375)
    end

    def test_returns_error_when_too_large
      assert_equal 'ERROR', to_binary_s(0.72)
    end
  end
end
