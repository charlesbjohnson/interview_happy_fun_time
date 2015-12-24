# Intuitive but surprisingly hard to get update_ranks right.
module CTCI::ChapterEleven
  module Eight
    # Imagine you are reading in a stream of integers. Periodically, you wish
    # to be able to look up the rank of a number x (the number of values less
    # than or equal to x). Implement the data structures and algorithms to
    # support these operations. That is, implement the method track(int x),
    # which is called when each number is generated, and the method
    # getRankOfNumber(int x), which returns the number of values less than
    # or equal to x (not including x itself).
    class Ranker
      def initialize
        @root = nil
      end

      def track(n)
        @root = r_track(n, @root)
        @update_needed = true

        self
      end

      def rank_for(n)
        return 0 if @root.nil?

        if @update_needed
          r_update_ranks(@root, 0)
          @update_needed = false
        end

        r_rank_for(n, @root, 0)
      end

      private

      def r_track(n, cursor)
        return Node.new(n, 0) if cursor.nil?

        if n <= cursor.number
          cursor.left = r_track(n, cursor.left)
        elsif n > cursor.number
          cursor.right = r_track(n, cursor.right)
        end

        cursor
      end

      def r_update_ranks(cursor, rank)
        return -1 if cursor.nil?

        left = r_update_ranks(cursor.left, rank)
        cursor.rank = left < 0 ? left.succ + rank : left.succ

        right = r_update_ranks(cursor.right, cursor.rank.succ)
        right < 0 ? cursor.rank : right
      end

      def r_rank_for(n, cursor, last)
        return last if cursor.nil?

        if n < cursor.number
          r_rank_for(n, cursor.left, last)
        elsif n > cursor.number
          r_rank_for(n, cursor.right, cursor.rank.succ)
        else
          cursor.rank
        end
      end
    end

    class Node
      attr_accessor :number, :rank, :left, :right

      def initialize(n, r)
        @number = n
        @rank = r
      end
    end
  end
end
