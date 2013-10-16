require 'ostruct'

module ChapterTwo
  module Five

    def reverse_add_digits(first, second)
      first_i, second_i = reverse_to_i(first), reverse_to_i(second)
      result_i = first_i + second_i
      reverse_to_list(result_i)
    end

    def add_digits(first, second)
      first_i, second_i = to_i(first), to_i(second)
      result_i = first_i + second_i
      to_list(result_i)
    end

    private

    def reverse_to_i(list)
      result, base = 0, 1
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
