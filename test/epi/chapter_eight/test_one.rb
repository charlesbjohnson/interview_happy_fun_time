require 'config_test'

module EPI::ChapterEight
  class TestOne < Minitest::Test
    include One

    def setup
      @left_list = DataStructures::LinkedList.new
      [2, 5, 7].each { |i| @left_list.append(i) }

      @right_list = DataStructures::LinkedList.new
      [3, 11].each { |i| @right_list.append(i) }
    end

    def test_ascending_merge_modifies_the_lists
      ascending_merge!(@left_list, @right_list)

      expected = [2, 3, 5, 7, 11]

      assert_equal(expected, @left_list.to_a)
      assert_equal(expected, @right_list.to_a)
    end

    def test_ascending_merge_merges_lists
      result = ascending_merge!(@left_list, @right_list)

      assert_equal(5, result.size)
      assert_equal([2, 3, 5, 7, 11], result.to_a)
    end

    def test_ascending_merge_merges_lists_when_a_list_is_empty
      result = ascending_merge!(@left_list, DataStructures::LinkedList.new)

      assert_equal(3, result.size)
      assert_equal([2, 5, 7], result.to_a)
    end
  end
end
