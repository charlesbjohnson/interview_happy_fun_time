require 'config_test'
require_relative 'shared_sorting_behavior'

module Algorithms
  module Sorting
    class TestQuickSort < Minitest::Test
      include QuickSort
      include SharedSortingBehavior::Immutable
      include SharedSortingBehavior::Mutable
    end
  end
end
