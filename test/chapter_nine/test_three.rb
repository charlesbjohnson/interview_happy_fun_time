require 'config_test'

module ChapterNine
  class TestThree < Minitest::Test
    include Three

    def test_returns_magic_index_if_exists_odd_size
      assert_equal 0, magic_index([0, 2, 3, 4, 5])
      assert_equal 2, magic_index([-5, -2, 2, 4, 8])
      assert_equal 4, magic_index([-5, -2, 1, 2, 4])
    end

    def test_returns_magic_index_if_exists_even_size
      assert_equal 0, magic_index([0, 3, 7, 23, 25, 34])
      assert_equal 2, magic_index([-95, -4, 2, 7, 56, 150])
      assert_equal 3, magic_index([-95, -4, 0, 3, 56, 150])
      assert_equal 5, magic_index([-5, -3, 0, 1, 3, 5])
    end

    def test_returns_magic_index_if_exists_duplicates_odd_size
      assert_equal 0, magic_index([0, 0, 3, 4, 8, 8, 25])
      assert_equal 2, magic_index([-5, -2, 2, 2, 11, 11, 56])
      assert_equal 6, magic_index([-2, -2, 1, 2, 2, 6, 6])
    end

    def test_returns_magic_index_if_exists_duplicates_even_size
      assert_equal 0, magic_index([0, 0, 1, 6, 6, 11, 25, 25])
      assert_equal 3, magic_index([-6, -6, 1, 3, 3, 9, 10, 10])
      assert_equal 4, magic_index([-8, 3, 3, 4, 4, 6, 9, 9])
      assert_equal 7, magic_index([3, 3, 5, 6, 7, 7, 7, 7])
    end

    def test_returns_nil_if_magic_index_doesnt_exist_odd_size
      assert_nil magic_index([1, 2, 3, 4, 5])
    end

    def test_returns_nil_if_magic_index_doesnt_exist_even_size
      assert_nil magic_index([1, 2, 3, 4, 5, 6])
    end

    def test_returns_nil_if_magic_index_doesnt_exist_duplicates_odd_size
      assert_nil magic_index([-5, -5, 1, 1, 2, 2, 43])
    end

    def test_returns_nil_if_magic_index_doesnt_exist_duplicates_even_size
      assert_nil magic_index([-5, -5, 1, 1, 2, 2, 3, 9])
    end

  end
end
