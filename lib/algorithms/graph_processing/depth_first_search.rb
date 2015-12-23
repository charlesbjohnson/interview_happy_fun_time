module Algorithms
  module GraphProcessing
    class DepthFirstSearch
      attr_reader :count

      def initialize(graph, source)
        @graph = graph
        @marked = Array.new(graph.size_vertices) { false }
        @count = -1
        r_execute(source)
      end

      def marked?(target)
        @marked[target]
      end

      private

      def r_execute(from)
        @marked[from] = true
        @count += 1
        @graph.adjacent(from).each do |to|
          r_execute(to) unless @marked[to]
        end
      end
    end
  end
end
