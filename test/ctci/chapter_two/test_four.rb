require 'config_test'

module CTCI::ChapterTwo
  class TestFour < Minitest::Test
    class DataStructures::LinkedList
      include Four
    end

    def setup
      @list = DataStructures::LinkedList.new
      (1..5).to_a.shuffle!.each { |n| @list.append(n) }
    end

    def test_partition_around_middle
      @list.partition_around!(3)
      assert only_has_values_at_indexes((0..1), (1..2))
      assert_equal 3, @list[2]
      assert only_has_values_at_indexes((3..4), (4..5))
    end

    def test_partition_around_front
      @list.partition_around!(1)
      assert_equal 1, @list[0]
      assert only_has_values_at_indexes((1..4), (2..5))
    end

    def test_partition_around_back
      @list.partition_around!(5)
      assert only_has_values_at_indexes((0..3), (1..4))
      assert_equal 5, @list[4]
    end

    def test_partition_around_duplicate
      @list.append(3)

      @list.partition_around!(3)
      assert only_has_values_at_indexes((0..1), (1..2))
      2.upto(3) { |n| assert_equal 3, @list[n] }
      assert only_has_values_at_indexes((4..5), (4..5))
    end

    def test_partition_around_grouped_duplicates
      @list = DataStructures::LinkedList.new
      [2, 1].each { |n| @list.append(n) }
      2.times { @list.append(3) }
      [4, 3, 5].each { |n| @list.append(n) }

      @list.partition_around!(3)
      expected = [1, 2, 3, 3, 3, 4, 5]
      assert_equal expected, @list.to_a
    end

    def test_partion_around_sorted
      @list = DataStructures::LinkedList.new
      expected = [1, 2, 3, 4, 5]
      expected.each { |n| @list.append(n) }

      @list.partition_around!(3)

      assert_equal 3, @list[2]
      assert only_has_values_at_indexes((3..4), (4..5))
    end

    def test_partition_around_nonexistent
      expected = @list.to_a

      @list.partition_around!(-1)
      assert_equal expected, @list.to_a
    end

    def test_partition_around_single
      @list = DataStructures::LinkedList.new
      @list.append(3)

      @list.partition_around!(3)
      assert_equal [3], @list.to_a
    end

    private

    def only_has_values_at_indexes(indexes, includes)
      includes = includes.to_a
      result = indexes.map do |n|
        actual = @list[n]
        exists = includes.include?(actual)
        includes.delete(actual)

        exists
      end

      result.all?
    end
  end
end
