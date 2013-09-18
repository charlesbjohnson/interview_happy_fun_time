module ChapterOne
  class One

    # Implement an algorithm to determine if a string has all unique characters
    def self.unique_chars?(s)
      existing_vals = []
      ascii_vals = s.bytes
      result = true
      ascii_vals.each do |v|
        existing_vals[v] == 1 ? result = false : existing_vals[v] = 1
      end

      result
    end

  end
end
