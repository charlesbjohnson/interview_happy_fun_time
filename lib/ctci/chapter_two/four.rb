# is the book solution wrong for this one?
module CTCI::ChapterTwo
  module Four
    # Write code to partition a linked list around a value x,
    # such that all nodes less than x come before all nodes
    # greater than or equal to x.
    def partition_around!(value)
      cursor = @head
      cursor = cursor.next while cursor.next && cursor.next.data != value

      pivot = cursor.next
      return unless pivot

      # pull out the pivot from the rest of the list
      cursor.next = pivot.next
      pivot.next = nil

      # partition the rest of the list around the pivot
      list = @head.next
      @head.next = pivot
      @tail = pivot
      partition(pivot, list, value)
    end

    private

    def partition(pivot, list, value)
      cursor = list
      while cursor
        list = cursor.next
        if cursor.data < value
          cursor.next = @head.next
          @head.next = cursor
        elsif cursor.data == value
          cursor.next = pivot.next
          pivot.next = cursor
          @tail = pivot.next if pivot == @tail
        else
          cursor.next = @tail.next
          @tail.next = cursor
          @tail = cursor
        end

        cursor = list
      end
    end
  end
end
