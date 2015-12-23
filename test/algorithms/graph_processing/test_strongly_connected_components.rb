require 'config_test'

describe Algorithms::GraphProcessing::StronglyConnectedComponents do
  subject { Algorithms::GraphProcessing::StronglyConnectedComponents.new(graph) }

  let(:graph) { DataStructures::DirectedGraph.new }
  let(:edges) do
    [
      [0, 1],
      [0, 5],
      [2, 0],
      [2, 3],
      [3, 2],
      [3, 5],
      [4, 2],
      [4, 3],
      [5, 4],
      [6, 0],
      [6, 4],
      [6, 8],
      [6, 9],
      [7, 6],
      [7, 9],
      [8, 6],
      [9, 10],
      [9, 11],
      [10, 12],
      [11, 4],
      [11, 12],
      [12, 9]
    ]
  end

  before { edges.each { |from, to| graph.add_edge(from, to) } }

  it { subject.must_respond_to :connected? }
  it { subject.must_respond_to :count }
  it { subject.must_respond_to :id }

  describe '#connected?' do
    describe 'when the vertices are connected' do
      it 'returns true' do
        subject.connected?(0, 4).must_equal(true)
      end
    end

    describe 'when the vertices are not connected' do
      it 'returns false' do
        subject.connected?(3, 6).must_equal(false)
      end
    end
  end

  describe '#count' do
    it 'returns the number of component groups for the graph' do
      subject.count.must_equal(5)
    end
  end

  describe '#id' do
    it 'returns the id of the component group for the target vertex' do
      subject.id(7).must_equal(4)
    end
  end
end
