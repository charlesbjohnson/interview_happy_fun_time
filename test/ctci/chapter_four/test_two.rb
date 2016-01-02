require 'config_test'

module CTCI::ChapterFour
  class TestTwo < Minitest::Test
    Graph = DataStructures::Graph.dup.class_exec do
      include Two
    end

    def setup
      @graph = Graph.new
    end

    def test_returns_true_if_connected
      4.times { |i| @graph.add_vertex(i.to_s) }
      @graph.add_edge(0, 1)
      @graph.add_edge(0, 3)
      @graph.add_edge(1, 2)
      @graph.add_edge(2, 0)
      @graph.add_edge(2, 3)
      @graph.add_edge(3, 0)

      assert @graph.connected?(1, 3)
    end

    def test_returns_false_if_not_connected
      4.times { |i| @graph.add_vertex(i.to_s) }
      @graph.add_edge(0, 1)
      @graph.add_edge(0, 3)
      @graph.add_edge(1, 2)
      @graph.add_edge(2, 0)
      @graph.add_edge(2, 3)

      refute @graph.connected?(3, 1)
    end

    def test_returns_false_on_nonexistent_vertices
      refute @graph.connected?(0, 1)
    end
  end
end
