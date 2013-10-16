# had to look this up. pretty tricky but made sense
module ChapterTwo
  module Six

    def find_loop
      slow, fast = @head.next, @head.next
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
