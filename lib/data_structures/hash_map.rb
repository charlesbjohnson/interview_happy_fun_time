require_relative 'linked_list'

module DataStructures
  class HashMap
    include Enumerable

    def initialize
      @table = Array.new(30)
      @size = 0
    end

    attr_reader :size

    def each(&block)
      enum = Enumerator.new do |y|
        @table.each do |c|
          c.each { |i| y << i } unless c.nil?
        end
      end

      block_given? ? enum.each(&block) : enum
    end

    def get(key)
      chain = @table[hash(key)]
      return nil if chain.nil?

      found = chain.find { |i| i.first == key }
      found.last unless found.nil?
    end

    def put(key, value)
      chain = @table[hash(key)] ||= LinkedList.new
      found = chain.find { |i| i.first == key }
      if found.nil?
        chain.append([key, value])
        @size += 1
      else
        found[1] = value
      end
    end

    def delete(key)
      chain = @table[hash(key)]
      return nil if chain.nil?

      found = chain.find { |i| i.first == key }
      return nil if found.nil?

      index = chain.index(found)
      chain.delete(index)

      @size -= 1
    end

    private

    def hash(key)
      key.hash.abs % @table.size
    end
  end
end
