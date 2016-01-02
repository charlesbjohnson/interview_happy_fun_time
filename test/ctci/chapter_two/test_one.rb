require 'config_test'

module CTCI::ChapterTwo
  class TestOne < Minitest::Test
    LinkedList = DataStructures::LinkedList.dup.class_exec do
      include One
    end

    def setup
      @list = LinkedList.new
      2.upto(4) { |n| @list.append(n) } # 2,3,4
    end

    def test_removes_duplicates
      1.step(5, 2) { |n| @list.insert(n, 1) }
      @list.insert(5, 1) # 2,1,3,1,4,1,1

      @list.remove_dup!
      assert_equal(4, @list.size)
      assert_equal(2, @list[0])
      assert_equal(1, @list[1])
      assert_equal(3, @list[2])
      assert_equal(4, @list[3])
    end

    def test_does_nothing_if_no_duplicates
      @list.remove_dup!
      assert_equal(3, @list.size)
      assert_equal(2, @list[0])
      assert_equal(3, @list[1])
      assert_equal(4, @list[2])
    end

    def test_does_nothing_on_empty
      list = LinkedList.new
      list.remove_dup!
      assert_equal(0, list.size)
      assert_equal(nil, list[0])
    end
  end
end
