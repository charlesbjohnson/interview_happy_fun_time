# This one gets me every time
module CTCI::ChapterThree
  class Four
    # In the classic problem of the Towers of Hanoi, you have 3 towers
    # and N disks of different sizes which can slide onto any tower. The
    # puzzle starts with disks sorted in ascending order of size from top
    # to bottom (i.e., each disk sits on top of an even larger one). You
    # have the following constraints:
    #   1) Only one disk can be moved at a time.
    #   2) A disk is slid off the top of one tower onto the next tower.
    #   3) A disk can only be placed on top of a larger disk.
    # Write a program to move the disks from the first tower to the last
    # using stacks.
    def initialize
      @towers = []
      @index = 0
    end

    def add_tower(disks)
      @towers.push(Tower.new(@index, disks))
      @index += 1
    end

    def tower(i)
      @towers[i].stack.size
    end

    def solve(from, to, by)
      r_solve(@towers[from].stack.size, from, to, by)
    end

    def r_solve(disks, from, to, by)
      return if disks <= 0

      r_solve(disks - 1, from, by, to)
      @towers[from].move_disk(@towers[to])
      r_solve(disks - 1, by, to, from)
    end
  end

  class Tower
    attr_reader :index
    attr_accessor :stack

    def initialize(i, disks = 0)
      @index = i
      @stack = DataStructures::Stack.new
      disks.times.reverse_each { |disk| @stack.push(disk.succ) }
    end

    def move_disk(to)
      return unless to.stack.peek.nil? || @stack.peek < to.stack.peek
      report_move(@stack.peek, @index, to.index)
      to.stack.push(@stack.pop)
    end

    private

    def report_move(disk, from, to)
      puts "move disk #{disk} from #{letter(from)} to #{letter(to)}"
    end

    def letter(index)
      (index + 'A'.ord).chr
    end
  end
end
