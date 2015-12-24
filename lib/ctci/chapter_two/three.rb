module CTCI::ChapterTwo
  module Three
    # Implement an algorithm to delete a node in the middle
    # of a single linked list, given only access to that node.
    def delete_node(node)
      node.data = node.next.data
      doomed = node.next
      node.next = doomed.next
    end
  end
end
