require 'config_test'

module ChapterTwo
  class TestSeven < Minitest::Test
    class DataStructures::LinkedList
      include Seven
    end

    def setup
      @list = DataStructures::LinkedList.new
    end

    def test_palindrome_true
      'racecar'.chars.each { |c| @list.append(c) }
      assert @list.palindrome?
    end

    def test_palindrome_false
      'meh'.chars.each { |c| @list.append(c) }
      refute @list.palindrome?
    end

    def test_palindrome_numeric
      [1, 0, 1].each { |n| @list.append(n) }
      assert @list.palindrome?
    end

    def test_palindrome_empty
      assert @list.palindrome?
    end

    def test_palindrome_single
      @list.append('a')
      assert @list.palindrome?
    end
  end
end
