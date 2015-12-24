module CTCI::ChapterOne
  module Five
    # Implement a method to perform basic string compression using
    # the counts of repeated characters
    # If the compressed string would not become smaller than the original
    # string, return the original string instead
    # Example: aabcccccaaa -> a2b1c5a3
    # Example: abc -> abc
    def compress(s)
      compressed = s.chars
                   .chunk { |c| c }
                   .map { |k, v| k + v.length.to_s }
                   .join

      compressed.length > s.length ? s : compressed
    end
  end
end
