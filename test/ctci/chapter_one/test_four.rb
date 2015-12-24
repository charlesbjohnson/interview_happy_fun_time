require 'config_test'

module CTCI::ChapterOne
  class TestFour < Minitest::Test
    include Four

    def test_encodes_spaces
      s = 'Mr John Smith'
      actual = encode_spaces(s)

      assert_equal('Mr%20John%20Smith', actual)
    end

    def test_collapses_spaces_before_encoding
      s = 'Mr  John   Smith'
      actual = encode_spaces(s)

      assert_equal('Mr%20John%20Smith', actual)
    end

    def test_does_not_encode_spaces_at_end_of_string
      s = 'Mr  John   Smith  '
      actual = encode_spaces(s)

      assert_equal('Mr%20John%20Smith', actual)
    end

    def test_empty_string_returns_empty_string
      s = ' '
      actual = encode_spaces(s)

      assert_equal('', actual)
    end
  end
end
