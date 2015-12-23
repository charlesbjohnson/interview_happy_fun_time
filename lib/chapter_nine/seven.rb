module ChapterNine
  module Seven
    # Implement the "paint fill" function that one might see on many image
    # editing programs. That is, given a screen (represented by a
    # two-dimensional array of colors), a point, and new color, fill in
    # the surrounding area until the color changes from the original color.
    def paint_fill(point, color, screen)
      x, y = point
      color_from = screen[y][x]
      rows = screen.size
      columns = screen[0].size
      r_paint_fill(point, color_from, color, screen, rows, columns)
    end

    private

    def r_paint_fill(point, color_from, color_to, s, r, c)
      x, y = point
      return unless (0...c).include?(x) && (0...r).include?(y)

      color = s[y][x]
      return if color == color_to
      return if color != color_from

      s[y][x] = color_to
      r_paint_fill([x, y.succ], color_from, color_to, s, r, c)
      r_paint_fill([x.succ, y], color_from, color_to, s, r, c)
      r_paint_fill([x, y.pred], color_from, color_to, s, r, c)
      r_paint_fill([x.pred, y], color_from, color_to, s, r, c)
    end
  end
end
