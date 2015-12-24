# Maybe I'm dumb, but this seems a lot simpler than the book's approach
# and it is still O(N)
module CTCI::ChapterFour
  module One
    # Implement a function to check if a binary tree is balanced. For
    # the purposes of this question, a balanced tree is defined to be a
    # tree such that the heights of the two subtrees of any node
    # never differ by more than one.
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
