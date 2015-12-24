# Bahh, I really suck at these.
module CTCI::ChapterNine
  module Six
    # Implement an algorithm to print all valid (e.g., properly opened
    # and closed) combinations of n-pairs of parentheses.
    #
    # EXAMPLE
    # Input: 3
    # Output: ((())), (()()), (())(), ()(()), ()()()
    def parentheses_combinations(n)
      result = []
      r_parentheses_combinations((' ' * (n * 2)), n, n, 0, result) if n > 0
      result
    end

    private

    def r_parentheses_combinations(s, left, right, i, result)
      if left.zero? && right.zero?
        result.push(s.clone)
      else
        if left.nonzero?
          s[i] = '('
          r_parentheses_combinations(s, left.pred, right, i.succ, result)
        end

        if right > left
          s[i] = ')'
          r_parentheses_combinations(s, left, right.pred, i.succ, result)
        end
      end
    end
  end
end
