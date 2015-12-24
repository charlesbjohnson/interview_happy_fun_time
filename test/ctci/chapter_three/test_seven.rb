require 'config_test'

module CTCI::ChapterThree
  class TestSeven < Minitest::Test
    def setup
      @animal_queue = Seven.new
    end

    def test_dequeue_any
      2.times do
        @animal_queue.enqueue(Animal.dog)
        @animal_queue.enqueue(Animal.cat)
      end

      dequeued = @animal_queue.dequeue_any

      assert dequeued.dog?
      assert_equal 1, dequeued.order
    end

    def test_dequeue_any_when_only_dog
      @animal_queue.enqueue(Animal.dog)
      assert @animal_queue.dequeue_any.dog?
    end

    def test_dequeue_any_when_only_cat
      @animal_queue.enqueue(Animal.cat)
      assert @animal_queue.dequeue_any.cat?
    end

    def test_dequeue_any_when_empty
      assert_nil @animal_queue.dequeue_any
    end

    def test_dequeue_dog
      @animal_queue.enqueue(Animal.cat)
      5.times { @animal_queue.enqueue(Animal.dog) }

      dequeued = @animal_queue.dequeue_dog

      assert dequeued.dog?
      assert_equal 2, dequeued.order
    end

    def test_dequeue_dog_when_only_cat
      @animal_queue.enqueue(Animal.cat)
      assert_nil @animal_queue.dequeue_dog
    end

    def test_dequeue_cat
      @animal_queue.enqueue(Animal.dog)
      5.times { @animal_queue.enqueue(Animal.cat) }

      dequeued = @animal_queue.dequeue_cat

      assert dequeued.cat?
      assert_equal 2, dequeued.order
    end

    def test_dequeue_cat_when_only_dog
      @animal_queue.enqueue(Animal.dog)
      assert_nil @animal_queue.dequeue_cat
    end
  end
end
