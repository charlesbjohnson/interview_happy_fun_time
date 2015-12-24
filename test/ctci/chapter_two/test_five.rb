require 'config_test'

module CTCI::ChapterTwo
  class TestFive < Minitest::Test
    include Five

    def setup
      @first, @second = Array.new(2) { DataStructures::LinkedList.new }
    end

    # reversed implementation
    def test_reverse_add_digits
      [7, 1, 6].each { |n| @first.append(n) }
      [5, 9, 2].each { |n| @second.append(n) }

      actual = reverse_add_digits(@first.instance_variable_get(:@head),
                                  @second.instance_variable_get(:@head))
      assert_equal [2, 1, 9], actual.to_a
    end

    def test_reverse_add_digits_differing_magnitude
      [3, 9].each { |n| @first.append(n) }
      [1, 7, 4, 5].each { |n| @second.append(n) }

      actual = reverse_add_digits(@first.instance_variable_get(:@head),
                                  @second.instance_variable_get(:@head))
      assert_equal [4, 6, 5, 5], actual.to_a
    end

    def test_reverse_add_digits_one_empty
      [1, 2].each { |n| @second.append(n) }

      actual = reverse_add_digits(@first.instance_variable_get(:@head),
                                  @second.instance_variable_get(:@head))
      assert_equal [1, 2], actual.to_a
    end

    def test_reverse_add_digits_both_empty
      actual = reverse_add_digits(@first.instance_variable_get(:@head),
                                  @second.instance_variable_get(:@head))
      assert_equal [], actual.to_a
    end

    # forward implementation
    def test_add_digits
      [6, 1, 7].each { |n| @first.append(n) }
      [2, 9, 5].each { |n| @second.append(n) }

      actual = add_digits(@first.instance_variable_get(:@head),
                          @second.instance_variable_get(:@head))
      assert_equal [9, 1, 2], actual.to_a
    end

    def test_add_digits_differing_magnitude
      [9, 3].each { |n| @first.append(n) }
      [5, 4, 7, 1].each { |n| @second.append(n) }

      actual = add_digits(@first.instance_variable_get(:@head),
                          @second.instance_variable_get(:@head))
      assert_equal [5, 5, 6, 4], actual.to_a
    end

    def test_add_digits_one_empty
      [2, 1].each { |n| @first.append(n) }

      actual = add_digits(@first.instance_variable_get(:@head),
                          @second.instance_variable_get(:@head))
      assert_equal [2, 1], actual.to_a
    end

    def test_add_digits_both_empty
      actual = add_digits(@first.instance_variable_get(:@head),
                          @second.instance_variable_get(:@head))
      assert_equal [], actual.to_a
    end
  end
end
