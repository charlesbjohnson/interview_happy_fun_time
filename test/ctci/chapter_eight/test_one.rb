require 'config_test'

module CTCI::ChapterEight
  module One
    describe Deck do
      subject { Deck.new }

      it { subject.must_respond_to :size }
      it { subject.must_respond_to :draw }

      it 'starts out with 52 cards' do
        subject.size.must_equal(52)
      end

      it 'is shuffled' do
        other = Deck.new
        subject.draw(7).wont_equal(other.draw(7))
      end

      describe '#draw' do
        it 'reduces the size by the number of cards drawn' do
          subject.draw(3)
          subject.size.must_equal(49)
        end

        it 'returns as many cards drawn' do
          cards = subject.draw(3)
          cards.all? { |c| c.must_be_kind_of(Card) }
        end

        describe 'when out of cards' do
          before { subject.draw(52) }

          it 'returns nil' do
            subject.draw.must_be_nil
            subject.size.must_equal(0)
          end
        end
      end
    end

    describe Card do
      subject { Card.new(3, 0) }

      it { subject.must_respond_to :rank }
      it { subject.must_respond_to :rank_equal? }
      it { subject.must_respond_to :<=> }
      it { subject.must_respond_to :< }
      it { subject.must_respond_to :<= }
      it { subject.must_respond_to :== }
      it { subject.must_respond_to :>= }
      it { subject.must_respond_to :> }
      it { subject.must_respond_to :suit }
      it { subject.must_respond_to :suit_equal? }
      it { subject.must_respond_to :value }

      describe 'equality' do
        describe 'equality compares rank by default' do
          it do
            other = Card.new(3, 1)
            subject.must_equal(other)
            subject.must_be :>=, other
            other.must_be :<=, other

            other = Card.new(1, 1)
            subject.must_be :>, other
            other.must_be :<, subject
          end
        end

        describe 'equality compares value if given' do
          it do
            subject = Card.new(3, 0, 50)
            other = Card.new(3, 0, 50)
            subject.must_equal(other)
            subject.must_be :>=, other
            other.must_be :<=, other

            other = Card.new(3, 0, 40)
            subject.must_be :>, other
            other.must_be :<, subject
          end
        end
      end

      describe '#rank_equal?' do
        it 'is true if ranks are equal' do
          other = Card.new(3, 0, 110)
          subject.must_be :suit_equal?, other
        end
      end

      describe '#suit_equal?' do
        it 'is true if suits are equal' do
          other = Card.new(5, 0)
          subject.must_be :suit_equal?, other
        end
      end
    end
  end
end
