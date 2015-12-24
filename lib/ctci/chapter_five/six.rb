# I had the right idea for this one, but didn't know what to do to
# get odd and even bit masks. Didn't realize I could just hard code them.
module CTCI::ChapterFive
  module Six
    ODD_MASK  = 0xaaaaaaaa # 1010 1010 1010 1010 ...
    EVEN_MASK = 0x55555555 # 0101 0101 0101 0101 ...

    # Write a program to swap odd and even bits in an integer
    # with as few instructions as possible (e.g., bit 0 and bit 1
    # are swapped, bit 2 and bit 3 are swapped, and so on).
    def swap_even_odd_bits(n)
      ((n & ODD_MASK) >> 1) | ((n & EVEN_MASK) << 1)
    end
  end
end
