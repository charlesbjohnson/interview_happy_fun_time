module Algorithms
  module GraphProcessing
    class ConnectedComponents
      attr_reader :count

      def initialize(graph)
        @graph = graph
        execute
      end

      def connected?(from, to)
        @components[from] == @components[to]
      end

      def id(target)
        @components[target]
      end

      private

      def execute
        @marked = Array.new(@graph.size_vertices) { false }
        @components = Array.new(@graph.size_vertices)
        @count = 0

        @marked.each_with_index do |was_visited, v|
          unless was_visited
            r_execute(v)
            @count += 1
          end
        end
      end

      def r_execute(from)
        @marked[from] = true
        @components[from] = @count
        @graph.adjacent(from).reject { |v| @marked[v] }.each do |to|
          r_execute(to)
        end
      end
    end
  end
end
