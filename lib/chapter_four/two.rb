module ChapterFour
  module Two

    # Given a directed graph, design an algorithm to find out whether there
    # is a route between two nodes.
    def connected?(from, to)
      return nil if @table[from].nil? || @table[to].nil?

      visited = Array.new(size_vertices, false)
      r_connected?(from, to, visited)
    end

    def r_connected?(from, to, visited)
      return true if from == to

      result = false
      visited[from] = true
      cursor = @table[from]
      cursor.adjacent.each do |a, _|
        result = r_connected?(a, to, visited) unless visited[a]
      end

      result
    end

  end
end
