require 'config_test'

module ChapterThree
  class TestSix < Minitest::Test
    include Six

    def setup
      @stack = DataStructures::Stack.new
    end

    def test_sort_ascending
      expected = (1..5).to_a.reverse
      expected.shuffle.each { |i| @stack.push(i) }

      assert_equal expected, sort_ascending(@stack).to_a
    end

    def test_sort_ascending_when_empty
      assert_equal [], sort_ascending(@stack).to_a
    end

    def test_sort_ascending_when_sorted
      expected = (1..5).to_a.reverse
      expected.reverse.each { |i| @stack.push(i) }

      assert_equal expected, sort_ascending(@stack).to_a
    end

    def test_sort_ascending_when_reverse_sorted
      expected = (1..5).to_a.reverse
      expected.each { |i| @stack.push(i) }

      assert_equal expected, sort_ascending(@stack).to_a
    end

  end
end
