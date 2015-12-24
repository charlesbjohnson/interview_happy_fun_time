module CTCI::ChapterTwo
  module One
    # Write code to remove duplicates from an unsorted linked list.
    # FOLLOW UP
    # How would you solve this problem if a temporary buffer is not allowed?
    def remove_dup!
      dups = count_dup

      cursor = @head
      until cursor == @tail
        data = cursor.next.data
        is_a_dup = dups.key?(data)

        if is_a_dup
          times_seen = dups[data]

          if times_seen > 0
            # deleting the next node has the side effect of
            # incrementing cursor.next, repeat this iteration
            # so that we don't jump over it accidentally
            delete_next(cursor)
            next
          end

          dups[data] += 1
        end

        cursor = cursor.next
      end
    end

    private

    def count_dup
      counts = Hash.new(0)

      cursor = @head.next
      while cursor
        counts[cursor.data] += 1
        cursor = cursor.next
      end

      dups = counts.select { |_, v| v > 1 }
      dups.each_key { |k| dups[k] = 0 }
    end

    def delete_next(cursor)
      doomed = cursor.next
      cursor.next = doomed.next
      @tail = cursor if doomed == @tail
    end
  end
end
