module ChapterFour
  module Seven

    def first_ancestor(root, a, b)
      return nil unless r_contains(root, a) && r_contains(root, b)
      r_first_ancestor(root, a, b)
    end

    private

    def r_first_ancestor(cursor, a, b)
      return nil if cursor.nil?
      return cursor if cursor == a || cursor == b

      a_left = r_contains(cursor.left, a)
      b_left = r_contains(cursor.left, b)

      return cursor if a_left != b_left

      side = a_left ? cursor.left : cursor.right
      r_first_ancestor(side, a, b)
    end

    def r_contains(cursor, item)
      return false if cursor.nil?
      return true if cursor == item

      r_contains(cursor.left, item) || r_contains(cursor.right, item)
    end

  end
end
