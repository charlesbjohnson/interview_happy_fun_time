module CTCI::ChapterFive
  module Two
    # Given a real number between 0 and 1 (e.g., 0,72) that is passed
    # in as a double, print the binary representation. If the number
    # cannot be represented accurately in binary with at most 32 characters,
    # print "ERROR".
    def to_binary_s(i)
      result = ''
      num = i

      until num.zero?
        return 'ERROR' if result.size > 32

        r = num * 2
        result << if r >= 1
                    r -= 1
                    '1'
                  else
                    '0'
                  end
        num = r
      end

      result.prepend('0.')
    end
  end
end
