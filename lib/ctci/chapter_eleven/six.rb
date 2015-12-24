module CTCI::ChapterEleven
  module Six
    # Given an M x N matrix in which each row and each column is stored in
    # ascending order, write a method to find an element.
    def locate_in_matrix(e, m)
      return nil if m.empty? || m.all?(&:empty?)

      row = 0
      rows = m.size.pred
      column = m.first.size.pred
      until row > rows || column < 0
        column = binary_search_approximate(e, m[row], column)
        item = m[row][column]

        if e < item
          row += 1
          column -= 1
        elsif e > item
          row += 1
        else
          return [row, column]
        end
      end
    end

    private

    def binary_search_approximate(e, a, high)
      low = 0
      until low > high
        mid = (low + high) / 2
        mid_v = a[mid]

        if e < mid_v
          high = mid.pred
        elsif e > mid_v
          low = mid.succ
        else
          break
        end
      end

      mid
    end
  end
end
