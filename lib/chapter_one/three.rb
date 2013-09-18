module ChapterOne
  module Three

    # Given two strings, write a method to decide if one is a permutation of
    # the other
    def permutation?(s, t)
      first, second = char_count(s), char_count(t)
      first == second
    end

    private

    def char_count(s)
      s.chars
       .group_by { |c| c }
       .map { |k, v| [k, v.length] }
       .to_set
    end

  end
end
