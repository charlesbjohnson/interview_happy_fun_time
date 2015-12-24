# Kind of cheated since I'm taking advantage of Ruby's Array
# and not the Java kind that the book is aiming for
module CTCI::ChapterThree
  class One
    # Describe how you could use a single array to implement
    # three stacks.
    def initialize
      @elements = []
      @pointers = [0, 0, 0]
    end

    def size(stack_number)
      to = @pointers[stack_number]
      from = stack_number.zero? ? 0 : @pointers[stack_number.pred]
      to - from
    end

    def peek(stack_number)
      return nil if empty?(stack_number)

      at = @pointers[stack_number].pred
      @elements[at]
    end

    def push(stack_number, data)
      at = @pointers[stack_number]
      @elements.insert(at, data)
      increment_pointers(stack_number)
    end

    def pop(stack_number)
      return nil if empty?(stack_number)

      at = @pointers[stack_number].pred
      popped = @elements.delete_at(at)
      decrement_pointers(stack_number)

      popped
    end

    private

    def empty?(stack_number)
      at = @pointers[stack_number]

      if stack_number.zero?
        at.zero?
      else
        at == @pointers[stack_number.pred]
      end
    end

    def increment_pointers(stack_number)
      while stack_number < @pointers.size
        @pointers[stack_number] += 1
        stack_number += 1
      end
    end

    def decrement_pointers(stack_number)
      while stack_number < @pointers.size
        @pointers[stack_number] -= 1
        stack_number += 1
      end
    end
  end
end
