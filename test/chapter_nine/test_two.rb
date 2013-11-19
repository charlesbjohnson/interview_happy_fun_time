require 'config_test'

module ChapterNine
  class TestTwo < Minitest::Test
    include Two

    def test_returns_number_of_ways_robot_can_move_through_grid
      assert_equal 2, count_robot_paths_to([1, 1])
      assert_equal 3, count_robot_paths_to([2, 1])
      assert_equal 6, count_robot_paths_to([2, 2])
      assert_equal 10, count_robot_paths_to([3, 2])
      assert_equal 20, count_robot_paths_to([3, 3])
    end

    def test_returns_one_for_single_step
      assert_equal 1, count_robot_paths_to([0, 0])
    end

    def test_returns_paths_to_target_around_obstacles
      assert_equal [[0, 0],
                    [1, 0],
                    [1, 1]], find_blocked_robot_path([1, 1], [[0, 1]])

      assert_equal [[0, 0],
                    [1, 0],
                    [1, 1],
                    [2, 1]], find_blocked_robot_path([2, 1], [[2, 0]])

      assert_equal [[0, 0],
                    [1, 0],
                    [2, 0],
                    [2, 1],
                    [2, 2]], find_blocked_robot_path([2, 2], [[0, 2], [1, 2]])

      assert_equal [[0, 0],
                    [0, 1],
                    [0, 2],
                    [1, 2],
                    [2, 2],
                    [3, 2]], find_blocked_robot_path([3, 2], [[2, 0], [1, 1]])
    end

    def test_returns_nil_if_no_path_to_target
      assert_nil find_blocked_robot_path([2, 2], [[2, 2]])
    end

  end
end
