require 'config_test'

module ChapterSeven
  class TestFive < Minitest::Test
    include Five

    def test_returns_line_segment_that_halves_both_squares_when_left_or_right
      left = Square.new([[2.0, 2.0], [5.0, 2.0],
                         [2.0, 5.0], [5.0, 5.0]])
      right = Square.new([[7.0, 2.0], [10.0, 2.0],
                          [7.0, 5.0], [10.0, 5.0]])

      expected = [Point.new([2.0, 3.5]), Point.new([10.0, 3.5])]
      assert_equal expected, find_half_of_squares_line(left, right)

      left, right = right, left
      assert_equal expected.reverse, find_half_of_squares_line(left, right)
    end

    def test_returns_line_segment_that_halves_both_squares_when_above_or_below
      above = Square.new([[2.0, 2.0], [5.0, 2.0],
                          [2.0, 5.0], [5.0, 5.0]])
      below = Square.new([[2.0, 7.0], [5.0, 7.0],
                          [2.0, 10.0], [5.0, 10.0]])

      expected = [Point.new([3.5, 2.0]), Point.new([3.5, 10.0])]
      assert_equal expected, find_half_of_squares_line(above, below)

      above, below = below, above
      assert_equal expected.reverse, find_half_of_squares_line(above, below)
    end

    def test_returns_line_segment_when_square_above_left_or_below_right
      above_left = Square.new([[2.0, 2.0], [5.0, 2.0],
                               [2.0, 5.0], [5.0, 5.0]])
      below_right = Square.new([[7.0, 7.0], [10.0, 7.0],
                                [7.0, 10.0], [10.0, 10.0]])

      expected = [Point.new([2.0, 2.0]), Point.new([10.0, 10.0])]
      assert_equal expected,
                   find_half_of_squares_line(above_left, below_right)

      above_left, below_right = below_right, above_left
      assert_equal expected.reverse,
                   find_half_of_squares_line(above_left, below_right)
    end

    def test_returns_line_segment_when_square_above_right_or_below_left
      below_left = Square.new([[2.0, 7.0], [5.0, 7.0],
                               [2.0, 10.0], [5.0, 10.0]])
      above_right = Square.new([[7.0, 2.0], [10.0, 2.0],
                                [7.0, 5.0], [10.0, 5.0]])

      expected = [Point.new([2.0, 10.0]), Point.new([10.0, 2.0])]
      assert_equal expected,
                   find_half_of_squares_line(below_left, above_right)

      above_right, below_left = below_left, above_right
      assert_equal expected.reverse,
                   find_half_of_squares_line(below_left, above_right)
    end

    def test_returns_line_segment_when_same_size
      first = Square.new([[2.0, 2.0], [5.0, 2.0],
                          [2.0, 5.0], [5.0, 5.0]])
      second = Square.new([[2.0, 2.0], [5.0, 2.0],
                           [2.0, 5.0], [5.0, 5.0]])
      assert_equal [Point.new([2.0, 3.5]), Point.new([5.0, 3.5])],
                    find_half_of_squares_line(first, second)
    end

    def test_returns_line_segment_when_encompassing
      smaller = Square.new([[2.0, 2.0], [5.0, 2.0],
                            [2.0, 5.0], [5.0, 5.0]])
      larger = Square.new([[0.0, 0.0], [7.0, 0.0],
                           [0.0, 7.0], [7.0, 7.0]])
      assert_equal [Point.new([0.0, 3.5]), Point.new([7.0, 3.5])],
                   find_half_of_squares_line(smaller, larger)

      smaller, larger = larger, smaller
      assert_equal [Point.new([0.0, 3.5]), Point.new([7.0, 3.5])],
                   find_half_of_squares_line(smaller, larger)

    end

    def test_returns_line_segment_when_negative
      top_left = Square.new([[-6.0, -3.0], [-3.0, -3.0],
                             [-6.0, 0.0], [-3.0, 0.0]])
      bottom_right = Square.new([[2.0, 2.0], [5.0, 2.0],
                                 [2.0, 5.0], [5.0, 5.0]])

      assert_equal [Point.new([-6.0, -2.4375]), Point.new([5.0, 4.4375])],
                   find_half_of_squares_line(top_left, bottom_right)
    end

  end
end
