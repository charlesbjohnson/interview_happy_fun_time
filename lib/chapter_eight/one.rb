module ChapterEight
  module One

    # Design the data structures for a generic deck of cards. Explain
    # how you would subclass the data structures to implement blackjack.
    #
    # I don't think I would go any further than this implementation.
    # A deck of cards is just that, a deck. You can't really do anything
    # more with it than take cards from it or shuffle it.
    # Cards are a similar situation. They only have suits, ranks, and some
    # sort of value, which is dependent on the game being played.
    #
    # I wouldn't subclass either class for Black Jack or any other card game
    # because it just wouldn't make sense. Cards have nothing to do with the
    # rules of the game being played. A card doesn't physically do anything
    # differently from one game to another. Instead, the game itself
    # determines the behavior or the value of the cards within the context
    # of the game. Casinos dont have special Aces specifically for games of
    # Black Jack or for games of Poker. They just have cards and decks with
    # lots of cards.
    # So if I had to design a Black Jack game, then I would first need to
    # assign values to each card before they are used. Like 10 for
    # :jack, :queen, or :king. Or a function for determining the value of a
    # collection of cards where if the collection contained an Ace it could
    # either of two values depending on how the player wanted it. And so
    # forth. Those are all responsibilities of the game's rules, however, and
    # not of the simple little cards.
    class Deck

      def initialize
        shuffle_cards
      end

      def size
        @cards.size
      end

      def draw(n = nil)
        return @cards.shift if n.nil?
        @cards.shift(n)
      end

      def reset
        shuffle_cards
      end

      private

      def shuffle_cards
        @cards = 4.times.flat_map do |suit|
          (0..12).map { |rank| Card.new(rank, suit) }
        end.shuffle
      end

    end

    class Card
      include Comparable

      attr_reader :rank, :suit, :value

      @@suits = %i[hearts spades clubs diamonds]
      @@ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]

      def initialize(r, s, v = nil)
        @rank = @@ranks[r]
        @suit = @@suits[s]
        @value = v || r
      end

      @@suits.each do |s|
        define_method :"#{s}?" do
          @suit == s
        end
      end

      def <=>(other)
        @value.<=>(other.value)
      end

      def rank_equal?(other)
        @rank == other.rank
      end

      def suit_equal?(other)
        @suit == other.suit
      end

    end

  end
end
