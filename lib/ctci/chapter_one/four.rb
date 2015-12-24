module CTCI::ChapterOne
  module Four
    # Write a method to replace all spaces in a string with '%20'
    def encode_spaces(s)
      s.strip.split.join('%20')
    end
  end
end
