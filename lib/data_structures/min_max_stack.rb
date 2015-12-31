require_relative 'stack'
require_relative 'single_node'

module DataStructures
  class MinMaxStack < Stack
    def initialize
      @head = MinMaxSingleNode.new
    end

    def push(data)
      min = data
      max = data

      unless @head.data.nil?
        return nil if @head.data.<=>(data).nil?

        min = [@head.min, data].min
        max = [@head.max, data].max
      end

      @head = MinMaxSingleNode.new(data, n: @head, min: min, max: max)
      data
    end

    def min
      @head.min
    end

    def max
      @head.max
    end
  end

  class MinMaxSingleNode
    extend Forwardable

    def_delegators :@node, :data, :data=, :next, :next=
    attr_accessor :min, :max

    def initialize(d = nil, n: nil, min: nil, max: nil)
      @node = SingleNode.new(d, n: n)
      @min = min
      @max = max
    end
  end
end
