module DataStructures
  class Graph
    def initialize
      @table = []
    end

    def size_vertices
      @table.size
    end

    def size_edges
      @table.reduce(0) { |a, e| a + e.adjacent.size }
    end

    def get(index)
      node = @table[index]
      node && node.data
    end

    def adjacent(index)
      node = @table[index]
      return nil if node.nil?

      node.adjacent.map { |i| [i, get(i)] }
    end

    def add_vertex(data)
      @table.push(GraphNode.new(data))
    end

    def add_edge(from, to)
      node = @table[from]
      return if node.nil?

      node.adjacent.push(to) unless @table[to].nil?
    end
  end

  class GraphNode
    attr_accessor :data, :adjacent

    def initialize(d = nil)
      @data = d
      @adjacent = []
    end
  end
end
