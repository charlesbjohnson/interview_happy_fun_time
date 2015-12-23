require 'config_test'

describe Algorithms::GraphProcessing::DirectedCycleDetection do
  subject { Algorithms::GraphProcessing::DirectedCycleDetection.new(graph) }

  let(:graph) { DataStructures::DirectedGraph.new }

  it { subject.must_respond_to :cycle? }
  it { subject.must_respond_to :cycle }

  describe 'when there is a cycle' do
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
        [7, 8],
        [8, 7],
        [8, 9],
        [9, 10],
        [9, 11],
        [10, 12],
        [11, 4],
        [11, 12],
        [12, 9]
      ]
    end

    before { edges.each { |from, to| graph.add_edge(from, to) } }

    describe '#cycle?' do
      it 'returns true' do
        subject.cycle?.must_equal(true)
      end
    end

    describe '#cycle' do
      it 'returns the cycle' do
        subject.cycle.must_equal([0, 5, 4, 2, 0])
      end
    end
  end

  describe 'when there is no cycle' do
    let(:edges) do
      [
        [0, 1],
        [0, 5],
        [2, 3],
        [3, 1],
        [4, 2],
        [4, 3],
        [5, 4],
        [6, 0],
        [6, 4],
        [6, 9],
        [8, 7],
        [8, 9],
        [9, 10],
        [9, 11],
        [10, 12],
        [11, 12]
      ]
    end

    before { edges.each { |from, to| graph.add_edge(from, to) } }

    describe '#cycle?' do
      it 'returns false' do
        subject.cycle?.must_equal(false)
      end
    end

    describe '#cycle' do
      it 'returns nil' do
        subject.cycle.must_be_nil
      end
    end
  end
end
