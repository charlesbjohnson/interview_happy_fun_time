require 'config_test'

describe DataStructures::Graph do

  subject { DataStructures::Graph.new }

  it { subject.must_respond_to :size_vertices }
  it { subject.must_respond_to :size_edges }
  it { subject.must_respond_to :get }
  it { subject.must_respond_to :adjacent }
  it { subject.must_respond_to :add_vertex }
  it { subject.must_respond_to :add_edge }

  let(:foo) { 'foo' }

  it 'starts out with no vertices and no edges' do
    subject.size_vertices.must_equal 0
    subject.size_edges.must_equal 0
  end

  describe '#get' do
    it 'returns the data for a vertex index' do
      subject.add_vertex(foo)
      subject.get(0).must_equal foo
    end

    it 'returns nil for nonexistent vertex' do
      subject.get(0).must_be_nil
    end
  end

  describe '#adjacent' do
    it 'returns nil for nonexistent vertex' do
      subject.adjacent(0).must_be_nil
    end

    it 'returns the vertices pointed to by a given vertex' do
      subject.add_vertex(foo)
      subject.add_vertex('bar')
      subject.add_vertex('baz')
      subject.add_edge(0, 1)
      subject.add_edge(1, 2)
      subject.add_edge(2, 0)

      subject.adjacent(0).must_equal [[1, 'bar']]
      subject.adjacent(1).must_equal [[2, 'baz']]
      subject.adjacent(2).must_equal [[0, foo]]
    end
  end

  describe '#add_vertex' do
    it 'creates a vertex in the graph' do
      subject.add_vertex(foo)

      subject.get(0).must_equal foo
      subject.size_vertices.must_equal 1
      subject.adjacent(0).must_equal []
    end

    describe 'with invalid data' do
      it 'doesnt create a vertex on nil data' do
        subject.add_vertex(nil)
        subject.size_vertices.must_equal 0
      end
    end
  end

  describe '#add_edge' do
    it 'creates an edge in the graph between two vertices' do
      subject.add_vertex('bar')
      subject.add_vertex(foo)
      subject.add_edge(0, 1)

      subject.size_edges.must_equal 1
      subject.adjacent(0).must_equal [[1, foo]]
    end

    describe 'with invalid vertices' do
      it 'doesnt create an edge on nil vertices' do
        subject.add_vertex(foo)
        subject.add_edge(0, nil)

        subject.size_edges.must_equal 0
        subject.adjacent(0).must_equal []
      end

      it 'doesnt create an edge on nonexistent vertices' do
        subject.add_vertex(foo)
        subject.add_edge(0, 1)

        subject.size_edges.must_equal 0
        subject.adjacent(0).must_equal []
      end
    end
  end

end
