require 'config_test'

module CTCI::ChapterNine
  class TestNine < Minitest::Test
    include Nine

    def test_returns_all_possible_queen_placements_on_chess_board
      # Best I can do. Not writing this one out by hand.
      # https://en.wikipedia.org/wiki/Eight_queens_puzzle#Counting_solutions
      assert_equal 92, queen_placements.size
    end
  end
end
