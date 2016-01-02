require 'config_test'

module CTCI::ChapterTwo
  class TestSix < Minitest::Test
    LinkedList = DataStructures::LinkedList.dup.class_exec do
      include Six
    end

    def setup
      @list = LinkedList.new
      @loop = LinkedList.new
    end

    def test_find_loop
      1.upto(3) { |n| @list.append(n) }
      4.upto(11) { |n| @loop.append(n) }
      join(@list, @loop)
      expected = make_loop(@loop) # 1,2,3,4,5,6,7,8,9,10,11,4,5,6...

      assert_equal expected.data, @list.find_loop.data
    end

    def test_find_loop_front
      @list.append(1)
      expected = make_loop(@list) # 1,1,1...

      assert_equal expected, @list.find_loop
    end

    def test_find_loop_single
      1.upto(3) { |n| @list.append(n) }
      @loop.append(4)
      join(@list, @loop)
      expected = make_loop(@loop)

      assert_equal expected, @list.find_loop
    end

    def test_find_loop_empty
      assert_nil @list.find_loop
    end

    def test_find_loop_nonexistent
      1.upto(3) { |n| @list.append(n) }
      assert_nil @list.find_loop
    end

    def test_find_loop_nonexistent_single
      @list.append(1)
      assert_nil @list.find_loop
    end

    private

    def join(first, second)
      first_tail = first.instance_variable_get(:@tail)
      second_head = second.instance_variable_get(:@head).next
      first_tail.next = second_head
    end

    def make_loop(list)
      head = list.instance_variable_get(:@head).next
      tail = list.instance_variable_get(:@tail)
      tail.next = head
      head
    end
  end
end
