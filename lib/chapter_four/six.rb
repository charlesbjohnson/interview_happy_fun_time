module ChapterFour
  module Six

    def next_inorder(cursor)
      if cursor.right.nil?
        parent = cursor
        puts parent.key
        until parent.nil? || parent.key > cursor.key
          parent = parent.parent
        end

        parent
      else
        min(cursor.right)
      end
    end

    private

    def min(cursor)
      return cursor if cursor.left.nil?
      min(cursor.left)
    end

  end
end
