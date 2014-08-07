module Algorithms
  module GraphProcessing
    class BipartiteDetection

      def initialize(graph)
        @graph = graph
        execute
      end

      def bipartite?
        @bipartite
      end

      private

      def execute
        @marked = Array.new(@graph.size_vertices) { false }
        @colors = Array.new(@graph.size_vertices)
        @bipartite = true
        @marked.each_with_index do |was_visited, v|
          if !was_visited && @bipartite
            r_execute(v, true)
          end
        end
      end

      def r_execute(from, color)
        @marked[from] = true
        @colors[from] = color
        @graph.adjacent(from).each do |to|
          return unless @bipartite

          if @colors[to] == color
            @bipartite = false
          elsif !@marked[to]
            r_execute(to, !color)
          end
        end
      end

    end
  end
end
