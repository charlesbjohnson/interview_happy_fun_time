module CTCI::ChapterFour
  module Nine
    # You are given a binary tree in which each node contains a value.
    # Design an algorithm to print all paths which sum to a given value.
    # The path does not need to start or end at the root or a leaf.
    def paths_to_sum(root, target)
      paths = []
      r_paths_to_sum(root, 0, target, [], paths)

      paths
    end

    private

    def r_paths_to_sum(cursor, current_sum, target_sum, current_path, paths)
      return nil if cursor.nil?

      sum = cursor.value.to_i + current_sum

      if sum == target_sum
        finished_path = current_path.push(cursor.key).clone
        paths.push(finished_path)
        current_path.pop
        return
      end

      if current_path.empty?
        r_paths_to_sum(cursor.left, current_sum, target_sum, current_path, paths)
        r_paths_to_sum(cursor.right, current_sum, target_sum, current_path, paths)
      end

      current_path.push(cursor.key)
      r_paths_to_sum(cursor.left, sum, target_sum, current_path, paths)
      r_paths_to_sum(cursor.right, sum, target_sum, current_path, paths)
      current_path.pop
    end
  end
end
