require 'ostruct'

module CTCI::ChapterTwo
  module Seven
    # Implement a function to check if a linked list is a
    # palindrome.
    def palindrome?
      return true unless @head.next

      r_palindrome?(OpenStruct.new(left: @head.next), @head.next)
    end

    def r_palindrome?(container, right)
      return right.data == container.left.data unless right.next

      result = r_palindrome?(container, right.next)
      if result
        container.left = container.left.next
        result = right.data == container.left.data
      end

      result
    end
  end
end
