# Wow and I thought I was being so clever with my rinky dink hash,
# but apparently binomial coefficient is sufficient for the first part.
# How disappointing.
module CTCI::ChapterNine
  module Two
    # Imagine a robot sitting on the upper left corner of an X by Y grid.
    # The robot can only move in two directions: right and down. How many
    # possible paths are there for the robot to go from (0,0) to (X,Y)?
    #
    # FOLLOW UP
    # Imagine certain spots are 'off limits', such that the robot cannot
    # step on them. Design an algorithm to find a path for the robot from
    # the top left to the bottom right.
    def count_robot_paths_to(target)
      @paths = { target => 1 }
      r_count_robot_paths_to([0, 0], target)

      # Or even simpler...
      # x, y = target
      # (factorial(x + y)) / (factorial(x) * factorial(y))
    end

    def find_blocked_robot_path(target, obstacles)
      return if obstacles.include?(target)

      result = []
      last = r_find_blocked_robot_path(target, [0, 0], obstacles, result, {})
      result.push(target) if last
    end

    private

    # def factorial(n)
    # (1..n).reduce(:*) || 1
    # end

    def r_count_robot_paths_to(cursor, target)
      p = @paths[cursor]
      return p if p

      r = d = 0
      cur_x, cur_y = cursor

      if cur_x < target.first
        r = r_count_robot_paths_to([cur_x.succ, cur_y], target)
      end

      if cur_y < target.last
        d = r_count_robot_paths_to([cur_x, cur_y.succ], target)
      end

      @paths[cursor] = r + d
    end

    def r_find_blocked_robot_path(cursor, target, obstacles, result, dead_end)
      return nil if obstacles.include?(cursor)

      found_a_path = !result.empty?
      cur_x, cur_y = cursor
      to_up = [cur_x, cur_y.pred]
      to_left = [cur_x.pred, cur_y]
      can_go_up = cur_y > target.last && !dead_end[to_up]
      can_go_left = cur_x > target.first && !dead_end[to_left]

      if can_go_up
        up = r_find_blocked_robot_path(to_up, target, obstacles, result, dead_end)
        if up
          result.push(up)
          found_a_path = true
        end
      end

      if !found_a_path && can_go_left
        left = r_find_blocked_robot_path(to_left, target, obstacles, result, dead_end)
        if left
          result.push(left)
          found_a_path = true
        end
      end

      dead_end[cursor] = !found_a_path
      cursor if cursor == target || found_a_path
    end
  end
end
