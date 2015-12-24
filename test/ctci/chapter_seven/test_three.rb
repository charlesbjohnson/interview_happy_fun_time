require 'config_test'

module CTCI::ChapterSeven
  class TestThree < Minitest::Test
    include Three

    def setup
      @line = Struct.new(:slope, :y_int)
    end

    def test_returns_true_if_lines_intersect
      a = @line.new(3.2, 6.5)
      b = @line.new(11.8, 2.4)

      assert intersects?(a, b)
    end

    def test_returns_true_if_lines_same
      a = @line.new(3.01, 6.02)
      b = @line.new(3.02, 6)

      assert intersects?(a, b)
    end

    def test_returns_false_if_lines_parallel
      a = @line.new(3.0002, 3)
      b = @line.new(3.00025, 6)

      refute intersects?(a, b)
    end
  end
end
