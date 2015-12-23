module DataStructures
  class BinaryHeapPriorityQueue
    include Enumerable

    def initialize(priority = nil)
      @priority = priority || ->(a, b) { a <=> b }
      @heap = [nil]
    end

    def initialize_copy(source)
      super
      @priority = source.instance_variable_get(:@priority).clone
      @heap = source.instance_variable_get(:@heap).clone
    end

    def size
      @heap.size.pred
    end

    def push(element)
      @heap.push(element)
      up_reheapify(size)
    end

    def peek
      @heap[1]
    end

    def pop
      return if @heap.empty?

      exchange(1, size)
      result = @heap.pop
      down_reheapify(1)

      result
    end

    def each(&block)
      cloned = clone
      enum = Enumerator.new do |y|
        y.yield(cloned.pop) until cloned.size.zero?
      end

      block_given? ? enum.each(&block) : enum
    end

    private

    def up_reheapify(index)
      while index > 1 && higher?(index, (index / 2))
        exchange(index, (index / 2))
        index /= 2
      end
    end

    def down_reheapify(index)
      until (index * 2) > size
        to = index * 2

        to += 1 if to < size && higher?(to.succ, to)
        break if higher?(index, to)

        exchange(index, to)
        index = to
      end
    end

    def higher?(index, compared_to)
      case @priority.call(@heap[index], @heap[compared_to])
      when true, 1
        true
      when false, -1, 0
        false
      end
    end

    def exchange(from, to)
      @heap[from], @heap[to] = @heap[to], @heap[from]
    end
  end
end
