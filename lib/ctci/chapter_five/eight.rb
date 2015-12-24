# Didn't need help from the book, but still ridiculously hard.
# So many potential off by one errors, this would be a nightmare
# to try and implement in an interview.
module CTCI::ChapterFive
  module Eight
    # A monochrome screen is stored as a single array of bytes, allowing
    # eight consecutive pixels to be stored in one byte. The screen has
    # width w, where w is divisible by 8 (that is, no byte will be split
    # across rows). The height of the screen, of course, can be derived
    # from the length of the array and the width. Implement a function
    # drawHorizontalLine(byte[] screen, int width, int x1, int x2, int y)
    # which draws a horizontal line from (x1, y) to (x2, y)
    def draw_horizontal_line(screen, width, x1, x2, y)
      return screen if x1 < 0 || x2 < 0 || y < 0

      columns = width / 8
      vertical_index = y * columns

      horizontal_index_x1 = (x1 / 8)
      horizontal_index_x2 = (x2 / 8)

      x1_index = horizontal_index_x1 + vertical_index
      x2_index = horizontal_index_x2 + vertical_index

      bytes_to_fill = (x1_index.succ..x2_index.pred)
      bytes_to_fill.each { |b| screen[b] = enable_btye(screen[b]) }

      if x1_index < x2_index
        left = screen[x1_index]
        right = screen[x2_index]

        bits_from_ls = (get_max_pixel(horizontal_index_x1) - x1).succ
        bits_from_ms = (x2 - get_min_pixel(horizontal_index_x2)).succ

        screen[x1_index] = set_from_least_significant(bits_from_ls, left)
        screen[x2_index] = set_from_most_significant(bits_from_ms, 8, right)
      else
        horizontal_index = horizontal_index_x1
        index = x1_index

        max_pixel = get_max_pixel(horizontal_index)
        byte = screen[index]
        screen[index] = set_from_index(max_pixel - x1, max_pixel - x2, byte)
      end

      screen
    end

    def enable_btye(n)
      n | 0xff
    end

    def get_min_pixel(index)
      8 * index
    end

    def get_max_pixel(index)
      (8 * index.succ).pred
    end

    # i being the index closest to the most significant bit
    # to being the index closest to the least significant bit
    def set_from_index(i, to, n)
      set_from_least_significant(i.pred, n) << to
    end

    def set_from_least_significant(count, n)
      n | (1 << count).pred
    end

    def set_from_most_significant(count, of, n)
      n | ((1 << count.succ) - 2) << ((of - count).pred)
    end
  end
end
