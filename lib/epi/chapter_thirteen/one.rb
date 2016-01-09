require 'set'

module EPI::ChapterThirteen
  module One
    # Write a function that takes as input a dictionary of English words,
    # and returns a partition of the dictionary into subsets of words that
    # are all anagrams of each other.
    def anagram_sets(words)
      words = words.to_a.sort!

      set_map = Hash.new { |h, k| h[k] = Set.new }

      anagram_set_map = words.each_with_object(set_map) do |e, a|
        sorted_word = e.chars.sort.join
        a[sorted_word].add(e)
      end

      anagram_set_map
        .reject { |_, v| v.size <= 1 }
        .map { |_, v| [v.first, v.drop(1)] }
    end
  end
end
