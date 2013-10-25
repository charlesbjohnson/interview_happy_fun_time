require 'data_structures'

module ChapterThree
  class Three

    def initialize(max)
      @max, @stacks = max, []
    end

    def size
      @stacks.reduce(0) { |a, e| a + e.size }
    end

    def peek
      @stacks.last && @stacks.last.peek
    end

    def push(data)
      last = @stacks.last

      if last.nil? || last.size >= @max
        new = DataStructures::Stack.new
        new.push(data)
        @stacks.push(new)
      elsif last.size < @max
        last.push(data)
      end
    end

    def pop
      last = @stacks.last
      return nil if last.nil?

      popped = last.pop
      if popped.nil?
        @stacks.pop
        popped = pop
      end

      popped
    end

    def pop_at(stack_number)
      stack = @stacks[stack_number]

      if stack
        popped = stack.pop
        if popped.nil?
          @stacks.delete_at(stack_number)
          popped = pop_at(stack_number)
        end

        popped
      end
    end

  end
end
