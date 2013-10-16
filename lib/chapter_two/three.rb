module ChapterTwo
  module Three

    def delete_node(node)
      node.data = node.next.data
      doomed = node.next
      node.next = doomed.next
      doomed.next = nil
    end

  end
end
