require 'config_test'

module EPI::ChapterFive
  class TestOne < Minitest::Test
    include One

    def test_parity_returns_one_when_number_of_on_bits_is_odd
      w = 0b1011
      result = parity(w)

      assert_equal(1, result)
    end

    def test_parity_returns_zero_when_number_of_on_bits_is_even
      w = 0b1001
      result = parity(w)

      assert_equal(0, result)
    end

    def test_split_returns_number_in_binary_chunks
      w = 0b1001_1010_0001_1000

      result = split(w)

      assert_equal(0b1001_1010, result[-2])
      assert_equal(0b0001_1000, result[-1])
    end

    def test_split_returns_number_in_arbitrarily_sized_binary_chunks
      w = 0b1001_1010

      result = split(w, chunk_width: 4)

      assert_equal(0b1001, result[-2])
      assert_equal(0b1010, result[-1])
    end
  end
end
