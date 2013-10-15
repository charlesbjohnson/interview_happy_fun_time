require 'config_test'

describe DataStructures::LinkedList do

  subject { DataStructures::LinkedList.new }

  it { subject.must_respond_to :size }
  it { subject.must_respond_to :[] }
  it { subject.must_respond_to :each }
  it { subject.must_respond_to :append }
  it { subject.must_respond_to :insert }
  it { subject.must_respond_to :remove }
  it { subject.must_respond_to :delete }

  it 'starts out empty' do
    subject.size.must_equal 0
  end

  describe '#append' do
    let(:foo) { 'foo' }

    it 'adds to the list' do
      subject.append(foo)
      subject[0].must_equal foo
      subject.size.must_equal 1
    end

    it 'adds to the end of the list' do
      bar, baz = 'bar', 'baz'
      subject.append(foo)
      subject.append(bar)
      subject.append(baz)

      subject[0].must_equal foo
      subject[1].must_equal bar
      subject[2].must_equal baz
      subject.size.must_equal 3
    end
  end

  describe '#insert' do
    let(:foo) { 'foo' }

    it 'adds to the list' do
      subject.insert(0, foo)
      subject[0].must_equal foo
      subject.size.must_equal 1
    end

    it 'inserts at the end of the list' do
      bar = 'bar'
      subject.insert(0, foo)
      subject.insert(1, bar)

      subject[0].must_equal foo
      subject[1].must_equal bar
    end

    it 'inserts at the beginning of the list' do
      bar = 'bar'
      subject.insert(0, foo)
      subject.insert(0, bar)

      subject[0].must_equal bar
      subject[1].must_equal foo
    end

    it 'inserts at the middle of the list' do
      bar, baz = 'bar', 'baz'
      subject.insert(0, foo)
      subject.insert(1, bar)
      subject.insert(1, baz)

      subject[0].must_equal foo
      subject[1].must_equal baz
      subject[2].must_equal bar
    end
  end

  describe '#remove' do
    let(:foo) { 'foo' }
    before { subject.append(foo) }

    it 'takes away from the list' do
      subject.remove
      subject[0].must_be_nil
      subject.size.must_equal 0
    end

    it 'returns the item taken away' do
      removed = subject.remove
      removed.must_equal foo
    end

    it 'removes from the end of the list' do
      bar = 'bar'
      subject.append(bar)
      subject.append('baz')

      subject.remove
      subject[0].must_equal foo
      subject[1].must_equal bar
      subject[2].must_be_nil
    end
  end

  describe '#delete' do
    let(:foo) { 'foo' }
    before { subject.append(foo) }

    it 'takes away from the list' do
      subject.delete(0)
      subject[0].must_be_nil
      subject.size.must_equal 0
    end

    it 'returns the item taken away' do
      deleted = subject.delete(0)
      deleted.must_equal foo
    end

    it 'deletes from the beginning of the list' do
      bar = 'bar'
      subject.append(bar)

      subject.delete(0)
      subject[0].must_equal bar
      subject[1].must_be_nil
    end

    it 'deletes from the end of the list' do
      subject.append('bar')

      subject.delete(1)
      subject[0].must_equal foo
      subject[1].must_be_nil
    end

    it 'deletes from the middle of the list' do
      baz = 'baz'
      subject.append('bar')
      subject.append(baz)

      subject.delete(1)
      subject[0].must_equal foo
      subject[1].must_equal baz
      subject[2].must_be_nil
    end
  end

  describe '#each' do
    it 'yields each item' do
      expected = %w[foo bar baz]
      expected.each { |item| subject.append(item) }

      subject.each.must_be_kind_of(Enumerator)

      actual = []
      subject.each { |item| actual << item }
      actual.must_equal expected
    end
  end

end
