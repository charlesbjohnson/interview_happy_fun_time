require_relative 'single_node'

module DataStructures
  class Stack
    include Enumerable

    def initialize
      @head = SingleNode.new
    end

    def size
      self.to_a.size
    end

    def each(&block)
      enum = Enumerator.new do |y|
        cursor = @head
        while cursor.next
          y << cursor.data
          cursor = cursor.next
        end
      end

      block_given? ? enum.each(&block) : enum
    end

    def peek
      @head.data
    end

    def push(data)
      new = SingleNode.new(data, n: @head)
      @head = new
    end

    def pop
      return nil if @head.next.nil?

      doomed = @head
      @head = doomed.next
      doomed.next = nil

      doomed.data
    end

  end
end
