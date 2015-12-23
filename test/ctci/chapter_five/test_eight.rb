require 'config_test'

module ChapterFive
  class TestEight < Minitest::Test
    include Eight

    def test_draws_line_on_screen
      width = height = 4
      screen = Array.new(width * height, 0b0000_0000)

      expected = [0b0000_0000, 0b0000_0000, 0b0000_0000, 0b0000_0000,
                  0b0000_0000, 0b0000_1111, 0b1111_1000, 0b0000_0000,
                  0b0000_0000, 0b0000_0000, 0b0000_0000, 0b0000_0000,
                  0b0000_0000, 0b0000_0000, 0b0000_0000, 0b0000_0000]

      assert_equal expected, draw_horizontal_line(screen, 8 * width,
                                                  12, 20, 1)
    end

    def test_draws_line_across_row
      width = 2
      height = 4
      screen = Array.new(width * height, 0b0000_0000)

      expected = [0b0000_0000, 0b0000_0000,
                  0b0000_0000, 0b0000_0000,
                  0b0000_0000, 0b0000_0000,
                  0b1111_1111, 0b1111_1111]

      assert_equal expected, draw_horizontal_line(screen, 8 * width,
                                                  0, 15, 3)
    end

    def test_draws_line_within_byte
      width = 2
      height = 4
      screen = Array.new(width * height, 0b0000_0000)

      expected = [0b0000_0000, 0b0000_0000,
                  0b0000_0000, 0b0000_0000,
                  0b0011_1100, 0b0000_0000,
                  0b0000_0000, 0b0000_0000]

      assert_equal expected, draw_horizontal_line(screen, 8 * width,
                                                  2, 5, 2)
    end

    def test_draws_line_across_bytes
      width = height = 4
      screen = Array.new(width * height, 0b0000_0000)

      expected = [0b0000_1111, 0b1111_1111, 0b1111_1111, 0b1111_0000,
                  0b0000_0000, 0b0000_0000, 0b0000_0000, 0b0000_0000,
                  0b0000_0000, 0b0000_0000, 0b0000_0000, 0b0000_0000,
                  0b0000_0000, 0b0000_0000, 0b0000_0000, 0b0000_0000]

      assert_equal expected, draw_horizontal_line(screen, 8 * width,
                                                  4, 27, 0)
    end

    def test_does_nothing_on_invalid_input
      width = height = 2
      screen = Array.new(width * height, 0b0000_0000)

      assert_equal screen, draw_horizontal_line(screen, 8 * width, -1, 1, 0)
      assert_equal screen, draw_horizontal_line(screen, 8 * width, 1, -1, 0)
      assert_equal screen, draw_horizontal_line(screen, 8 * width, 0, 5, -1)
    end
  end
end
