require 'config_test'

module ChapterFive
  class TestThree < Minitest::Test
    include Three

    def test_returns_prev_and_next_numbers_with_same_number_bits
      vals = [
        [0b11_0110_0111_1100, 0b11_0110_0111_1010, 0b11_0110_1000_1111],
        [0b10_0100_0110, 0b10_0100_0101, 0b10_0100_1001],
        [0b1_0010_0010_0111, 0b1_0010_0001_1110, 0b1_0010_0010_1011],
        [0b10_1000_0111, 0b10_0111_1000, 0b10_1000_1011]
      ]

      vals.each do |input, p, n|
        assert_equal({ prev: p, next: n }, equal_bits_around(input))
      end
    end

    def test_returns_prev_and_next_numbers_when_single_bit
      a = 0b010
      p = 0b001
      n = 0b100
      assert_equal({ prev: p, next: n }, equal_bits_around(a))
    end

    def test_returns_prev_and_next_when_lopsided
      a = 0b01_1100
      p = 0b01_1010
      n = 0b10_0011
      assert_equal({ prev: p, next: n }, equal_bits_around(a))
    end

    def test_returns_nil_prev_when_doesnt_exist
      a = 0b0111
      p = nil
      n = 0b1011
      assert_equal({ prev: p, next: n }, equal_bits_around(a))
    end

    def test_returns_nil_when_zero
      assert_equal({ prev: nil, next: nil }, equal_bits_around(0))
    end
  end
end
