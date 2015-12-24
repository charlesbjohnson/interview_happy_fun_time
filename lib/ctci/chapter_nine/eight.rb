# Would not have figured this one out.
module CTCI::ChapterNine
  module Eight
    # Given an infinite number of quarters (25 cents), dimes (10 cents),
    # nickels (5 cents) and pennies (1 cent), write code to calculate the
    # number of ways of representing n cents.
    def count_cent_representations(cents)
      return 0 if cents.zero?
      r_count_cent_representations(cents, 25)
    end

    private

    def r_count_cent_representations(cents, coin)
      next_coin = 0
      case coin
      when 25
        next_coin = 10
      when 10
        next_coin = 5
      when 5
        next_coin = 1
      when 1
        return 1
      end

      ways = coin_count = 0
      until (coin_count * coin) > cents
        ways += r_count_cent_representations(cents - (coin_count * coin), next_coin)
        coin_count += 1
      end

      ways
    end
  end
end
