module Algorithms
  module GraphProcessing
    class UndirectedCycleDetection
      attr_reader :cycle

      def initialize(graph)
        @graph = graph
        execute
      end

      def cycle?
        !@cycle.nil?
      end

      private

      def execute
        @marked = Array.new(@graph.size_vertices) { false }
        path = nil

        @marked.each_with_index do |was_visited, v|
          unless was_visited
            path = r_execute(v, v, [v])
            break unless path.nil?
          end
        end

        @cycle = cutoff_vertices_until_cycle(path) unless path.nil?
      end

      def r_execute(from, came_from, path)
        @marked[from] = true
        @graph.adjacent(from).each do |to|
          if cycled?(to, came_from)
            return path.push(to)
          elsif !@marked[to]
            result = r_execute(to, from, path.clone.push(to))
            return result unless result.nil?
          end
        end

        nil
      end

      def cycled?(to, came_from)
        @marked[to] && to != came_from
      end

      def cutoff_vertices_until_cycle(path)
        path.drop(path.index(path.last))
      end

    end
  end
end
