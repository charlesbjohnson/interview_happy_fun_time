require 'data_structures'

module CTCI::ChapterThree
  class Three
    # Imagine a literal stack of plates. If the stack gets
    # too high, it might topple. Therefore, in real life, we
    # would likely start a new stack when the previous stack
    # exceeds some threshold. Implement a data structure
    # SetOfStacks that mimics this. SetOfStacks should be
    # composed of several stacks and should create a new stack
    # once the previous one exceeds capacity. SetOfStacks.push()
    # and SetOfStacks.pop() should behave identically to a single stack
    # (that is, pop() should return the same values as it would if
    # there were just a single stack).
    # FOLLOW UP
    # Implement a function popAt(int index) which performs a pop
    # operation on a specific sub-stack.
    def initialize(max)
      @max = max
      @stacks = []
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

      return unless stack

      popped = stack.pop
      return popped unless popped.nil?

      @stacks.delete_at(stack_number)
      pop_at(stack_number)
    end
  end
end
