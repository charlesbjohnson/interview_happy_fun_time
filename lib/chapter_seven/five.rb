# Another ridiculously length one.
module ChapterSeven
  module Five

    # Given two squares on a two-dimensional plane, find a line that
    # would cut these two squares in half. Assume that the top and the
    # bottom sides of the square run parallel to the x-axis
    def find_half_of_squares_line(a, b)
      center_a = center(a)
      center_b = center(b)

      center_slope = slope(center_a, center_b)

      a_intersections = b_intersections = nil
      if center_slope.slope.round.zero?
        if squares_horizontal?(center_a, center_b)
          # Lefts and rights of each square
          a_intersections = [Point.new([a.top_left.x, center_a.y]),
                             Point.new([a.top_right.x, center_a.y])]
          b_intersections = [Point.new([b.top_left.x, center_b.y]),
                             Point.new([b.top_right.x, center_b.y])]
        elsif squares_vertical?(center_a, center_b)
          # Tops and bottoms of each square
          a_intersections = [Point.new([center_a.x, a.top_left.y]),
                             Point.new([center_a.x, a.bottom_left.y])]
          b_intersections = [Point.new([center_b.x, b.top_left.y]),
                             Point.new([center_b.x, b.bottom_left.y])]
        end
      else
        a_intersections = intersects_at(center_slope, a)
        b_intersections = intersects_at(center_slope, b)
      end

      farthest(a_intersections + b_intersections)
    end

    class Point
      @@pnt = Struct.new(:x, :y)
      def self.new(coords)
        @@pnt.new(coords.first, coords.last)
      end
    end

    class Square
      @@sqr = Struct.new(*%i[top_left top_right bottom_left bottom_right])
      def self.new(points)
       @@sqr.new(*points.map { |p| Point.new(p) })
      end
    end

    class Line
      @@ln = Struct.new(:slope, :y_intercept)
      def self.new(slp, yint)
         @@ln.new(slp, yint)
      end
    end

    private

    def center(square)
      width = square.top_right.x - square.top_left.x
      height = square.bottom_left.y - square.top_left.y
      center_x = (width / 2) + square.top_left.x
      center_y = (height / 2) + square.top_left.y
      Point.new([center_x, center_y])
    end

    def slope(from, to)
      delta_y = to.y - from.y
      delta_x = to.x - from.x

      return Line.new(0, 0) if (delta_y.round.zero?) || (delta_x.round.zero?)

      slope = delta_y / delta_x
      horizontal_distance_from_zero = 0 - from.x
      y_int = (slope * horizontal_distance_from_zero) + from.y
      Line.new(slope, y_int)
    end

    def squares_horizontal?(center_from, center_to)
      y_same = (center_from.y - center_to.y).round.zero?
      left_to_right = (center_to.y - center_from.y).round.zero?
      y_same && left_to_right
    end

    def squares_vertical?(center_from, center_to)
      x_same = (center_from.x - center_to.x).round.zero?
      top_to_bottom = (center_to.x - center_from.x).round.zero?
      x_same && top_to_bottom
    end

    def intersects_at(slope, square)
      top = point_at_y_with_slope(square.top_left.y, slope)
      bottom = point_at_y_with_slope(square.bottom_left.y, slope)
      left = point_at_x_with_slope(square.top_left.x, slope)
      right = point_at_x_with_slope(square.top_right.x, slope)

      top = point_within_segment?(top, square.top_left, square.top_right) ? top : nil
      bottom = point_within_segment?(bottom, square.bottom_left, square.bottom_right) ? bottom : nil
      left = point_within_segment?(left, square.top_left, square.bottom_left) ? left : nil
      right = point_within_segment?(right, square.top_right, square.bottom_right) ? right : nil

      [top, bottom, left, right].compact.uniq
    end

    def point_at_x_with_slope(x, slope)
      Point.new([x, ((slope.slope * x) + slope.y_intercept)])
    end

    def point_at_y_with_slope(y, slope)
      Point.new([((y - slope.y_intercept) / slope.slope), y])
    end

    def point_within_segment?(point, segment_start, segment_end)
      within_x = (segment_start.x..segment_end.x).include?(point.x)
      within_y = (segment_start.y..segment_end.y).include?(point.y)
      within_x && within_y
    end

    def farthest(points)
      comparisons(points).map { |fp, tp| [distance(fp, tp), [fp, tp]] }
                         .sort_by { |e| e.first }
                         .last
                         .last
    end

    def comparisons(points)
      result = []
      0.upto(points.size - 2) do |i|
        i.succ.upto(points.size - 1) do |j|
          result.push([points[i], points[j]])
        end
      end

      result
    end

    def distance(from, to)
      x_distance = from.x - to.x
      y_distance = from.y - to.y
      Math.sqrt(x_distance**2 + y_distance**2)
    end

  end
end
