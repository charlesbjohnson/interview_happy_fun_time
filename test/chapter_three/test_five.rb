require 'config_test'

module ChapterThree
  class TestFive < Minitest::Test
    def setup
      @queue = Five.new
    end

    def test_size
      @queue.enqueue(0)
      assert_equal 1, @queue.size
    end

    def test_size_when_empty
      assert_equal 0, @queue.size
    end

    def test_enqueue_adds_to_back
      (0..2).each { |i| @queue.enqueue(i) }
      assert_equal 0, @queue.peek
    end

    def test_peek_doesnt_remove_item
      (0..2).each { |i| @queue.enqueue(i) }

      assert_equal 3, @queue.size
      assert_equal 0, @queue.peek

      assert_equal 3, @queue.size
      assert_equal 0, @queue.peek
    end

    def test_peek_when_empty
      assert_nil @queue.peek
    end

    def test_dequeue_removes_item
      (0..2).each { |i| @queue.enqueue(i) }

      assert_equal 3, @queue.size
      assert_equal 0, @queue.dequeue

      assert_equal 2, @queue.size
      assert_equal 1, @queue.dequeue
    end

    def test_dequeue_when_empty
      assert_nil @queue.dequeue
    end
  end
end
