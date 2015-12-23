module Algorithms
  module GraphProcessing
    class DepthFirstPaths
      def initialize(graph, source)
        @graph = graph
        @source = source
        @marked = Array.new(graph.size_vertices) { false }
        @arrive_at_through = Array.new(graph.size_vertices) { 0 }
        r_execute(source)
      end

      def path_to?(target)
        @marked[target]
      end

      def path_to(target)
        return unless path_to?(target)

        path = [target]
        cursor = target
        until cursor == @source
          cursor = @arrive_at_through[cursor]
          path.unshift(cursor)
        end

        path
      end

      private

      def r_execute(from)
        @marked[from] = true
        @graph.adjacent(from).reject { |v| @marked[v] }.each do |to|
          @arrive_at_through[to] = from
          r_execute(to)
        end
      end
    end
  end
end
