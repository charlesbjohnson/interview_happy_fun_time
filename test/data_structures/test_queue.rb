require 'config_test'

describe DataStructures::Queue do

  subject { DataStructures::Queue.new }

  it { subject.must_respond_to :size }
  it { subject.must_respond_to :each }
  it { subject.must_respond_to :peek }
  it { subject.must_respond_to :enqueue }
  it { subject.must_respond_to :dequeue }

  let(:foo) { 'foo' }

  it 'starts out empty' do
    subject.size.must_equal 0
  end

  describe '#enqueue' do
    it 'adds to the queue' do
      subject.enqueue(foo)
      subject.peek.must_equal foo
      subject.size.must_equal 1
    end

    it 'adds to the back' do
      subject.enqueue(foo)
      subject.enqueue('bar')
      subject.enqueue('baz')

      subject.peek.must_equal(foo)
      subject.size.must_equal 3
    end
  end

  describe '#peek' do
    it 'returns the item at the front' do
      subject.enqueue(foo)
      subject.enqueue('bar')

      subject.peek.must_equal foo
    end

    it 'does not remove the item' do
      subject.enqueue(foo)
      subject.peek

      subject.size.must_equal 1
    end

    it 'returns nil if empty' do
      subject.peek.must_be_nil
    end
  end

  describe '#dequeue' do
    it 'returns the item at the front' do
      subject.enqueue(foo)
      subject.enqueue('bar')

      subject.dequeue.must_equal foo
    end

    it 'removes the item' do
      subject.enqueue(foo)
      subject.dequeue

      subject.size.must_equal 0
    end

    it 'returns nil if empty' do
      subject.dequeue.must_be_nil
    end
  end

  describe '#each' do
    it 'yields each item' do
      expected = %w[foo bar baz]
      expected.each { |item| subject.enqueue(item) }

      subject.each.must_be_kind_of(Enumerator)

      actual = []
      subject.each { |item| actual << item }
      actual.must_equal expected
    end
  end

end
