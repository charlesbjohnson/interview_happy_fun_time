require 'config_test'

module ChapterEight::Eight
  describe Othello do

    subject { Othello.new }

    it { subject.must_respond_to :board }
    it { subject.must_respond_to :size }
    it { subject.must_respond_to :black }
    it { subject.must_respond_to :white }
    it { subject.must_respond_to :remaining }
    it { subject.must_respond_to :place_token }

    describe '::new' do
      it 'creates a board with 8 columns and rows by default' do
        subject.board.size.must_equal 8
        subject.board.first.size.must_equal 8
        subject.size.must_equal 8
      end

      it 'starts two white and two black tokens in an X at the center' do
        black = subject.board[3][3], subject.board[4][4]
        white = subject.board[3][4], subject.board[4][3]
        black.all?(&:black?).must_equal true
        white.all?(&:white?).must_equal true

        subject.black.must_equal 2
        subject.white.must_equal 2
      end

      it 'creates tokens for each position' do
        positions = subject.board.flatten
        positions.each { |t| t.must_be_kind_of(Token) }
        positions.count { |t| t.none? }.must_equal 60
        subject.remaining.must_equal 60
      end
    end

    describe '#place_token' do
      it 'puts a token at a position on the board' do
        subject.place_token(5, 3, :black).must_equal true
        subject.board[5][3].must_be :black?

        subject.place_token(5, 4, :white).must_equal true
        subject.board[5][4].must_be :white?
      end

      describe 'flips tokens' do
        it 'horizontally' do
          subject.board[4][3].must_be :white?
          subject.place_token(5, 3, :black).must_equal true

          subject.board[4][3].must_be :black?
          subject.black.must_equal 4
          subject.white.must_equal 1
        end

        it 'vertically' do
          subject.board[3][3].must_be :black?
          subject.place_token(3, 2, :white).must_equal true

          subject.board[3][3].must_be :white?
          subject.white.must_equal 4
          subject.black.must_equal 1
        end

        it 'diagonally' do
          subject.place_token(2, 3, :white).must_equal true
          subject.board[3][3].must_be :white?

          subject.place_token(2, 2, :black)
          subject.board[3][3].must_be :black?
          subject.black.must_equal 3
          subject.white.must_equal 3
        end
      end

      describe 'placement unavailable' do
        describe 'at position specified' do
          it 'does nothing' do
            subject.place_token(5, 3, :white).must_equal false
            subject.board[5][3].must_be :none?
            subject.white.must_equal 2
          end
        end

        describe 'out of tokens' do
          before do
            subject.board.each { |c| c.each { |r| r.black! } }
            subject.send(:count_tokens)
          end

          it 'does nothing' do
            subject.place_token(0, 0, :white).must_equal false
            subject.board[0][0].must_be :black?
            subject.black.must_equal 64
            subject.remaining.must_equal 0
          end
        end
      end

      describe 'invalid' do
        it 'does nothing if position doesnt exist' do
          subject.place_token(100, -100, :black).must_equal false
          subject.remaining.must_equal 60
          subject.black.must_equal 2
          subject.white.must_equal 2
        end
      end
    end

  end

  describe Token do

    subject { Token.new(0) }
    let(:none) { subject }
    let(:black) { Token.new(-1) }
    let(:white) { Token.new(1) }

    it { Token.must_respond_to :colors }
    it { Token.must_respond_to :none }
    it { Token.must_respond_to :black }
    it { Token.must_respond_to :white }

    it { subject.must_respond_to :none? }
    it { subject.must_respond_to :black? }
    it { subject.must_respond_to :white? }
    it { subject.must_respond_to :color }
    it { subject.must_respond_to :black! }
    it { subject.must_respond_to :white! }
    it { subject.must_respond_to :flip! }

    describe 'color constructors' do
      describe '::none' do
        it { Token.none.must_equal none }
      end

      describe '::black' do
        it { Token.black.must_equal black }
      end

      describe '::white' do
        it { Token.white.must_equal white }
      end
    end

    describe 'color checking' do
      describe '#color' do
        it do
          none.color.must_equal :none
          black.color.must_equal :black
          white.color.must_equal :white
        end
      end

      describe '#none?' do
        it do
          none.must_be :none?
          black.wont_be :none?
          white.wont_be :none?
        end
      end

      describe '#black?' do
        it do
          none.wont_be :black?
          black.must_be :black?
          white.wont_be :black?
        end
      end

      describe '#white?' do
        it do
          none.wont_be :white?
          white.must_be :white?
          black.wont_be :white?
        end
      end
    end

    describe 'color changing' do
      describe '#none!' do
        it do
          none.none!.must_be :none?
          black.none!.must_be :none?
          white.none!.must_be :none?
        end
      end

      describe '#black!' do
        it do
          none.black!.must_be :black?
          black.black!.must_be :black?
          white.black!.must_be :black?
        end
      end

      describe '#white!' do
        it do
          none.white!.must_be :white?
          black.white!.must_be :white?
          white.white!.must_be :white?
        end
      end

      describe '#flip!' do
        it do
          none.flip!.must_be :none?
          white.flip!.must_be :black?
          black.flip!.must_be :white?
        end
      end
    end
  end
end
