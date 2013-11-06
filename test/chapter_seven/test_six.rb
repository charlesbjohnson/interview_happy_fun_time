require 'config_test'

module ChapterSeven
  class TestSix < Minitest::Test
    include Six

    def test_returns_line_passing_through_all_points
      pts = [[3.0 , 0.0], [5.0, 1.0], [7.0, 2.0]]
      pts.map! { |p| Point.new(p) }
      assert_equal Line.new(0.5, -1.5), line_of_best_fit(pts)
    end

    def test_returns_line_passing_through_negative
      pts = [[-3.0 , 2.0], [-1.0, 5.0], [1.0, 8.0]]
      pts.map! { |p| Point.new(p) }
      assert_equal Line.new(1.5, 6.5), line_of_best_fit(pts)
    end

    def test_returns_line_passing_through_same
      pts = [[1.0, 2.0], [6.0, -3.0], [1.0, 2.0], [-6.0, 7.0], [3.0, 0.0]]
      pts.map! { |p| Point.new(p) }
      assert_equal Line.new(-1.0, 3.0), line_of_best_fit(pts)
    end

    def test_returns_line_passing_through_vertical
      pts = [[2.0 , 3.0], [-1.0, 5.0], [2.0, 8.0], [2.0, 1.0], [6.25, 4.25]]
      pts.map! { |p| Point.new(p) }
      assert_equal Line.new(Float::INFINITY, Float::NAN, 2.0),
                   line_of_best_fit(pts)
    end

    def test_returns_line_passing_through_horizontal
      pts = [[0.0 , 4.0], [-1.0, 3.0], [12.0, 4.0], [6.25, 4.15], [-3.0, 4.0]]
      pts.map! { |p| Point.new(p) }
      assert_equal Line.new(0.0, 4.0),
                   line_of_best_fit(pts)
    end

    def test_returns_line_passing_through_approximate
      pts = [[0.00242 , 0.0], [1.001453, 1.0066563], [2.0020214, 2.00223432],
             [-5.0, 3.0], [-4.0, 2.0]]
      pts.map! { |p| Point.new(p) }
      assert_equal Line.new(1.007630678866464, 0.0, 0.0),
                   line_of_best_fit(pts)
    end

  end
end
