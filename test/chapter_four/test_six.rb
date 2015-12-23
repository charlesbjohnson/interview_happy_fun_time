require 'config_test'

module ChapterFour
  class TestSix < Minitest::Test
    include Six

    def setup
      nodes = 5.times.map { |i| TreeTripleNode.new(i, i.to_s) }
      @root = nodes[3]
      @root.parent = nil
      @root.left = nodes[1]
      @root.right = nodes[4]
      @root.left.parent = @root.right.parent = @root
      @root.left.left = nodes[0]
      @root.left.right = nodes[2]
      @root.left.left.parent = @root.left.right.parent = @root.left
    end

    def test_returns_next_from_root_subtree
      assert_equal @root.left.right, next_inorder(@root.left)
    end

    def test_returns_next_from_left_leaf
      assert_equal @root.left, next_inorder(@root.left.left)
    end

    def test_returns_next_from_right_leaf
      assert_equal @root, next_inorder(@root.left.right)
    end

    def test_returns_nil_from_largest
      assert_nil next_inorder(@root.right)
    end
  end

  class TreeTripleNode
    attr_accessor :key, :value, :left, :right, :parent

    def initialize(k, v)
      @key = k
      @value = v
    end
  end
end
