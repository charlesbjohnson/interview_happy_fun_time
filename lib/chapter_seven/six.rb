module ChapterSeven
  module Six

    # Given a two-dimensional graph with points on it, find a line
    # which passes the most number of points.
    def line_of_best_fit(points)
      line_intersections = {}

      0.upto(points.size - 2) do |i|
        i.succ.upto(points.size - 1).each do |j|
          line = Line.from_points(points[i], points[j])
          approx_slope = line.slope.round(1)
          counter = line_intersections[approx_slope] ||= [0, line]
          counter[0] += 1
        end
      end

      line_intersections.max_by { |_, v| v.first }.last.last
    end

    class Point
      @@pnt = Struct.new(:x, :y)

      def self.new(coords)
        @@pnt.new(coords.first, coords.last)
      end
    end

    class Line
      attr_accessor :slope, :y_intercept, :x_intercept

      def initialize(slp, yint, xint = nil)
        @slope = slp
        @y_intercept = yint
        @x_intercept = xint || calculate_x_intercept
      end

      def self.from_points(a, b)
        delta_y = b.y - a.y
        delta_x = b.x - a.x

        return new(Float::INFINITY, Float::NAN, a.x) if delta_x.round(1).zero?

        slope = (delta_y / delta_x)
        y_int = calculate_y_intercept(slope, a)

        new(slope, y_int)
      end

      def ==(other)
        same_slope = @slope == other.slope
        same_y_intercept = @y_intercept == other.y_intercept
        if @slope.infinite?
          same_slope
        elsif @slope.zero?
          same_slope && same_y_intercept
        else
          same_x_intercept = @x_intercept == other.x_intercept
          same_slope && same_y_intercept && same_x_intercept
        end
      end

      alias_method :eql?, :==

      def hash
        [@slope, @y_intercept].hash
      end

      private

      def self.calculate_y_intercept(slope, point_on_line)
        horizontal_distance_from_zero = 0 - point_on_line.x
        y_int = (horizontal_distance_from_zero * slope) + point_on_line.y
        rounded = y_int.round(1)
        rounded.zero? ? 0.0 : rounded
      end

      def calculate_x_intercept
        x_int = @slope.zero? ? Float::NAN : -@y_intercept / @slope
        rounded = x_int.round(1)
        rounded.zero? ? 0.0 : rounded
      end
    end

  end
end
