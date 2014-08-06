require 'config_test'

describe Algorithms::GraphProcessing::DepthFirstSearch do

  subject { Algorithms::GraphProcessing::DepthFirstSearch.new(graph, 0) }

  let(:graph) { DataStructures::UndirectedGraph.new }

  it { subject.must_respond_to :marked? }
  it { subject.must_respond_to :count }

  describe 'with an undirected graph' do
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

    describe '#marked?' do
      it 'returns true if the source is connected to the target' do
        subject.marked?(3).must_equal(true)
      end

      it 'returns false if the source is not connected to the target' do
        subject.marked?(9).must_equal(false)
      end
    end

    describe '#count' do
      it 'returns the number of vertices connected to the source' do
        subject.count.must_equal(6)
      end
    end
  end

  describe 'with a directed graph' do
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
        [6, 9],
        [7, 6],
        [7, 8],
        [8, 7],
        [8, 9],
        [9, 10],
        [9, 11],
        [10, 12],
        [11, 12],
        [12, 9]
      ]
    end

    before { edges.each { |from, to| graph.add_edge(from, to) } }

    describe '#marked?' do
      it 'returns true if the source is connected to the target' do
        subject.marked?(3).must_equal(true)
      end

      it 'returns false if the source is not connected to the target' do
        subject.marked?(9).must_equal(false)
      end
    end

    describe '#count' do
      it 'returns the number of vertices connected to the source' do
        subject.count.must_equal(5)
      end
    end
  end

end
