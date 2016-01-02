module CTCI::ChapterFour
  module Three
    # Given a sorted (increasing order) array with unique integer elements,
    # write an algorithm to create a binary search tree with minimal height.
    def create_min_height(from)
      result = new
      return result if from.empty?

      r_create_min_height(result, from, 0, from.size.pred)
      result
    end

    private

    def r_create_min_height(result, from, low, high)
      return if low > high

      mid = (low + high) / 2
      new = from[mid]
      result.put(new.to_s, new)

      r_create_min_height(result, from, low, mid.pred)
      r_create_min_height(result, from, mid.succ, high)
    end
  end

  module ThreeHelpers
    def height
      return -1 if @root.nil?
      r_height(@root, -1)
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
