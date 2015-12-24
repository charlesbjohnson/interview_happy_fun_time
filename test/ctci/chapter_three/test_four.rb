require 'config_test'

module CTCI::ChapterThree
  class TestFour < Minitest::Test
    def setup
      @hanoi = Four.new
    end

    def test_one_on_first_to_third
      @hanoi.add_tower(1)
      2.times { @hanoi.add_tower(0) }

      @hanoi.solve(0, 2, 1)

      assert_equal 0, @hanoi.tower(0)
      assert_equal 0, @hanoi.tower(1)
      assert_equal 1, @hanoi.tower(2)
    end

    def test_two_on_first_to_third
      @hanoi.add_tower(2)
      2.times { @hanoi.add_tower(0) }

      @hanoi.solve(0, 2, 1)

      assert_equal 0, @hanoi.tower(0)
      assert_equal 0, @hanoi.tower(1)
      assert_equal 2, @hanoi.tower(2)
    end

    def test_three_on_first_to_third
      @hanoi.add_tower(3)
      2.times { @hanoi.add_tower(0) }

      @hanoi.solve(0, 2, 1)

      assert_equal 0, @hanoi.tower(0)
      assert_equal 0, @hanoi.tower(1)
      assert_equal 3, @hanoi.tower(2)
    end
  end

  class TestTower < Minitest::Test
    def test_move_ring_to_empty
      @from = Tower.new(0, 1)
      @to = Tower.new(1, 0)

      @from.move_disk(@to)

      assert_nil @from.stack.peek
      assert_equal 1, @to.stack.peek
    end

    def test_move_smaller_onto_larger
      @from = Tower.new(0)
      @from.stack.push(1)

      @to = Tower.new(1)
      @to.stack.push(3)

      @from.move_disk(@to)

      assert_nil @from.stack.peek
      assert_equal 1, @to.stack.peek
    end

    def test_move_larger_onto_smaller
      @from = Tower.new(0)
      @from.stack.push(2)

      @to = Tower.new(1)
      @to.stack.push(1)

      @from.move_disk(@to)

      assert_equal 2, @from.stack.peek
      assert_equal 1, @to.stack.peek
    end
  end
end
