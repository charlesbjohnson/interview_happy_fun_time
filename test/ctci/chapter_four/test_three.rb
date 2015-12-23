require 'config_test'

module ChapterFour
  class TestThree < Minitest::Test
    class DataStructures::BinarySearchTreeMap
      include ThreeHelpers
      extend Three
    end

    def test_creates_tree_with_minimal_height_odd
      from = (1..7).to_a
      @tree = DataStructures::BinarySearchTreeMap.create_min_height(from)

      assert_equal 2, @tree.height
    end

    def test_creates_tree_with_minimal_height_even
      from = (1..6).to_a
      @tree = DataStructures::BinarySearchTreeMap.create_min_height(from)

      assert_equal 2, @tree.height
    end

    def test_does_nothing_if_empty
      @tree = DataStructures::BinarySearchTreeMap.create_min_height([])
      assert_equal(-1, @tree.height)
    end
  end
end
