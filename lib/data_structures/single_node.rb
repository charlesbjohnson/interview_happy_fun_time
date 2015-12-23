module DataStructures
  class SingleNode
    attr_accessor :data, :next

    def initialize(d = nil, n: nil)
      @data = d
      @next = n
    end
  end
end
