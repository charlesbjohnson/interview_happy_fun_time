module ChapterFour
  module Eight

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
