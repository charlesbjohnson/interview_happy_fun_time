require 'config_test'
require_relative 'shared_sorting_behavior'

module Algorithms
  module Sorting
    class TestTopDownMergeSort < Minitest::Test
      include TopDownMergeSort
      include SharedSortingBehavior::Immutable
      include SharedSortingBehavior::Mutable
    end
  end
end
