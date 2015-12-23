require 'config_test'

module ChapterNine
  class TestTen < Minitest::Test
    include Ten

    def test_returns_tallest_stack_of_boxes_possible
      boxes = [[1, 1, 1], [2, 5, 3], [7, 9, 15], [1, 4, 2], [2, 9, 2]]
      boxes = boxes.map { |w, h, d| Box.new(w, h, d) }

      expected = [boxes[2], boxes[1], boxes[3]]
      assert_equal expected, tallest_stack(boxes)
    end

    def test_returns_tallest_of_unstackable_boxes
      boxes = Array.new(3) { Box.new(2, 2, 2) }

      expected = [Box.new(2, 2, 2)]
      assert_equal expected, tallest_stack(boxes)
    end

    def test_returns_empty_when_empty
      assert_empty tallest_stack([])
    end
  end
end
