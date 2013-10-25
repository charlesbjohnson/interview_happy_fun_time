require 'data_structures'

module ChapterThree
  class Two < DataStructures::Stack

    def initialize
      @head = MinNode.new
    end

    def my_min
      @head.min
    end

    def push(data)
      is_min = @head.min.nil? || data < @head.min

      new = MinNode.new(data, n: @head)
      new.min = is_min ? data : @head.min

      @head = new
    end

  end

  class MinNode < DataStructures::SingleNode
    attr_accessor :min
  end
end
