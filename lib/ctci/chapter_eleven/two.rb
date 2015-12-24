module CTCI::ChapterEleven
  module Two
    # Write a method to sort an array of strings so that all the anagrams are
    # next to each other.
    def group_anagrams(a)
      groups = a.each_with_object({}) do |w, anagrams|
        anagram_key = anagrams.keys.find { |k| anagrams?(w, k) } || w
        (anagrams[anagram_key] ||= []).push(w)
      end

      groups.values.flatten
    end

    private

    def anagrams?(a, b)
      a.chars.sort.join == b.chars.sort.join
    end
  end
end
