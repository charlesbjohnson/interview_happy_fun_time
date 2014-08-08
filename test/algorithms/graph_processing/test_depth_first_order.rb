require 'config_test'

describe Algorithms::GraphProcessing::DepthFirstOrder do

  subject { Algorithms::GraphProcessing::DepthFirstOrder.new(graph) }

  let(:graph) { DataStructures::UndirectedGraph.new }

  it { subject.must_respond_to :pre }
  it { subject.must_respond_to :post }

  describe 'with an undirected graph' do
    let(:edges) do
      [
        [0, 1],
        [0, 2],
        [0, 5],
        [0, 6],
        [1, 4],
        [2, 3],
        [2, 5],
        [3, 4],
        [3, 5],
        [3, 6],
        [4, 6],
        [4, 6]
      ]
    end

    before { edges.each { |from, to| graph.add_edge(from, to) } }

    describe '#pre' do
      it 'returns vertices in preorder' do
        subject.pre.must_equal([0, 1, 4, 3, 2, 5, 6])
      end
    end

    describe '#post' do
      it 'returns vertices in postorder' do
        subject.post.must_equal([5, 2, 6, 3, 4, 1, 0])
      end
    end
  end

  describe 'with a directed graph' do
    let(:graph) { DataStructures::DirectedGraph.new }
    let(:edges) do
      [
        [0, 1],
        [0, 2],
        [0, 5],
        [1, 4],
        [3, 2],
        [3, 4],
        [3, 5],
        [3, 6],
        [5, 2],
        [6, 0],
        [6, 4]
      ]
    end

    before { edges.each { |from, to| graph.add_edge(from, to) } }

    describe '#pre' do
      it 'returns vertices in preorder' do
        subject.pre.must_equal([0, 1, 4, 2, 5, 3, 6])
      end
    end

    describe '#post' do
      it 'returns vertices in postorder' do
        subject.post.must_equal([4, 1, 2, 5, 0, 6, 3])
      end
    end
  end

end
