require 'config_test'

module CTCI::ChapterFour
  class TestFour < Minitest::Test
    BinarySearchTreeMap = DataStructures::BinarySearchTreeMap.dup.class_exec do
      include Four
    end

    def setup
      @tree = BinarySearchTreeMap.new
    end

    def test_returns_depth_lists_for_each_depth
      expected = [[4], [2, 6], [1, 3, 5, 7]].map { |g| g.map { |i| [i, i.to_s] } }
      expected.each { |g| g.each { |k, v| @tree.put(k, v) } }
      assert_equal expected, @tree.depth_lists
    end

    def test_returns_depth_lists_if_unbalanced
      expected = [[2], [1, 3], [4], [5]].map { |g| g.map { |i| [i, i.to_s] } }
      expected.each { |g| g.each { |k, v| @tree.put(k, v) } }
      assert_equal expected, @tree.depth_lists
    end

    def test_returns_nothing_if_empty
      assert_equal [], @tree.depth_lists
    end
  end
end
