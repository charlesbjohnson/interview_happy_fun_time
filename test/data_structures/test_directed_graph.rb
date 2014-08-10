require 'config_test'

describe DataStructures::DirectedGraph do

  subject { DataStructures::DirectedGraph.new }

  it { subject.must_respond_to :size_vertices }
  it { subject.must_respond_to :size_edges }
  it { subject.must_respond_to :add_edge }
  it { subject.must_respond_to :adjacent }
  it { subject.must_respond_to :reverse }

  it 'starts out empty' do
    subject.size_vertices.must_equal(0)
    subject.size_edges.must_equal(0)
  end

  describe '#add_edge' do
    it 'creates an edge from the first vertex' do
      subject.add_edge(0, 1)
      subject.adjacent(0).must_include(1)
      subject.adjacent(1).wont_include(0)
    end

    it 'increments the edges size' do
      subject.add_edge(0, 1)
      subject.size_edges.must_equal(1)
      subject.add_edge(0, 2)
      subject.size_edges.must_equal(2)
    end

    it { subject.add_edge(0, 1).must_equal(true) }

    describe 'with invalid vertices' do
      it 'does nothing' do
        subject.add_edge(-1, 0)
        subject.add_edge('not an integer', 0)
        subject.size_edges.must_equal(0)
        subject.adjacent(0).must_be_empty
      end

      it { subject.add_edge(-1, 0).must_equal(false) }
    end
  end

  describe '#adjacent' do
    before do
      subject.add_edge(0, 1)
      subject.add_edge(0, 2)
      subject.add_edge(1, 4)
      subject.add_edge(3, 1)
    end

    it 'returns all of the vertices adjacent to the target' do
      subject.adjacent(0).must_equal([1, 2])
      subject.adjacent(1).must_equal([4])
      subject.adjacent(2).must_equal([])
      subject.adjacent(3).must_equal([1])
      subject.adjacent(4).must_equal([])
    end

    it 'preserves the the adjacency list' do
      subject.adjacent(0).push('not a vertex')
      subject.adjacent(0).must_equal([1, 2])
    end

    describe 'with invalid vertex' do
      it 'returns nil' do
        subject.adjacent(-1).must_be_nil
        subject.adjacent('not a vertex').must_be_nil
      end
    end
  end

  describe '#reverse' do
    before do
      subject.add_edge(0, 1)
      subject.add_edge(0, 2)
      subject.add_edge(1, 4)
      subject.add_edge(3, 1)
    end

    it 'returns a graph with all the edges reversed' do
      reversed = subject.reverse
      reversed.adjacent(0).must_equal([])
      reversed.adjacent(1).must_equal([0, 3])
      reversed.adjacent(2).must_equal([0])
      reversed.adjacent(3).must_equal([])
      reversed.adjacent(4).must_equal([1])
    end
  end

end
