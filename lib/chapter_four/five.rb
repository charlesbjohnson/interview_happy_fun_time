module ChapterFour
  module Five

    def binary_search_tree?(root)
      r_binary_search_tree?(root, OpenStruct.new(key: nil))
    end

    def r_binary_search_tree?(cursor, last)
      return true if cursor.nil?

      return false unless r_binary_search_tree?(cursor.left, last)

      unless last.key.nil?
        return false if cursor.key < last.key
      end

      last.key = cursor.key

      r_binary_search_tree?(cursor.right, last)
    end

  end
end
