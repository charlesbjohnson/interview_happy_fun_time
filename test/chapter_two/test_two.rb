require 'config_test'

module ChapterTwo
  class TestTwo < Minitest::Test
    class DataStructures::LinkedList
      include Two
    end

    def setup
      @list = DataStructures::LinkedList.new
    end

    def test_from_last
      3.times { |n| @list.append(n) }

      assert_equal(2, @list.from_last(0))
      assert_equal(1, @list.from_last(1))
      assert_equal(0, @list.from_last(2))
    end

    def test_from_last_on_empty
      assert_equal(nil, @list.from_last(0))
    end

    def test_from_last_on_nonexistent
      assert_equal(nil, @list.from_last(3))
      assert_equal(nil, @list.from_last(-3))
    end
  end
end
