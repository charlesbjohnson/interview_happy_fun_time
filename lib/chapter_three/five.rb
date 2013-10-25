module ChapterThree
  class Five

    def initialize
      @enqueue = DataStructures::Stack.new
      @dequeue = DataStructures::Stack.new
    end

    def size
      @enqueue.size + @dequeue.size
    end

    def peek
      dump_enqueue

      @dequeue.peek
    end

    def enqueue(data)
      @enqueue.push(data)
    end

    def dequeue
      dump_enqueue

      @dequeue.pop
    end

    private

    def dump_enqueue
      if @dequeue.size.zero?
        while @enqueue.size > 0
          @dequeue.push(@enqueue.pop)
        end
      end
    end

  end
end
