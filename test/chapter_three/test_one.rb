require 'config_test'

module ChapterThree
  class TestOne < Minitest::Test
    def setup
      @triple_stack = One.new
    end

    def test_size
      expected = (1..3)
      expected.each do |i|
        i.times do
          @triple_stack.push(i.pred, i)
        end
      end

      expected.each do |i|
        assert_equal i, @triple_stack.size(i.pred)
      end
    end

    def test_size_when_empty
      (0..2).each { |i| assert_equal 0, @triple_stack.size(i) }
    end

    def test_size_when_mixed
      @triple_stack.push(0, 0)

      assert_equal 1, @triple_stack.size(0)
      (1..2).each { |i| assert_equal 0, @triple_stack.size(i) }
    end

    def test_push_adds_to_the_top
      (0..5).each { |i| @triple_stack.push(i % 3, i) }

      (3..5).each { |i| assert_equal i, @triple_stack.peek(i % 3) }
      (0..2).each { |i| assert_equal 2, @triple_stack.size(i) }
    end

    def test_push_many
      (0..119).each { |i| @triple_stack.push(i % 3, i) }

      (117..119).each { |i| assert_equal i, @triple_stack.peek(i % 3) }
      (0..2).each { |i| assert_equal 40, @triple_stack.size(i) }
    end

    def test_peek_returns_item_at_the_top
      (0..2).each { |i| @triple_stack.push(i, i) }
      (0..2).each { |i| assert_equal i, @triple_stack.peek(i) }
    end

    def test_peek_doesnt_remove_item
      (0..2).each { |i| @triple_stack.push(i, i) }

      (0..2).each { |i| assert_equal i, @triple_stack.peek(i) }
      (0..2).each { |i| assert_equal 1, @triple_stack.size(i) }
      (0..2).each { |i| assert_equal i, @triple_stack.peek(i) }
    end

    def test_peek_when_empty
      (0..2).each { |i| assert_nil @triple_stack.peek(i) }
    end

    def test_peek_when_mixed
      @triple_stack.push(1, 1)

      assert_nil @triple_stack.peek(0)
      assert_equal 1, @triple_stack.peek(1)
      assert_nil @triple_stack.peek(2)
    end

    def test_pop_returns_item_at_the_top
      (0..2).each { |i| @triple_stack.push(i, i) }

      (0..2).each { |i| assert_equal i, @triple_stack.pop(i) }
      (0..2).each { |i| assert_equal 0, @triple_stack.size(i) }
    end

    def test_pop_removes_item_at_the_top
      (0..8).each { |i| @triple_stack.push(i % 3, i) }

      (6..8).each { |i| assert_equal i, @triple_stack.pop(i % 3) }
      (0..2).each { |i| assert_equal 2, @triple_stack.size(i) }
      (3..5).each { |i| assert_equal i, @triple_stack.pop(i % 3) }
    end

    def test_pop_when_empty
      (0..2).each { |i| assert_nil @triple_stack.pop(i) }
      (0..2).each { |i| assert_equal 0, @triple_stack.size(i) }
    end

    def test_pop_when_mixed
      @triple_stack.push(1, 1)

      assert_nil @triple_stack.pop(0)
      assert_equal 1, @triple_stack.pop(1)
      assert_nil @triple_stack.pop(2)

      (0..2).each { |i| assert_equal 0, @triple_stack.size(i) }
    end

    def test_multiple
      @triple_stack.push(0, 1)
      assert_equal 1, @triple_stack.pop(0)
      assert_equal 0, @triple_stack.size(0)

      assert_nil @triple_stack.pop(0)
      assert_equal 0, @triple_stack.size(0)

      @triple_stack.push(0, 2)
      assert_equal 2, @triple_stack.pop(0)
      assert_equal 0, @triple_stack.size(0)
    end
  end
end
