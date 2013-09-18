module ChapterOne
  class TestThree < MiniTest::Unit::TestCase
    include Three

    def test_returns_true_when_is_permutation
      s = 'abc '
      t = 'c ba'
      actual = permutation?(s, t)

      assert_equal(true, actual)
    end

    def test_returns_false_when_not_permutation
      s = 'byz  '
      t = 'cba'
      actual = permutation?(s, t)

      assert_equal(false, actual)
    end

    def test_returns_false_when_empty_string
      s = ''
      t = 'abc'
      first_actual = permutation?(s, t)
      second_actual = permutation?(t, s)

      assert_equal(false, first_actual)
      assert_equal(false, second_actual)
    end

  end
end
