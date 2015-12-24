module CTCI::ChapterFour
  module Five
    # Implement a function to check if a binary tree is a binary
    # search tree.
    def binary_search_tree?(root)
      r_binary_search_tree?(root, OpenStruct.new(key: nil))
    end

    def r_binary_search_tree?(cursor, last)
      return true if cursor.nil?
      return false unless r_binary_search_tree?(cursor.left, last)
      return false if !last.key.nil? && cursor.key < last.key

      last.key = cursor.key

      r_binary_search_tree?(cursor.right, last)
    end
  end
end
