require 'config_test'

describe DataStructures::Stack do
  subject { DataStructures::Stack.new }

  it { subject.must_respond_to :size }
  it { subject.must_respond_to :each }
  it { subject.must_respond_to :peek }
  it { subject.must_respond_to :push }
  it { subject.must_respond_to :pop }

  let(:foo) { 'foo' }

  it 'starts out empty' do
    subject.size.must_equal(0)
  end

  describe '#push' do
    it 'adds to the stack' do
      subject.push(foo)
      subject.peek.must_equal(foo)
      subject.size.must_equal(1)
    end

    it 'adds to the top' do
      subject.push('baz')
      subject.push('bar')
      subject.push(foo)

      subject.peek.must_equal(foo)
      subject.size.must_equal(3)
    end
  end

  describe '#peek' do
    it 'returns the item at the top' do
      subject.push('bar')
      subject.push(foo)

      subject.peek.must_equal(foo)
    end

    it 'does not remove the item' do
      subject.push(foo)
      subject.peek

      subject.size.must_equal(1)
    end

    it 'returns nil if empty' do
      subject.peek.must_be_nil
    end
  end

  describe '#pop' do
    it 'returns the item at the top' do
      subject.push('bar')
      subject.push(foo)

      subject.pop.must_equal(foo)
    end

    it 'removes the item' do
      subject.push(foo)
      subject.pop

      subject.size.must_equal(0)
    end

    it 'returns nil if empty' do
      subject.pop.must_be_nil
    end

    describe 'multiple' do
      it 'returns nil every time' do
        3.times { subject.pop.must_be_nil }
      end
    end
  end

  describe '#each' do
    it 'yields each item' do
      expected = %w(foo bar baz)
      expected.reverse_each { |item| subject.push(item) }

      subject.each.must_be_kind_of(Enumerator)

      actual = []
      subject.each { |item| actual << item }
      actual.must_equal(expected)
    end
  end
end
