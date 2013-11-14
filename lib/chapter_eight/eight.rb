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

      def place_token(c, r, color)
        return false unless valid_placement(c, r, color) && @remaining > 0

        @board[c][r].send(:"#{color}!")
        flip_tokens(c, r, color)
        count_tokens

        true
      end

      private

      def valid_placement(c, r, color)
         position_exists?(c, r) && available_move?(c, r, color)
      end

      def position_exists?(c, r)
        range = 0...@size
        range.include?(c) && range.include?(r)
      end

      def available_move?(c, r, color)
        should_stop = proc { |token| token && token.color == color }

        %i[scan_horizontal scan_vertical
           scan_diagonal_negative_slope
           scan_diagonal_positive_slope].each do |m|
          return true if self.send(m, c, r, should_stop).any?
        end

        false
      end

      def token_at(c, r)
        return nil unless position_exists?(c, r)
        @board[c][r]
      end

      def flip_tokens(c, r, color)
        should_stop = proc { |token| token && token.color == color }
        flip_h = scan_horizontal(c, r, should_stop)
        flip_v = scan_vertical(c, r, should_stop)
        flip_diagonal_n = scan_diagonal_negative_slope(c, r, should_stop)
        flip_diagonal_p = scan_diagonal_positive_slope(c, r, should_stop)
        to_flip = flip_h + flip_v + flip_diagonal_n + flip_diagonal_p

        to_flip.each { |col, row| token_at(col, row).flip! }
      end

      def scan_horizontal(c, r, should_stop)
        result, flip_so_far_left, flip_so_far_right = [], [], []
        left_i, right_i = -1, 1

        left, right = (c + left_i), (c + right_i)
        scanning_left = scanning_right = true
        left_token, right_token = token_at(left, r), token_at(right, r)
        loop do
          scanning_left = false if left_token.nil?
          scanning_right = false if right_token.nil?

          break unless scanning_left && scanning_right

          if scanning_left && should_stop.call(left_token)
            result.concat(flip_so_far_left)
            scanning_left = false
          end

          if scanning_right && should_stop.call(right_token)
            result.concat(flip_so_far_right)
            scanning_right = false
          end

          flip_so_far_left.push([left, r])
          flip_so_far_right.push([right, r])

          left += left_i
          right += right_i

          left_token, right_token = token_at(left, r), token_at(right, r)
        end

        result
      end

      def scan_vertical(c, r, should_stop)
        result, flip_so_far_up, flip_so_far_down = [], [], []
        up_i, down_i = -1, 1

        up, down = (r + up_i), (r + down_i)
        scanning_up = scanning_down = true
        up_token, down_token = token_at(c, up), token_at(c, down)
        loop do
          scanning_up = false if up_token.nil?
          scanning_down = false if down_token.nil?

          break unless scanning_up && scanning_down

          if scanning_up && should_stop.call(up_token)
            result.concat(flip_so_far_up)
            scanning_up = false
          end

          if scanning_down && should_stop.call(down_token)
            result.concat(flip_so_far_down)
            scanning_down = false
          end

          flip_so_far_up.push([c, up])
          flip_so_far_down.push([c, down])

          up += up_i
          down += down_i
          up_token, down_token = token_at(c, up), token_at(c, down)
        end

        result
      end

      def scan_diagonal_negative_slope(c, r, should_stop)
        result, flip_so_far_left_up, flip_so_far_right_down = [], [], []
        left_i = up_i = -1
        right_i = down_i = 1

        lu_c, lu_r = (c + left_i), (r + up_i)
        rd_c, rd_r = (c + right_i), (r + down_i)
        scanning_lu = scanning_rd = true
        lu_token, rd_token = token_at(lu_c, lu_r), token_at(rd_c, rd_r)
        loop do
          scanning_lu = false if lu_token.nil?
          scanning_rd = false if rd_token.nil?

          break unless scanning_lu && scanning_rd

          if scanning_lu && should_stop.call(lu_token)
            result.concat(flip_so_far_left_up)
            scanning_lu = false
          end

          if scanning_rd && should_stop.call(rd_token)
            result.concat(flip_so_far_right_down)
            scanning_rd = false
          end

          flip_so_far_left_up.push([lu_c, lu_r])
          flip_so_far_right_down.push([rd_c, rd_r])

          lu_c += left_i
          lu_r += up_i
          rd_c += right_i
          rd_r += down_i

          lu_token, rd_token = token_at(lu_c, lu_r), token_at(rd_c, rd_r)
        end

        result
      end

      def scan_diagonal_positive_slope(c, r, should_stop)
        result, flip_so_far_left_down, flip_so_far_right_up = [], [], []
        left_i = up_i = -1
        right_i = down_i = 1

        ld_c, ld_r = (c + left_i), (r + down_i)
        ru_c, ru_r = (c + right_i), (r + up_i)
        scanning_ld, scanning_ru = true
        ld_token, ru_token = token_at(ld_c, ld_r), token_at(ru_c, ru_r)
        loop do
          scanning_ld = false if ld_token.nil?
          scanning_ru = false if ru_token.nil?

          break unless scanning_ld && scanning_ru

          if scanning_ld && should_stop.call(ld_token)
            result.concat(flip_so_far_left_down)
            scanning_ld = false
          end

          if scanning_ru && should_stop.call(ru_token)
            result.concat(flip_so_far_right_up)
            scanning_ru = false
          end

          flip_so_far_left_down.push([ld_c, ld_r])
          flip_so_far_right_up.push([ru_c, ru_r])

          ld_c += left_i
          ld_r += down_i
          ru_c += right_i
          ru_r += up_i

          ld_token, ru_token = token_at(ld_c, ld_r), token_at(ru_c, ru_r)
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
