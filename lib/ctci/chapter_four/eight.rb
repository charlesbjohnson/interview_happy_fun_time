module CTCI::ChapterFour
  module Eight
    # You have two very large binary trees: T1, with millions of nodes,
    # and T2, with hundreds of nodes. Create an algorithm to decide if T2
    # is a subtree of T1.
    #
    # A tree T2 is a subtree of T1 if there exists a node n in T1 such that
    # the subtree of n is identical to T2. That is, if you cut off the tree
    # at node n, the two trees would be identical.
    def contains_subtree?(larger, smaller)
      r_contains_subtree?(larger, smaller)
    end

    private

    def r_contains_subtree?(larger, smaller)
      return false if larger.nil?

      matching_root = larger.key == smaller.key
      return true if matching_root && r_exact_match?(larger, smaller)

      in_left = r_contains_subtree?(larger.left, smaller)
      in_right = r_contains_subtree?(larger.right, smaller)
      in_left || in_right
    end

    def r_exact_match?(left, right)
      return true if left.nil? && right.nil?

      return false if left.nil? != right.nil?
      return false unless left.key == right.key

      match_left = r_exact_match?(left.left, right.left)
      match_right = r_exact_match?(left.right, right.right)
      match_left && match_right
    end
  end
end
