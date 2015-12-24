# had to look this up. pretty tricky but made sense
module CTCI::ChapterTwo
  module Six
    # Given a circular linked list, implement an algorithm
    # which returns the node at the beginning of the loop.
    def find_loop
      slow = @head.next
      fast = @head.next
      while fast && fast.next
        slow = slow.next
        fast = fast.next.next
        break if slow == fast
      end

      return nil unless fast && fast.next

      slow = @head.next
      while slow != fast
        slow = slow.next
        fast = fast.next
      end

      slow
    end
  end
end
