require 'config_test'

module CTCI::ChapterNine
  class TestFour < Minitest::Test
    include Four

    def test_returns_all_subsets_of_sets
      assert_equal [[]], subsets_of_set([])

      assert_equal [[], [1]], subsets_of_set([1])

      assert_equal [[], [1], [2], [1, 2]].to_set, subsets_of_set([1, 2]).to_set

      assert_equal [[], [1], [2], [3],
                    [1, 2], [1, 3], [2, 3],
                    [1, 2, 3]].to_set, subsets_of_set([1, 2, 3]).to_set

      assert_equal [[], [1], [2], [3], [4],
                    [1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4],
                    [1, 2, 3], [1, 2, 4], [1, 3, 4], [2, 3, 4],
                    [1, 2, 3, 4]].to_set, subsets_of_set([1, 2, 3, 4]).to_set
    end
  end
end
