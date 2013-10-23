module DataStructures
  class SingleNode
    attr_accessor :data, :next

    def initialize(d = nil, n: nil)
      @data, @next = d, n
    end

  end
end
