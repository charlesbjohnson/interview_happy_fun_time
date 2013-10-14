module DataStructures
  class LinkedList

    def initialize
      @size = 0
      @head = Node.new
      @tail = @head
    end

    def size
      @size
    end

    def [](index)
      cursor = @head.next
      index.times { cursor = cursor.next }
      cursor.data if cursor
    end

    def append(data)
      @tail.next = Node.new
      @tail = @tail.next
      @tail.data = data
      @size += 1
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

      new = Node.new(data, n: cursor.next)
      cursor.next = new
      @size += 1
    end

    def remove
      cursor = @head
      until cursor.next == @tail
        cursor = cursor.next
      end

      result = @tail.data
      @tail = cursor
      @tail.next = nil
      @size -= 1

      result
    end

    def delete(index)
      cursor = @head
      index.times { cursor = cursor.next }
      doomed = cursor.next
      cursor.next = doomed.next
      doomed.next = nil
      @size -= 1

      doomed.data
    end

  end

  class Node
    attr_accessor :data, :next

    def initialize(d = nil, n: nil)
      @data = d
      @next = n
    end

  end
end
