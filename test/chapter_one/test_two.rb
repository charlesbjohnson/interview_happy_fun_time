module ChapterOne
  class TestTwo < MiniTest::Unit::TestCase
    include Two

    def test_reverses_a_string
      s = 'Hello World!'
      expected = '!dlroW olleH'
      actual = reverse(s)

      assert_equal(expected, actual)
    end

    def test_returns_empty_string_when_given_empty_string
      s = ''
      expected = ''
      actual = reverse(s)

      assert_equal(expected, actual)
    end

  end
end
