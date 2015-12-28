module EPI::ChapterEight
  module One
    # Let L and F be singly linked lists in which each node holds a number.
    # Assume the numbers in L and F appear in ascending order within the lists.
    # The merge of L and F is a list consisting of the nodes of L and F in which
    # numbers appear in ascending order.
    #
    # Write a function that takes L and F, and returns the merge of L and F.
    # Your code should use O(1) additional storage - it should reuse the nodes
    # from the lists provided as input. The only field you can change in a node is next.
    def ascending_merge!(left, right)
      left_head = left.instance_variable_get(:@head)
      right_head = right.instance_variable_get(:@head)

      left_tail = left.instance_variable_get(:@tail)
      right_tail = right.instance_variable_get(:@tail)

      if left.size == 0
        left.instance_variable_set(:@head, right_head)
        left.instance_variable_set(:@tail, right_tail)
        return left
      end

      if right.size == 0
        right.instance_variable_set(:@head, left_head)
        right.instance_variable_set(:@tail, left_tail)
        return right
      end

      previous_cursor = left_head
      left_cursor = left_head.next
      right_cursor = right_head.next

      loop do
        if left_cursor.nil?
          previous_cursor.next = right_cursor
          break
        end

        if right_cursor.nil?
          previous_cursor.next = left_cursor
          break
        end

        if left_cursor.data <= right_cursor.data
          previous_cursor.next = left_cursor
          left_cursor = left_cursor.next
        elsif left_cursor.data > right_cursor.data
          previous_cursor.next = right_cursor
          right_cursor = right_cursor.next
        end

        previous_cursor = previous_cursor.next
      end

      previous_cursor = previous_cursor.next until previous_cursor.next.nil?

      left.instance_variable_set(:@tail, previous_cursor)
      right.instance_variable_set(:@head, left_head)
      right.instance_variable_set(:@tail, previous_cursor)

      left
    end
  end
end
