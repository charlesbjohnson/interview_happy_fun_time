# This one gets me every time
module ChapterThree
  class Four

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
      if disks > 0
        r_solve(disks - 1, from, by, to)
        @towers[from].move_disk(@towers[to])
        r_solve(disks - 1, by, to, from)
      end
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
      if to.stack.peek.nil? || @stack.peek < to.stack.peek
        report_move(@stack.peek, @index, to.index)
        to.stack.push(@stack.pop)
      end
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
