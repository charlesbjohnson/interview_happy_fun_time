require 'config_test'

module ChapterFive
  class TestFour < Minitest::Test
    include Four

    def test_mystery_function
      assert mystery(0)
      assert mystery(1)
      assert mystery(2)
      refute mystery(3)
      assert mystery(4)
      refute mystery(5)
      refute mystery(6)
      refute mystery(7)
      assert mystery(8)
    end

  end
end
