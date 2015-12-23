require 'config_test'

describe Algorithms::GraphProcessing::TopologicalOrder do
  subject { Algorithms::GraphProcessing::TopologicalOrder.new(graph) }

  let(:graph) { DataStructures::DirectedGraph.new }

  it { subject.must_respond_to :acyclic? }
  it { subject.must_respond_to :order }

  describe 'when the graph is acyclic' do
    let(:edges) do
      [
        [0, 1],
        [0, 5],
        [0, 6],
        [2, 0],
        [2, 3],
        [3, 5],
        [5, 4],
        [6, 4],
        [6, 9],
        [7, 6],
        [8, 7],
        [9, 10],
        [9, 11],
        [9, 12],
        [11, 12]
      ]
    end

    before { edges.each { |from, to| graph.add_edge(from, to) } }

    describe '#acyclic?' do
      it 'returns true' do
        subject.acyclic?.must_equal(true)
      end
    end

    describe '#order' do
      it 'returns a topologically ordered path' do
        subject.order.must_equal([8, 7, 2, 3, 0, 6, 9, 11, 12, 10, 5, 4, 1])
      end
    end
  end

  describe 'when the graph is cyclic' do
    let(:edges) do
      [
        [0, 1],
        [0, 5],
        [0, 6],
        [2, 0],
        [2, 3],
        [3, 5],
        [4, 2],
        [5, 4],
        [6, 4],
        [6, 9],
        [7, 6],
        [8, 7],
        [9, 10],
        [9, 11],
        [9, 12],
        [11, 12]
      ]
    end

    before { edges.each { |from, to| graph.add_edge(from, to) } }

    describe '#acyclic?' do
      it 'returns false' do
        subject.acyclic?.must_equal(false)
      end
    end

    describe '#order' do
      it 'returns nil' do
        subject.order.must_be_nil
      end
    end
  end
end
