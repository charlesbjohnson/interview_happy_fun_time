module Algorithms
  module GraphProcessing
    class BreadthFirstPaths
      def initialize(graph, source)
        @graph = graph
        @source = source
        @marked = Array.new(graph.size_vertices) { false }
        @arrive_at_through = Array.new(graph.size_vertices) { 0 }
        execute(source)
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

      def execute(from)
        vertices_to_visit = [from]
        until vertices_to_visit.empty?
          to = vertices_to_visit.shift
          @marked[to] = true
          new_vertices = @graph.adjacent(to)
                         .reject { |v| @marked[v] }
                         .each { |v| @arrive_at_through[v] = to }
          vertices_to_visit.concat(new_vertices)
        end
      end
    end
  end
end
