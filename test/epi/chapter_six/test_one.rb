require 'config_test'

module EPI::ChapterSix
  class TestOne < Minitest::Test
    include One

    def test_partition_modifies_in_place
      a = [31, 94, 64, 5, 43, 54, 13, 89, 43, 29]
      result = partition!(a, 4)
      assert_same(a, result)
    end

    def test_partition_partitions_around_given_index
      a = [31, 94, 64, 5, 43, 54, 13, 89, 43, 29]
      result = partition!(a, 4)
      assert_equal([31, 29, 5, 13, 43, 43, 89, 54, 64, 94], result)
    end

    def test_partition_partitions_around_leftmost_index
      a = [31, 94, 64, 5, 43, 54, 13, 89, 43, 29]
      result = partition!(a, 0)
      assert_equal([29, 13, 5, 31, 54, 43, 89, 43, 64, 94], result)
    end

    def test_partition_partitions_around_rightmost_index
      a = [31, 94, 64, 5, 43, 54, 13, 89, 43, 29]
      result = partition!(a, 9)
      assert_equal([13, 5, 29, 43, 54, 64, 89, 43, 94, 31], result)
    end

    def test_partition_returns_empty_array_when_nothing_to_partition
      a = []
      result = partition!(a, -1)
      assert_equal([], result)
    end
  end
end
