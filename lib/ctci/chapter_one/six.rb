module CTCI::ChapterOne
  module Six
    # Given an image represented by an NxN matrix, where each pixel in
    # the image is 4 bytes, write a method to rotate the image by 90 degrees
    def rotate(matrix)
      # not a rectangular matrix, fail
      rotated_length = matrix.first.length
      return [] unless matrix.all? { |r| r.length == rotated_length }

      result = Array.new(rotated_length) { [] }
      matrix.each do |row|
        rotated_length.times do |i|
          result[i].unshift(row[i])
        end
      end

      result
    end
  end
end
