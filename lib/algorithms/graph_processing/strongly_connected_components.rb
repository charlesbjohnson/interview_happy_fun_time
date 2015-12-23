module Algorithms
  module GraphProcessing
    class StronglyConnectedComponents
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

        reversed = @graph.reverse
        post = Algorithms::GraphProcessing::DepthFirstOrder.new(reversed).post

        post.reverse_each do |v|
          unless @marked[v]
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
