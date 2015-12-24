# Also had to look this up. Didn't think of using a 1D array.
module CTCI::ChapterNine
  module Nine
    def queen_placements
      r_queen_placements(0, [], [], 8)
    end

    private

    def r_queen_placements(row, rows, result, size)
      if row == size
        result.push(rows.clone)
      else
        (0...size).each do |column|
          if valid_placement(rows, row, column)
            rows[row] = column
            r_queen_placements(row.succ, rows, result, size)
          end
        end
      end

      result
    end

    def valid_placement(rows, row, column)
      compared_to_row = row.pred
      until compared_to_row < 0
        compared_to_column = rows[compared_to_row]
        return false if compared_to_column == column

        column_delta = (column - compared_to_column).abs
        row_delta = row - compared_to_row
        return false if column_delta == row_delta

        compared_to_row -= 1
      end

      true
    end
  end
end
