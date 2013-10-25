module ChapterThree
  module Six

    def sort_ascending(stack)
      result = DataStructures::Stack.new

      until stack.size.zero?
        popped = stack.pop

        if in_sorted_position?(popped, result)
          result.push(popped)
        else
          stack.push(result.pop) until in_sorted_position?(popped, result)
          result.push(popped)
        end
      end

      result
    end

    private

    def in_sorted_position?(item, to)
      to.size.zero? || item > to.peek
    end

  end
end
