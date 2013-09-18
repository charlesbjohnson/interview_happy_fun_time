module ChapterOne
  class Four

    # Write a method to replace all spaces in a string with '%20'
    def self.encode_spaces(s)
      s.strip.split.join('%20')
    end

  end
end
