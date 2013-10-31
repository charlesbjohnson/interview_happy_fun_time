module DataStructures
  class BinaryTree
    attr_accessor :root

    def self.from(keys, head)
      top = nil

      nodes = []
      keys.each do |rt, c|
        l = r = nil
        l, r = c[0], c[1] unless c.nil?
        left = find_or_create(l, nodes)
        right = find_or_create(r, nodes)

        root = find_or_create(rt, nodes, left, right)

        top = root if root.key == head
      end

      result = new
      result.root = top
      result
    end

    private_class_method :new

    private

    def self.find_or_create(key, from, left = nil, right = nil)
      return if key.nil?

      found = from.find { |n| n.key == key }
      unless found
        found = BinaryTreeNode.new(key)
        from.push(found)
      end

      found.left ||= left
      found.right ||= right

      found
    end

  end

  class BinaryTreeNode
    attr_accessor :key, :value, :left, :right

    def initialize(k, l = nil, r = nil)
      @key, @value = k, k.to_s
      @left, @right = l, r
    end

  end
end
