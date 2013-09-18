module ChapterOne
  class TestThree < MiniTest::Unit::TestCase

    def test_returns_true_when_is_permutation
      s = "abc "
      t = "c ba"
      actual = Three.permutation?(s, t)

      assert_equal(true, actual)
    end

    def test_returns_false_when_not_permutation
      s = "byz  "
      t = "cba"
      actual = Three.permutation?(s, t)

      assert_equal(false, actual)
    end

    def test_returns_false_when_empty_string
      s = ""
      t = "abc"
      first_actual = Three.permutation?(s, t)
      second_actual = Three.permutation?(t, s)

      assert_equal(false, first_actual)
      assert_equal(false, second_actual)
    end

  end
end
