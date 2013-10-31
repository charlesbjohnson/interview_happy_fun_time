module ChapterFour
  module Four

    def depth_lists
      result = []
      return result if @root.nil?

      r_depth_lists(@root, 0, result)
      result
    end

    private

    def r_depth_lists(cursor, depth, result)
      return if cursor.nil?

      depth_list = result[depth] ||= []
      depth_list.push([cursor.key, cursor.value])

      r_depth_lists(cursor.left, depth + 1, result)
      r_depth_lists(cursor.right, depth + 1, result)
    end

  end
end
