module EPI::ChapterSeven
  module One
    # Implement string/integer inter-conversion functions.
    def i_to_s(i)
      i = i.to_i

      return '0' if i.zero?

      result = ''
      is_negative = i.negative?
      i = i.abs

      until i.zero?
        i, digit = i.divmod(10)
        result.prepend(('0'.ord + digit).chr)
      end

      result.prepend('-') if is_negative
      result
    end

    def s_to_i(s)
      s = s.to_s.strip

      fail "invalid input `#{s}'" if s.empty?

      is_negative = s[0] == '-'
      start = is_negative ? 1 : 0

      result = (start...s.length).reverse_each.with_index.reduce(0) do |a, (e, i)|
        character = s[e]

        fail "invalid character `#{character}'" unless ('0'..'9').include?(character)

        power = 10**i
        digit = character.ord - '0'.ord

        a + digit * power
      end

      result *= -1 if is_negative
      result
    end
  end
end
