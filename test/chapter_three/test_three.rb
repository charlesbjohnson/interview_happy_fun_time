require 'config_test'

module ChapterThree
  class TestThree < Minitest::Test
    def setup
      @stack = Three.new(3)
    end

    def test_size
      @stack.push(0)
      assert_equal 1, @stack.size
    end

    def test_size_when_empty
      assert_equal 0, @stack.size
    end

    def test_size_when_over_capacity
      4.times { @stack.push('foo') }
      assert_equal 4, @stack.size
    end

    def test_push_adds_to_the_top
      (0..2).each { |i| @stack.push(i) }
      assert_equal 2, @stack.peek
    end

    def test_push_when_over_capacity
      (0..3).each { |i| @stack.push(i) }
      assert_equal 3, @stack.peek
    end

    def test_peek_doesnt_remove_item
      (0..2).each { |i| @stack.push(i) }

      assert_equal 3, @stack.size
      assert_equal 2, @stack.peek

      assert_equal 3, @stack.size
      assert_equal 2, @stack.peek
    end

    def test_peek_when_empty
      assert_nil @stack.peek
    end

    def test_peek_when_over_capacity
      (0..3).each { |i| @stack.push(i) }
      assert_equal 3, @stack.peek
    end

    def test_pop_removes_item
      (0..2).each { |i| @stack.push(i) }

      assert_equal 3, @stack.size
      assert_equal 2, @stack.pop

      assert_equal 2, @stack.size
      assert_equal 1, @stack.pop

      assert_equal 1, @stack.size
    end

    def test_pop_when_empty
      assert_nil @stack.pop
    end

    def test_pop_when_over_capacity
      (0..3).each { |i| @stack.push(i) }

      assert_equal 3, @stack.pop
      assert_equal 3, @stack.size

      assert_equal 2, @stack.pop
      assert_equal 2, @stack.size
    end

    def test_pop_at_returns_top_item_from_specific_stack
      (0..5).each { |i| @stack.push(i) }

      assert_equal 2, @stack.pop_at(0)
      assert_equal 5, @stack.pop_at(1)
    end

    def test_pop_at_removes_item
      (0..5).each { |i| @stack.push(i) }

      assert_equal 6, @stack.size
      assert_equal 2, @stack.pop_at(0)

      assert_equal 5, @stack.size
      assert_equal 5, @stack.pop_at(1)

      assert_equal 4, @stack.size
    end

    def test_pop_at_when_empty
      assert_nil @stack.pop_at(0)
    end

    def test_pop_at_when_over_capacity
      (0..8).each { |i| @stack.push(i) }

      assert_equal 5, @stack.pop_at(1)
      assert_equal 4, @stack.pop_at(1)
      assert_equal 3, @stack.pop_at(1)

      assert_equal 8, @stack.pop_at(1)
    end
  end
end
