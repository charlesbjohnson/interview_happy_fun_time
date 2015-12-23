require 'config_test'

module ChapterEleven
  class TestTwo < Minitest::Test
    include Two

    def test_returns_array_sorted_so_that_anagrams_of_words_are_grouped
      a = %w(write rots rwiet sort string other rsitng)
      expected = %w(write rwiet rots sort string rsitng other)
      assert_equal expected, group_anagrams(a)
    end

    def test_returns_array_when_no_words_are_anagrams_of_one_another
      a = %w(write sort string other)
      assert_equal a, group_anagrams(a)
    end

    def test_returns_empty_on_empty
      assert_empty group_anagrams([])
    end
  end
end
