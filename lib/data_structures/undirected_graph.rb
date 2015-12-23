module DataStructures
  class UndirectedGraph
    def initialize
      @table = []
      @edge_length = 0
    end

    def size_vertices
      @table.length
    end

    def size_edges
      @edge_length
    end

    def add_edge(from, to)
      return false unless [from, to].all? { |i| i.is_a?(Numeric) }
      return false if [from, to].any? { |i| i < 0 }

      from_vertex = @table[from] ||= []
      to_vertex = @table[to] ||= []
      from_vertex.push(to)
      to_vertex.push(from)

      @edge_length += 1
      true
    end

    def adjacent(target)
      return unless target.is_a?(Numeric) && target >= 0
      @table[target].to_a.clone
    end
  end
end
