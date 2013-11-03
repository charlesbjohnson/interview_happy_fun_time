require 'config_test'

module ChapterFive
  class TestOne < Minitest::Test
    include One

    def setup
      @overwrite = 0b0100_1001_0010
      @with = 0b1100
    end

    def test_returns_bit_overwritten_value
      assert_equal 0b0100_1100_0010, overwrite_bits(@overwrite, @with, 4, 7)
    end

    def test_returns_bit_overwritten_value_at_left_end
      assert_equal 0b1100_1001_0010, overwrite_bits(@overwrite, @with, 8, 11)
    end

    def test_returns_bit_overwritten_value_at_right_end
      assert_equal 0b0100_1001_1100, overwrite_bits(@overwrite, @with, 0, 3)
    end

    def test_returns_bit_overwritten_value_book_example
      @overwrite = 0b0100_0000_0000
      @with = 0b0001_0011
      assert_equal 0b0100_0100_1100, overwrite_bits(@overwrite, @with, 2, 6)
    end

  end
end
