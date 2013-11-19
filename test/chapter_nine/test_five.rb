require 'config_test'

module ChapterNine
  class TestFive < Minitest::Test
    include Five

    def test_permutations_returns_permutations_of_string
      assert_equal %w[a], permutations('a')
      assert_equal %w[ab ba].sort, permutations('ab').sort
      assert_equal %w[abc acb bac bca cab cba].sort, permutations('abc').sort
    end

    def test_permutations_returns_empty_string_when_empty_string
      assert_equal [''], permutations('')
    end

  end
end
