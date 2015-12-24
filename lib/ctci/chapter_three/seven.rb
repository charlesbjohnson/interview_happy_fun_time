module CTCI::ChapterThree
  class Seven
    # An animal shelter holds only dogs and cats, and operates on a
    # strictly 'first in, first out' basis. People must adopt either
    # the 'oldest' (based on arrival time) of all animals at the shelter,
    # or they can select whether they would prefer a dor or a cat (and will
    # receive the oldest animal of that type). They cannot select which
    # specific animal they would like. Create the data structures to
    # maintain this system and implement operations such as enqueue,
    # dequeueAny, dequeueDog and dequeueCat. You may use the built-in
    # LinkedList data structure.
    def initialize
      @dogs = []
      @cats = []
      @order = 0
    end

    def enqueue(animal)
      @order += 1
      animal.order = @order

      add_to = animal.dog? ? @dogs : @cats
      add_to.push(animal)
    end

    def dequeue_any
      return nil if @dogs.empty? && @cats.empty?

      if @dogs.empty?
        @cats.shift
      elsif @cats.empty?
        @dogs.shift
      else
        @dogs.first.older_than?(@cats.first) ? @dogs.shift : @cats.shift
      end
    end

    def dequeue_dog
      @dogs.shift
    end

    def dequeue_cat
      @cats.shift
    end
  end

  class Animal
    attr_accessor :order, :type
    private_class_method :new

    def initialize(t)
      @type = t
    end

    def self.dog
      new(:dog)
    end

    def self.cat
      new(:cat)
    end

    def older_than?(other)
      @order < other.order
    end

    def dog?
      @type == :dog
    end

    def cat?
      @type == :cat
    end
  end
end
