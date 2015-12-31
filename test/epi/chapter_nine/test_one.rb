require 'config_test'

module EPI::ChapterNine
  class TestOne < Minitest::Test
    include One

    def test_min_max_stack_returns_min_max_stack
      assert_instance_of(DataStructures::MinMaxStack, min_max_stack)
    end
  end
end
