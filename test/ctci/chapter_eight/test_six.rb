require 'config_test'

module CTCI::ChapterEight
  module Six
    describe JigSaw do
      subject { JigSaw.new }

      it { subject.must_respond_to :board }
      it { subject.must_respond_to :unplaced }
      it { subject.must_respond_to :columns }
      it { subject.must_respond_to :rows }
      it { subject.must_respond_to :solve }

      describe '::new' do
        it 'creates a 3x3 board by default' do
          subject.unplaced.size.must_equal 9
          subject.board.size.must_equal 3
          subject.board.first.size.must_equal 3
        end

        it 'creates pieces for each position in the puzzle' do
          subject.unplaced.each { |p| p.must_be_kind_of(Piece) }
          subject.unplaced.count(&:corner?).must_equal 4
          subject.unplaced.count { |p| p.top.flat? }.must_equal 3
          subject.unplaced.count { |p| p.right.flat? }.must_equal 3
          subject.unplaced.count { |p| p.bottom.flat? }.must_equal 3
          subject.unplaced.count { |p| p.left.flat? }.must_equal 3
          subject.unplaced.count { |p| p.edges.all?(&:flat?) }.must_equal 0
          subject.unplaced.count { |p| p.edges.none?(&:flat?) }.must_equal 1
        end
      end

      describe '#solve' do
        it 'fills the board so that each piece fits with those around it' do
          subject.solve

          subject.unplaced.must_be_empty

          all_fit = true
          subject.board.each_with_index do |r, ri|
            r.each_with_index do |c, ci|
              above_end = ri.pred < 0
              right_end = ci.succ >= subject.columns
              below_end = ri.succ >= subject.rows
              left_end = ci.pred < 0

              piece = c
              above = above_end ? nil : subject.board[ri.pred][ci].bottom
              right = right_end ? nil : subject.board[ri][ci.succ].left
              below = below_end ? nil : subject.board[ri.succ][ci].top
              left = left_end ? nil : subject.board[ri][ci.pred].right

              above_fits = piece.top.fits_with?(above)
              right_fits = piece.right.fits_with?(right)
              bottom_fits = piece.bottom.fits_with?(below)
              left_fits = piece.left.fits_with?(left)

              all_fit = [above_fits, right_fits, bottom_fits, left_fits].all?
              break unless all_fit
            end
            break unless all_fit
          end

          all_fit.must_equal true
        end
      end
    end

    describe Piece do
      # edges for a top left corner piece
      let(:edges) { [1, 2, 3, 1].map { |e| Edge.new(e) } }
      subject { Piece.new(edges) }

      it { Piece.must_respond_to :empty }
      it { Piece.must_respond_to :that_fits_between }

      it { subject.must_respond_to :edges }
      it { subject.must_respond_to :top }
      it { subject.must_respond_to :right }
      it { subject.must_respond_to :bottom }
      it { subject.must_respond_to :left }
      it { subject.must_respond_to :corner? }
      it { subject.must_respond_to :empty? }

      describe 'piece constructors' do
        describe '::empty' do
          it 'creates an empty piece that has no edges, a null Piece object' do
            Piece.empty.edges.all?(&:none?).must_equal true
          end
        end

        describe '::that_fits_between' do
          it 'creates a piece that fits between the given edges' do
            edges_around = [Edge.none, nil, Edge.inward, Edge.outward]
            piece = Piece.that_fits_between(edges_around)
            top = piece.top.type
            (top == :inward || top == :outward).must_equal true
            piece.right.must_be :flat?
            piece.bottom.must_be :outward?
            piece.left.must_be :inward?
          end
        end
      end

      describe 'edges' do
        describe '#edges' do
          it 'returns edges from the top going clockwise' do
            subject.edges.must_equal edges
          end
        end

        describe '#top' do
          it { subject.top.must_equal edges[0] }
        end

        describe '#right' do
          it { subject.right.must_equal edges[1] }
        end

        describe '#bottom' do
          it { subject.bottom.must_equal edges[2] }
        end

        describe '#left' do
          it { subject.left.must_equal edges[3] }
        end
      end

      describe 'piece edge checking' do
        describe '#corner?' do
          it 'returns true if two consecutive edges are both flat' do
            # start at top left, going counter clockwise
            subject.must_be :corner?
            Piece.new(edges.rotate).must_be :corner?
            Piece.new(edges.rotate(2)).must_be :corner?
            Piece.new(edges.rotate(3)).must_be :corner?
          end

          it 'returns false if not a corner piece' do
            flat_top_bottom = [1, 2, 1, 3].map { |e| Edge.new(e) }
            Piece.new(flat_top_bottom).wont_be :corner?

            flat_left_right = [2, 1, 3, 1].map { |e| Edge.new(e) }
            Piece.new(flat_left_right).wont_be :corner?

            none_flat = [2, 3, 3, 2].map { |e| Edge.new(e) }
            Piece.new(none_flat).wont_be :corner?

            Piece.empty.wont_be :corner?
          end
        end

        describe '#empty?' do
          it do
            Piece.empty.must_be :empty?
            subject.wont_be :empty?
          end
        end
      end
    end

    describe Edge do
      subject { Edge.new(0) }
      let(:none) { subject }
      let(:flat) { Edge.new(1) }
      let(:inward) { Edge.new(2) }
      let(:outward) { Edge.new(3) }

      it { Edge.must_respond_to :none }
      it { Edge.must_respond_to :flat }
      it { Edge.must_respond_to :inward }
      it { Edge.must_respond_to :outward }
      it { Edge.must_respond_to :rand_in_out }
      it { Edge.must_respond_to :complement }

      it { subject.must_respond_to :type }
      it { subject.must_respond_to :fits_with? }
      it { subject.must_respond_to :flat? }
      it { subject.must_respond_to :inward? }
      it { subject.must_respond_to :outward? }

      describe 'edge constructors' do
        describe '::none' do
          it { Edge.none.type.must_equal :none }
        end

        describe '::flat' do
          it { Edge.flat.type.must_equal :flat }
        end

        describe '::rand_in_out' do
          it 'returns either an inward or outward edge randomly' do
            r = 10.times.map { Edge.rand_in_out }
            r.all? { |e| e.type == :inward }.must_equal false
            r.all? { |e| e.type == :outward }.must_equal false
            r.all? { |e| e.type == :flat }.must_equal false
            r.all? { |e| e.type == :inward || e.type == :outward }.must_equal true
          end
        end

        describe '::complement' do
          it 'returns an edge depending on the type of edge given' do
            none_complement = Edge.complement(none).type
            is_inward = none_complement == :inward
            is_outward = none_complement == :outward
            (is_inward || is_outward).must_equal true

            Edge.complement(flat).type.must_equal :flat
            Edge.complement(inward).type.must_equal :outward
            Edge.complement(outward).type.must_equal :inward
          end

          it 'returns a flat edge if no edge or nil given' do
            Edge.complement.type.must_equal :flat
            Edge.complement(nil).type.must_equal :flat
          end
        end
      end

      describe '#fits_with?' do
        it do
          none.must_be :fits_with?, none.clone
          none.must_be :fits_with?, inward
          none.must_be :fits_with?, outward
          none.wont_be :fits_with?, flat
          none.wont_be :fits_with?, nil
        end

        it do
          flat.wont_be :fits_with?, none
          flat.wont_be :fits_with?, inward
          flat.wont_be :fits_with?, outward
          flat.must_be :fits_with?, flat.clone
          flat.must_be :fits_with?, nil
        end

        it do
          inward.must_be :fits_with?, none
          inward.wont_be :fits_with?, inward.clone
          inward.must_be :fits_with?, outward
          inward.wont_be :fits_with?, flat
          inward.wont_be :fits_with?, nil
        end

        it do
          outward.must_be :fits_with?, none
          outward.must_be :fits_with?, inward
          outward.wont_be :fits_with?, outward.clone
          outward.wont_be :fits_with?, flat
          outward.wont_be :fits_with?, nil
        end
      end

      describe 'edge checking' do
        describe '#none?' do
          it do
            none.must_be :none?
            flat.wont_be :none?
            inward.wont_be :none?
            outward.wont_be :none?
          end
        end

        describe '#flat?' do
          it do
            none.wont_be :flat?
            flat.must_be :flat?
            inward.wont_be :flat?
            outward.wont_be :flat?
          end
        end

        describe '#inward?' do
          it do
            none.wont_be :inward?
            flat.wont_be :inward?
            inward.must_be :inward?
            outward.wont_be :inward?
          end
        end

        describe '#outward?' do
          it do
            none.wont_be :outward?
            flat.wont_be :outward?
            outward.must_be :outward?
            inward.wont_be :outward?
          end
        end
      end
    end
  end
end
