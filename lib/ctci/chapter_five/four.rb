module CTCI::ChapterFive
  module Four
    # Explain what the following code does: ((n & (n - 1)) == 0)
    #
    # My answer was that it determines if there is only a single
    # set bit in the number or zero.
    # The book's answer is that it determines if a number is a power of 2
    # or zero.
    # They are basically the same. But the book answer is more semantically
    # meaningful.
    def mystery(n)
      (n & (n - 1)).zero?
    end
  end
end
