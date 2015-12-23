# Argh.
module ChapterNine
  module Ten
    # You have a stack of n boxes, with widths w1, heights h1, and depths d1.
    # The boxes cannot be rotated and can only be stacked on top of one another
    # if each box in the stack is strictly larger than the box above it in
    # width, height, and depth. Implement a method to build the tallest stack
    # possible, where the height of a stack is the sum of the heights of each
    # box.
    def tallest_stack(boxes)
      r_tallest_stack(boxes, nil, {})
    end

    private

    def r_tallest_stack(boxes, bottom, cache)
      cached = cache[bottom]
      return cached if cached

      max_height = 0
      max_stack = nil

      boxes.each do |box|
        next unless box.can_stack_on_top_of(bottom)
        new_stack = r_tallest_stack(boxes, box, cache)
        new_height = height(new_stack)
        if new_height > max_height
          max_height = new_height
          max_stack = new_stack
        end
      end

      max_stack = [] if max_stack.nil?
      max_stack.unshift(bottom) unless bottom.nil?
      cache[bottom] = max_stack

      max_stack.clone
    end

    def height(boxes)
      boxes.reduce(0) { |a, e| a + e.height }
    end

    class Box
      attr_reader :width, :height, :depth

      def initialize(w, h, d)
        @width = w
        @height = h
        @depth = d
      end

      def can_stack_on_top_of(other_box)
        return true if other_box.nil?

        smaller_width = @width < other_box.width
        smaller_height = @height < other_box.height
        smaller_depth = @depth < other_box.depth

        smaller_width && smaller_height && smaller_depth
      end

      def ==(other)
        return false unless self.class == other.class
        same_width = @width == other.width
        same_height = @height == other.height
        same_depth = @depth == other.depth

        same_width && same_height && same_depth
      end

      alias_method :eql?, :==

      def hash
        [@width, @height, @depth].hash
      end
    end
  end
end
