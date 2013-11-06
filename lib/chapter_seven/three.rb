# I'm tired of these motha****in' slopes on this motha****kn' Cartesian plane!
#   - René Descartes
module ChapterSeven
  module Three

    EPSILON = 0.0001

    # Given two lines on a Cartesian plane, determine whether two lines
    # would intersect.
    def intersects?(a, b)
      slopes_different = (a.slope - b.slope).abs > EPSILON
      y_intercepts_same = (a.y_int - b.y_int).abs < EPSILON

      slopes_different || y_intercepts_same
    end

  end
end
