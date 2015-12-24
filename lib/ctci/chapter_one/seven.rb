module CTCI::ChapterOne
  module Seven
    # Write an algorithm such that if an element in an MxN matrix is 0,
    # its entire row and column are set to 0
    def collapse_on_zero(matrix)
      column_length = matrix.first.length
      return [] unless matrix.all? { |row| row.length == column_length }

      result = matrix.dup
      rows_with_zero = result.map
                       .with_index { |row, i| i if row.include?(0) }
                       .compact
      rows_with_zero.each { |i| result[i] = Array.new(column_length, 0) }

      result
    end
  end
end
