require 'config_test'

module ChapterEleven
  class TestEight < Minitest::Test
    include Eight

    def setup
      @ranker = Ranker.new
    end

    def test_returns_amount_of_numbers_less_than_number
      numbers = (0..10).to_a.shuffle
      numbers.each { |i| @ranker.track(i) }
      numbers.each { |i| assert_equal i, @ranker.rank_for(i) }
    end

    def test_returns_amount_of_numbers_less_than_number_with_duplicates
      @ranker.track(5)
      3.times { @ranker.track(3) }
      @ranker.track(4)
      @ranker.track(7)
      @ranker.track(6)

      assert_equal 2, @ranker.rank_for(3)
      assert_equal 3, @ranker.rank_for(4)
      assert_equal 4, @ranker.rank_for(5)
      assert_equal 5, @ranker.rank_for(6)
      assert_equal 6, @ranker.rank_for(7)
    end

    def test_returns_zero_if_no_numbers_less_than_number
      (4..10).to_a.shuffle.each { |i| @ranker.track(i) }
      assert_equal 0, @ranker.rank_for(1)
      assert_equal 0, @ranker.rank_for(2)
      assert_equal 0, @ranker.rank_for(3)
    end

    def test_returns_zero_if_empty
      assert_equal 0, @ranker.rank_for(3)
    end
  end
end
