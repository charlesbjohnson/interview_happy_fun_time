module ChapterOne
  module Two

    # Implement a function which reverses a string
    def reverse(s)
      lo, hi = 0, s.length.pred
      result = s.dup

      while lo < hi
        tmp = result[lo]
        result[lo] = result[hi]
        result[hi] = tmp

        lo, hi = lo.succ, hi.pred
      end

      result
    end

  end
end
