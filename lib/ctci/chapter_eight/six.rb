# A fun one, but really easy to miss bugs. Spent more time debugging
# tests than the actual implementation.
module CTCI::ChapterEight
  module Six
    # Implement a jigsaw puzzle. Design the data structures and explain
    # an algorithm to solve the puzzle. You can assume that you have
    # a fitsWith method which, when passed two puzzle pieces, returns true
    # if the two pieces belong together.
    class JigSaw
      attr_reader :board, :unplaced, :columns, :rows

      def initialize(r = 3, c = 3)
        @rows = r
        @columns = c
        @board = Array.new(@rows) { Array.new(@columns) { Piece.empty } }
        @unplaced = []

        create_pieces
        scramble_pieces
      end

      def solve
        top_left = @unplaced.find_index { |p| p.top.flat? && p.left.flat? }
        @board[0][0] = @unplaced[top_left]
        @unplaced.delete_at(top_left)

        place_pieces
      end

      private

      def create_pieces
        @rows.times do |r|
          @columns.times do |c|
            piece = Piece.that_fits_between(around(r, c))
            @board[r][c] = piece
            @unplaced.push(piece)
          end
        end
      end

      def around(r, c)
        %i(above right_of below left_of).map { |m| send(m, r, c) }
      end

      def above(r, c)
        return nil if r.pred < 0
        @board[r.pred][c].bottom
      end

      def right_of(r, c)
        return nil if c.succ >= @columns
        @board[r][c.succ].left
      end

      def below(r, c)
        return nil if r.succ >= @rows
        @board[r.succ][c].top
      end

      def left_of(r, c)
        return nil if c.pred < 0
        @board[r][c.pred].right
      end

      def scramble_pieces
        @unplaced.shuffle!
        @board = Array.new(@rows) { Array.new(@columns) { Piece.empty } }
      end

      def place_pieces
        r = c = 0
        until @unplaced.empty?
          piece = @board[r][c]

          if piece.empty?
            edges_around_piece = around(r, c)
            @unplaced.each_with_index do |p, i|
              compared_edges = p.edges.zip(edges_around_piece)
              piece_fits = compared_edges.all? { |pe, ae| pe.fits_with?(ae) }
              next unless piece_fits
              @board[r][c] = p
              @unplaced.delete_at(i)
              break
            end
          end

          r, c = first_open_edge(r, c)
        end
      end

      def first_open_edge(r, c)
        top, right, bottom, left = around(r, c)
        if top && top.none?
          return r.pred, c
        elsif right && right.none?
          return r, c.succ
        elsif bottom && bottom.none?
          return r.succ, c
        elsif left && left.none?
          return r, c.pred
        end
      end
    end

    class Piece
      attr_reader :edges

      def initialize(e)
        @edges = e
      end

      def self.empty
        new(Array.new(4) { Edge.none })
      end

      def self.that_fits_between(edges_around)
        new(edges_around.map { |e| Edge.complement(e) })
      end

      %i(top right bottom left).each_with_index do |e, i|
        define_method e do
          @edges[i]
        end
      end

      def corner?
        @edges.cycle(2).each_cons(2).any? { |h, t| h == t && h.flat? }
      end

      def empty?
        @edges.all?(&:none?)
      end

      def ==(other)
        return false unless self.class == other.class
        @edges == other.edges
      end

      alias_method :eql?, :==
    end

    class Edge
      @@types = %i(none flat inward outward)
      attr_reader :type

      def initialize(t)
        @type = @@types[t % @@types.size]
      end

      @@types.each_with_index do |t, i|
        define_method(:"#{t}?") { @type == t }
        define_singleton_method(t) { new(i) }
      end

      def self.rand_in_out
        new(rand((2..3)))
      end

      def self.complement(other = nil)
        return flat if other.nil?
        send(complement_type(other.type))
      end

      def fits_with?(other)
        return true if other.nil? && flat?
        return false if other.nil?

        return true if none? && (other.inward? || other.outward?)
        return true if inward? && other.none?
        return true if outward? && other.none?
        return true if none? && other.none?

        self.class.complement_type(@type) == other.type
      end

      def ==(other)
        return false unless self.class == other.class
        @type == other.type
      end

      alias_method :eql?, :==

      def self.complement_type(type)
        case type
        when :none
          %i(inward outward).sample
        when :flat
          :flat
        when :inward
          :outward
        when :outward
          :inward
        end
      end
    end
  end
end
