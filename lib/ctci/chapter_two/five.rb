require 'ostruct'

module CTCI::ChapterTwo
  module Five
    # You have two numbers represented by a linked list,
    # where each node contains a single digit. The digits
    # are stored in reverse order, such that the 1's digit
    # is at the head of the list. Write a funciton that adds
    # the two numbers and returns the sum as a linked list.
    # FOLLOW UP
    # Suppose the digits are stored in forward order. Repeat
    # the above problem.
    def reverse_add_digits(first, second)
      first_i = reverse_to_i(first)
      second_i = reverse_to_i(second)
      result_i = first_i + second_i
      reverse_to_list(result_i)
    end

    def add_digits(first, second)
      first_i = to_i(first)
      second_i = to_i(second)
      result_i = first_i + second_i
      to_list(result_i)
    end

    private

    def reverse_to_i(list)
      result = 0
      base = 1
      cursor = list.next

      while cursor
        result += base * cursor.data
        base *= 10
        cursor = cursor.next
      end

      result
    end

    def to_i(list)
      cursor = list.next
      return 0 unless cursor

      r_to_i(list.next, OpenStruct.new(value: 1))
    end

    def r_to_i(cursor, base)
      return cursor.data if cursor.next.nil?

      result = r_to_i(cursor.next, base)
      base.value *= 10
      cursor.data * base.value + result
    end

    def reverse_to_list(i)
      result = DataStructures::LinkedList.new
      while i > 0
        i, r = i.divmod(10)
        # shortcut for chaining off of the tail
        result.append(r)
      end

      result
    end

    def to_list(i)
      result = DataStructures::LinkedList.new
      while i > 0
        i, r = i.divmod(10)
        # shortcut for chaining off of the head
        result.insert(0, r)
      end

      result
    end
  end
end
