# A fun one, but really easy to miss bugs. Spent more time debugging
# tests than the actual implementation.
module ChapterEight
  module Six

    # Implement a jigsaw puzzle. Design the data structures and explain
    # an algorithm to solve the puzzle. You can assume that you have
    # a fitsWith method which, when passed two puzzle pieces, returns true
    # if the two pieces belong together.
    class JigSaw
      attr_reader :board, :unplaced, :columns, :rows

      def initialize(c = 3, r = 3)
        @columns, @rows = c, r
        @board = Array.new(@columns) { Array.new(@rows) }
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
        @columns.times do |c|
          @rows.times do |r|
            a = around(c, r, -1)
            cmp = a.map { |e| e == -1 ? Edge.rand_in_out : Edge.complement(e) }
            piece = Piece.new(cmp)

            @board[c][r] = piece
            @unplaced.push(piece)
          end
        end
      end

      def around(c, r, empty = nil)
        %i[above right_of below left_of].map { |m| send(m, c, r, empty) }
      end

      def above(c, r, empty = nil)
        return nil if r.pred < 0
        piece = @board[c][r.pred]
        piece.nil? ? empty : piece.bottom
      end

      def right_of(c, r, empty = nil)
        return nil if c.succ >= @columns
        piece = @board[c.succ][r]
        piece.nil? ? empty : piece.left
      end

      def below(c, r, empty = nil)
        return nil if r.succ >= @rows
        piece = @board[c][r.succ]
        piece.nil? ? empty : piece.top
      end

      def left_of(c, r, empty = nil)
        return nil if c.pred < 0
        piece = @board[c.pred][r]
        piece.nil? ? empty : piece.right
      end

      def scramble_pieces
        @unplaced.shuffle!
        @board = Array.new(@columns) { Array.new(@rows) }
      end

      def place_pieces
        c = r = 0
        until @unplaced.empty?
          piece = @board[c][r]

          if piece.nil?
            edges_around_piece = around(c, r, -1)
            @unplaced.each_with_index do |p, i|
              compared_edges = p.edges.zip(edges_around_piece)

              open_flat = proc { |g| g.include?(-1) && g.include?(Edge.flat) }
              next if compared_edges.any?(&open_flat)

              compared_edges.reject! { |g| g.include?(-1) }
              fitting = compared_edges.all? { |pe, ae| pe.fits_with?(ae) }
              if fitting
                @board[c][r] = p
                @unplaced.delete_at(i)
                break
              end
            end
          end

          c, r = first_open_edge(c, r)
        end
      end

      def first_open_edge(c, r)
        top, right, bottom, left = around(c, r, -1)
        if top == -1
          return c, r.pred
        elsif right == -1
          return c.succ, r
        elsif bottom == -1
          return c, r.succ
        elsif left == -1
          return c.pred, r
        end
      end

    end

    class Piece
      attr_reader :edges

      def initialize(e)
        @edges = e
      end

      %i[top right bottom left].each_with_index do |e, i|
        define_method e do
          @edges[i]
        end
      end

      def corner?
        @edges.cycle(2).each_cons(2).any? { |h,t| h == t && h.flat? }
      end

      def ==(other)
        return false unless self.class == other.class
        @edges == other.edges
      end

      alias_method :eql?, :==

    end

    class Edge
      @@types = %i[flat inward outward]
      attr_reader :type

      def initialize(t)
        @type = @@types[t % @@types.size]
      end

      def fits_with?(other)
        return true if other.nil? && flat?
        return false if other.nil?
        self.class.complement_type(@type) == other.type
      end

      def ==(other)
        return false unless self.class == other.class
        @type == other.type
      end

      alias_method :eql?, :==

      def self.flat
        new(0)
      end

      def self.rand_in_out
        new(rand((1..2)))
      end

      def self.complement(other = nil)
        return flat if other.nil?

        c = complement_type(other.type)
        new(@@types.index(c))
      end

      @@types.each do |t|
        define_method :"#{t}?" do
          @type == t
        end
      end

      private

      def self.complement_type(type)
        case type
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
