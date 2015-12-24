module CTCI::ChapterNine
  module Four
    # Write a method to return all subsets of a set.
    def subsets_of_set(set)
      set.reduce([[]]) do |result, i|
        result.concat(result.map { |s| s.clone.push(i) })
      end
    end
  end
end
