module DataStructures
  class DirectedGraph

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
      return false unless [from, to].all? { |i| i.kind_of?(Numeric) }
      return false if [from, to].any? { |i| i < 0 }

      from_vertex = @table[from] ||= []
      from_vertex.push(to)

      @edge_length += 1
      true
    end

    def adjacent(target)
      return unless target.kind_of?(Numeric) && target >= 0
      @table[target].to_a.clone
    end

    def reverse
      reversed = DirectedGraph.new
      size_vertices.times do |to|
        adjacent(to).each do |from|
          reversed.add_edge(from, to)
        end
      end

      reversed
    end

  end
end
