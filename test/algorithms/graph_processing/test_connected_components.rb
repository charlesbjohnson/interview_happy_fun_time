require 'config_test'

describe Algorithms::GraphProcessing::ConnectedComponents do
  subject { Algorithms::GraphProcessing::ConnectedComponents.new(graph) }

  let(:graph) { DataStructures::UndirectedGraph.new }
  let(:edges) do
    [
      [0, 1],
      [0, 2],
      [0, 5],
      [0, 6],
      [3, 4],
      [3, 5],
      [4, 5],
      [4, 6],
      [7, 8],
      [9, 10],
      [9, 11],
      [9, 12]
    ]
  end

  before { edges.each { |from, to| graph.add_edge(from, to) } }

  it { subject.must_respond_to :connected? }
  it { subject.must_respond_to :count }
  it { subject.must_respond_to :id }

  describe '#connected?' do
    describe 'when the vertices are connected' do
      it 'returns true' do
        subject.connected?(3, 6).must_equal(true)
      end
    end

    describe 'when the vertices are not connected' do
      it 'returns false' do
        subject.connected?(2, 8).must_equal(false)
      end
    end
  end

  describe '#count' do
    it 'returns the number of component groups for the graph' do
      subject.count.must_equal(3)
    end
  end

  describe '#id' do
    it 'returns the id of the component group for the target vertex' do
      subject.id(12).must_equal(2)
    end
  end
end
