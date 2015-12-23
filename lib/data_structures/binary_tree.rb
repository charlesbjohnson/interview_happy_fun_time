module DataStructures
  class BinaryTree
    attr_accessor :root

    def self.from(keys, head)
      top = nil

      nodes = []
      keys.each do |rt, c|
        l = r = nil
        unless c.nil?
          l = c[0]
          r = c[1]
        end
        left = find_or_create(l, nodes)
        right = find_or_create(r, nodes)

        root = find_or_create(rt, nodes, left, right)

        top = root if root.key == head
      end

      result = new
      result.root = top
      result
    end

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

    private_class_method :new
  end

  class BinaryTreeNode
    attr_accessor :key, :value, :left, :right

    def initialize(k, l = nil, r = nil)
      @key = k
      @value = k.to_s
      @left = l
      @right = r
    end
  end
end
