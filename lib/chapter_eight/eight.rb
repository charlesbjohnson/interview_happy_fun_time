module ChapterEight
  module Eight

    # Othello is played as follows: Each Othello piece is white on one side
    # and black on the other. When a piece is surrounded by its opponents on
    # both the left and right sides, or both the top and bottom, it is said
    # to be captured and its color is flipped. On your turn, you must capture
    # at least one of your opponent's pieces. The game ends when either user
    # has no more valid moves. The win is assigned to the person with the most
    # pieces. Implement the object-oriented design for Othello.
    class Othello
      attr_reader :board, :size, :black, :white, :remaining

      def initialize
        @size = 8
        @black = @white = 0
        @board = Array.new(@size) { Array.new(@size) { Token.none } }

        start
      end

      def start
        min, max = (@size.pred / 2), (@size / 2)
        @board[min][min].black!
        @board[max][max].black!
        @board[min][max].white!
        @board[max][min].white!

        count_tokens
      end

      def place_token(r, c, color)
        return false unless valid_placement(r, c, color) && @remaining > 0

        @board[r][c].send(:"#{color}!")
        flip_tokens(r, c, color)
        count_tokens

        true
      end

      private

      def valid_placement(r, c, color)
         position_exists?(r, c) && available_move?(r, c, color)
      end

      def position_exists?(r, c)
        range = 0...@size
        range.include?(r) && range.include?(c)
      end

      def available_move?(r, c, color)
        # horizontal, vertical, both diagonals
        [[0, -1, 0, 1],
         [-1, 0, 1, 0],
         [-1, -1, 1, 1],
         [-1, 1, 1, -1]].each do |r_dec, c_dec, r_inc, c_inc|
          return true if scan_direction(r, c, r_dec, c_dec, r_inc, c_inc,
                                        color).any?
        end

        false
      end

      def token_at(r, c)
        return nil unless position_exists?(r, c)
        @board[r][c]
      end

      def flip_tokens(r, c, color)
        # horizontal, vertical, both diagonals
        to_flip = [[0, -1, 0, 1],
                   [-1, 0, 1, 0],
                   [-1, -1, 1, 1],
                   [-1, 1, 1, -1]].flat_map do |r_dec, c_dec, r_inc, c_inc|
          scan_direction(r, c, r_dec, c_dec, r_inc, c_inc, color)
        end

        to_flip.each { |row, col| token_at(row, col).flip! }
      end

      def scan_direction(r, c, r_dec, c_dec, r_inc, c_inc, stop_color)
        result, flip_so_far_dec, flip_so_far_inc = [], [], []

        r_with_dec, c_with_dec = (r + r_dec), (c + c_dec)
        dec_token = token_at(r_with_dec, c_with_dec)

        r_with_inc, c_with_inc = (r + r_inc), (c + c_inc)
        inc_token = token_at(r_with_inc, c_with_inc)

        scanning_dec = scanning_inc = true
        while scanning_dec || scanning_inc
          if scanning_dec
            scanning_dec = false if dec_token.nil?

            if dec_token && dec_token.color == stop_color
              result.concat(flip_so_far_dec)
              scanning_dec = false
            end

            flip_so_far_dec.push([r_with_dec, c_with_dec])
            r_with_dec, c_with_dec = (r_with_dec + r_dec), (c_with_dec + c_dec)
            dec_token = token_at(r_with_dec, c_with_dec)
          end

          if scanning_inc
            scanning_inc = false if inc_token.nil?

            if inc_token && inc_token.color == stop_color
              result.concat(flip_so_far_inc)
              scanning_inc = false
            end

            flip_so_far_inc.push([r_with_inc, c_with_inc])
            r_with_inc, c_with_inc = (r_with_inc + r_inc), (c_with_inc + c_inc)
            inc_token = token_at(r_with_inc, c_with_inc)
          end
        end

        result
      end

      def count_tokens
        tokens = @board.flatten
        @remaining = tokens.count { |t| t.none? }
        @black = tokens.count { |t| t.black? }
        @white = tokens.count { |t| t.white? }
      end

    end

    class Token
      @@k_to_v = {0 => :none, -1 => :black, 1 => :white}
      @@v_to_k = @@k_to_v.invert
      @@colors = @@k_to_v.values
      attr_reader :color

      def initialize(c)
        @color = @@k_to_v[c]
      end

      def self.colors
        @@colors
      end

      @@k_to_v.each do |k, v|
        self.define_singleton_method(v) { new(k) }
        define_method(:"#{v}!") { @color = v; self }
        define_method(:"#{v}?") { @color == v }
      end

      def flip!
        new_value = @@v_to_k[@color] * -1
        @color = @@k_to_v[new_value]
        self
      end

      def ==(other)
        return false unless self.class == other.class
        @color == other.color
      end

      alias_method :eql?, :==

    end

  end
end
