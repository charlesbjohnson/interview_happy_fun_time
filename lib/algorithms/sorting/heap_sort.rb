module Algorithms
  module Sorting
    module HeapSort
      def sort(a)
        sort!(a.clone)
      end

      def sort!(a)
        heapify(a)
        a
      end

      private

      def heapify(a)
        return a if a.size <= 1

        setup_heap(a)
        teardown_heap(a)
      end

      def setup_heap(a)
        last_root_i = (a.size / 2)
        trunk_i = 1
        last_root_i.downto(trunk_i) { |i| down_reheapify(i, a, a.size) }
      end

      def down_reheapify(i, a, size)
        until (i * 2) > size
          to = i * 2

          to += 1 if to < size && get(to.succ, a) > get(to, a)
          break if get(i, a) > get(to, a)

          exchange(i, to, a)
          i = to
        end
      end

      # need to treat array operations as though they are 1-indexed
      # to compensate for arrays actually being 0-indexed
      def get(i, a)
        a[i.pred]
      end

      def exchange(from, to, a)
        tmp = get(from, a)
        set(from, get(to, a), a)
        set(to, tmp, a)
      end

      def set(i, e, a)
        a[i.pred] = e
      end

      def teardown_heap(a)
        a.size.downto(1) { |i| pop(a, i) }
      end

      def pop(a, size)
        exchange(1, size, a)
        down_reheapify(1, a, size.pred)
      end
    end
  end
end
