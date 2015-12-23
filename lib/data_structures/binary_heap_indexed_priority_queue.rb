module DataStructures
  class BinaryHeapIndexedPriorityQueue
    include Enumerable

    def initialize(priority = nil)
      @priority = priority || ->(a, b) { a <=> b }
      @heap = [nil]
      @elements = []
      @inverse_heap = []
    end

    def initialize_copy(source)
      super
      @priority = source.instance_variable_get(:@priority).clone
      @heap = source.instance_variable_get(:@heap).clone
      @elements = source.instance_variable_get(:@elements).clone
      @inverse_heap = source.instance_variable_get(:@inverse_heap).clone
    end

    def size
      @heap.size.pred
    end

    def insert(index, element)
      return if index < 0 || include_index?(index)

      @heap.push(index)
      @elements[index] = element
      @inverse_heap[index] = size

      up_reheapify(size)
    end

    def include_index?(index)
      !@inverse_heap[index].nil?
    end

    def include_element?(element)
      @elements.include?(element)
    end

    def empty?
      @heap[1].nil?
    end

    def element_at(index)
      return unless include_index?(index)
      @elements[index]
    end

    def change_element_at(index, element)
      return unless include_index?(index)
      @elements[index] = element
      inverse_index = @inverse_heap[index]

      up_reheapify(inverse_index)
      down_reheapify(inverse_index)
    end

    def peek_index
      @heap[1]
    end

    def peek_element
      return if empty?
      @elements[peek_index]
    end

    def pop
      return if empty?

      exchange(1, size)
      index = @heap.pop
      result = @elements[index]
      @elements[index] = @inverse_heap[index] = nil
      down_reheapify(1)

      result
    end

    def delete_element_at(index)
      return unless include_index?(index)

      inverse_index = @inverse_heap[index]
      exchange(inverse_index, size)
      @heap.pop
      @elements[index] = @inverse_heap[index] = nil

      down_reheapify(inverse_index)
    end

    def each(&block)
      cloned = clone
      enum = Enumerator.new do |y|
        y.yield([cloned.peek_index, cloned.pop]) until cloned.size.zero?
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
      case @priority.call(@elements[@heap[index]], @elements[@heap[compared_to]])
      when true, 1
        true
      when false, -1, 0
        false
      end
    end

    def exchange(from, to)
      @heap[from], @heap[to] = @heap[to], @heap[from]
      @inverse_heap[@heap[from]] = from
      @inverse_heap[@heap[to]] = to
    end
  end
end
