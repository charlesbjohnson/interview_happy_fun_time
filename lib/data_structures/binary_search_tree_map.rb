module DataStructures
  class BinarySearchTreeMap
    include Enumerable

    def initialize
      @root = nil
    end

    def size
      r_size(@root)
    end

    def each(order = nil, &block)
      items = []

      case order
      when :pre
        r_each_preorder(@root, items)
      when :post
        r_each_postorder(@root, items)
      else
        r_each_inorder(@root, items)
      end

      enum = items.to_enum
      block_given? ? enum.each(&block) : enum
    end

    def get(key)
      cursor = @root
      result = nil
      until cursor.nil?
        if key < cursor.key
          cursor = cursor.left
        elsif key > cursor.key
          cursor = cursor.right
        else
          result = cursor.value
          break
        end
      end

      result
    end

    def min
      return nil if @root.nil?

      min = r_min(@root)
      [min.key, min.value]
    end

    def max
      return nil if @root.nil?

      max = r_max(@root)
      [max.key, max.value]
    end

    def put(key, value)
      @root = r_put(@root, key, value)
    end

    def delete_min
      return if @root.nil?
      @root = r_delete_min(@root)
    end

    def delete_max
      return if @root.nil?
      @root = r_delete_max(@root)
    end

    def delete(key)
      @root = r_delete(@root, key)
    end

    private

    def r_size(cursor)
      return 0 if cursor.nil?
      cursor.count
    end

    def r_each_inorder(cursor, items)
      return if cursor.nil?

      r_each_inorder(cursor.left, items)
      items.push([cursor.key, cursor.value])
      r_each_inorder(cursor.right, items)
    end

    def r_each_preorder(cursor, items)
      return if cursor.nil?

      items.push([cursor.key, cursor.value])
      r_each_preorder(cursor.left, items)
      r_each_preorder(cursor.right, items)
    end

    def r_each_postorder(cursor, items)
      return if cursor.nil?

      r_each_postorder(cursor.left, items)
      r_each_postorder(cursor.right, items)
      items.push([cursor.key, cursor.value])
    end

    def r_put(cursor, key, value)
      return TreeNode.new(key, value, c: 1) if cursor.nil?

      if key < cursor.key
        cursor.left = r_put(cursor.left, key, value)
      elsif key > cursor.key
        cursor.right = r_put(cursor.right, key, value)
      else
        cursor.value = value
      end

      cursor.count = 1 + r_size(cursor.left) + r_size(cursor.right)
      cursor
    end

    def r_min(cursor)
      return cursor if cursor.left.nil?
      r_min(cursor.left)
    end

    def r_max(cursor)
      return cursor if cursor.right.nil?
      r_max(cursor.right)
    end

    def r_delete_min(cursor)
      return cursor.right if cursor.left.nil?

      cursor.left = r_delete_min(cursor.left)

      cursor.count = 1 + r_size(cursor.left) + r_size(cursor.right)
      cursor
    end

    def r_delete_max(cursor)
      return cursor.left if cursor.right.nil?

      cursor.right = r_delete_max(cursor.right)

      cursor.count = 1 + r_size(cursor.left) + r_size(cursor.right)
      cursor
    end

    def r_delete(cursor, key)
      return nil if cursor.nil?

      if key < cursor.key
        cursor.left = r_delete(cursor.left, key)
      elsif key > cursor.key
        cursor.right = r_delete(cursor.right, key)
      else
        return cursor.left if cursor.right.nil?

        doomed = cursor
        cursor = r_min(doomed.right)
        cursor.right = r_delete_min(doomed.right)
        cursor.left = doomed.left
      end

      cursor.count = 1 + r_size(cursor.left) + r_size(cursor.right)
      cursor
    end
  end

  class TreeNode
    attr_accessor :key, :value, :left, :right, :count

    def initialize(k = nil, v = nil, c: nil)
      @key = k
      @value = v
      @count = c
    end
  end
end
