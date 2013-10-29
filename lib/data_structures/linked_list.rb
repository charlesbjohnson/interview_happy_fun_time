require_relative 'single_node'

module DataStructures
  class LinkedList
    include Enumerable

    def initialize
      @head = SingleNode.new
      @tail = @head
    end

    def size
      self.to_a.size
    end

    def [](index)
      cursor = @head.next
      index.times { cursor = cursor.next }
      cursor.data if cursor
    end

    def each(&block)
      enum = Enumerator.new do |y|
        cursor = @head.next
        while cursor
          y << cursor.data
          cursor = cursor.next
        end
      end

      block_given? ? enum.each(&block) : enum
    end

    def append(data)
      @tail.next = SingleNode.new
      @tail = @tail.next
      @tail.data = data
    end

    def insert(index, data)
      if index == size
        self.append(data)
        return
      end

      cursor, i = @head, 0
      while cursor && i < index
        cursor = cursor.next
        i += 1
      end

      new = SingleNode.new(data, n: cursor.next)
      cursor.next = new
    end

    def remove
      cursor = @head
      until cursor.next == @tail
        cursor = cursor.next
      end

      result = @tail.data
      @tail = cursor
      @tail.next = nil

      result
    end

    def delete(index)
      cursor = @head
      index.times { cursor = cursor.next }
      doomed = cursor.next
      cursor.next = doomed.next
      doomed.next = nil

      doomed.data
    end

    def index(of)
      result, index = nil, 0
      cursor = @head.next
      while cursor
        if cursor.data == of
          result = index
          break
        end

        cursor = cursor.next
        index += 1
      end

      result
    end

  end
end
