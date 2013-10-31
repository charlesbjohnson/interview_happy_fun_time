# Maybe I'm dumb, but this seems a lot simpler than the book's approach
# and it is still O(N)
module ChapterFour
  module One

    def balanced?
      return true if @root.nil?

     (r_height(@root.left, 0) - r_height(@root.right, 0)).abs <= 1
    end

    private

    def r_height(cursor, height)
      return height if cursor.nil?

      left = r_height(cursor.left, height + 1)
      right = r_height(cursor.right, height + 1)
      left > right ? left : right
    end

  end
end
