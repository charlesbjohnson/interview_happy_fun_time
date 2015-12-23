require 'config_test'

module ChapterFour
  class TestOne < Minitest::Test
    class DataStructures::BinarySearchTreeMap
      include One
    end

    def setup
      @tree = DataStructures::BinarySearchTreeMap.new
    end

    def test_returns_true_if_tree_is_balanced
      @tree.put(:c, 3)
      @tree.put(:a, 1)
      @tree.put(:b, 2)
      @tree.put(:d, 4)

      assert @tree.balanced?
    end

    def test_returns_false_if_tree_is_not_balanced
      @tree.put(:b, 2)
      @tree.put(:a, 1)
      @tree.put(:c, 3)
      @tree.put(:d, 4)
      @tree.put(:e, 5)

      refute @tree.balanced?
    end

    def test_returns_true_if_empty
      assert @tree.balanced?
    end
  end
end
