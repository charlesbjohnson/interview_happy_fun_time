require 'config_test'

module ChapterFour
  class TestFive < Minitest::Test
    include Five

    def setup
      nodes = [[3,[1,4]],[1,[0,2]]]
      @tree = DataStructures::BinaryTree.from(nodes, 3)
    end

    def test_returns_true_if_tree_is_binary_search_tree
      assert binary_search_tree?(@tree.root)
    end

    def test_returns_false_if_tree_is_not_binary_search_tree
      nodes = [[2,[1,4]],[1,[0,3]]]
      @tree = DataStructures::BinaryTree.from(nodes, 2)

      refute binary_search_tree?(@tree.root)
    end

    def test_returns_true_if_single
      nodes = [1]
      @tree = DataStructures::BinaryTree.from(nodes, 1)

      assert binary_search_tree?(@tree.root)
    end

    def test_returns_true_if_empty
      assert binary_search_tree?(nil)
    end

  end
end
