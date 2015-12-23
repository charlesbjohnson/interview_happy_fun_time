module Algorithms
  module GraphProcessing
    class TopologicalOrder
      def initialize(graph)
        @graph = graph
      end

      def acyclic?
        @acyclic ||= !Algorithms::GraphProcessing::DirectedCycleDetection.new(@graph).cycle?
      end

      def order
        return unless acyclic?
        @order ||= Algorithms::GraphProcessing::DepthFirstOrder.new(@graph).post.reverse
      end
    end
  end
end
