require 'config_test'

describe DataStructures::BinaryHeapPriorityQueue do

  subject { DataStructures::BinaryHeapPriorityQueue.new(priority) }

  let(:priority) { ->(a, b){ a >= b } }

  it { subject.must_be_kind_of(Enumerable) }

  it { subject.must_respond_to :size }
  it { subject.must_respond_to :each }
  it { subject.must_respond_to :push }
  it { subject.must_respond_to :peek }
  it { subject.must_respond_to :pop }

  describe '#size' do
    it 'starts out empty' do
      subject.size.must_equal(0)
    end

    it 'is increased on a #push' do
      subject.push(1)
      subject.size.must_equal(1)
    end

    it 'stays the same on a #peek' do
      subject.push(1)
      subject.size.must_equal(1)

      subject.peek
      subject.size.must_equal(1)
    end

    it 'is decreased on a #pop' do
      subject.push(1)
      subject.pop
      subject.size.must_equal(0)
    end

    it 'stays the same on #each' do
      [1,2,3,4].each { |i| subject.push(i) }
      subject.each { }
      subject.size.must_equal(4)
    end
  end

  describe '#push' do
    it 'adds to the priority queue' do
      subject.push(1)
      subject.peek.must_equal(1)
    end

    describe 'when it already contains elements' do
      before { [1, 5, -3, 4, 6].each { |i| subject.push(i) } }

      it 'adds according to the priority' do
        subject.push(2)
        subject.peek.must_equal(6)
      end
    end

    describe 'with a comparable priority' do
      let(:priority) { ->(a, b){ a <=> b } }

      before { [1, 0, 1, 2, 1].each { |i| subject.push(i) } }

      it 'prioritizes the positive comparison' do
        subject.peek.must_equal(2)
      end
    end
  end

  describe '#peek' do
    before { [-1, 5, 2].each { |i| subject.push(i) } }

    it 'returns the element with the highest priority' do
      subject.peek.must_equal(5)
    end

    it 'does not remove the element from the priority queue' do
      subject.peek.must_equal(5)
      subject.peek.must_equal(5)
    end

    describe 'when empty' do
      let(:empty) { DataStructures::BinaryHeapPriorityQueue.new(priority) }

      it 'returns nil' do
        empty.peek.must_be_nil
      end
    end
  end

  describe '#pop' do
    before { [3, -1, 4, 9].each { |i| subject.push(i) } }

    it 'returns the element with the highest priority' do
      subject.pop.must_equal(9)
    end

    it 'removes the element from the priority queue' do
      subject.pop
      subject.pop.wont_equal(9)
    end

    it 'resolves the next highest priority element' do
      subject.pop.must_equal(9)
      subject.pop.must_equal(4)
      subject.pop.must_equal(3)
    end

    describe 'when empty' do
      let(:empty) { DataStructures::BinaryHeapPriorityQueue.new(priority) }

      it 'returns nil' do
        empty.pop.must_be_nil
      end
    end
  end

  describe '#each' do
    before { [8, 3, -11, 10, 1].each { |i| subject.push(i) } }

    it 'yields each element by the highest priority' do
      expected, actual = [10, 8, 3, 1, -11], []
      subject.each { |i| actual.push(i) }
      actual.must_equal(expected)
    end

    it 'does not remove any elements' do
      subject.each { }
      subject.peek.must_equal(10)
    end

    describe 'without a block' do
      it 'returns the enumerator' do
        subject.each.must_be_kind_of(Enumerator)
      end
    end
  end

end
