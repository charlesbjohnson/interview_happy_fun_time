require 'observer'

module CTCI::ChapterEight
  module Two
    # Imagine you have a call center with three levels of employees:
    # respondent, manager, and director. An incoming telephone call must
    # be first allocated to a respondent who is free. If the respondent can't
    # handle the call, he or she must escalate the call to a manager. If the
    # manager is not free or not able to handle it, then the call should be
    # escalated to a director. Design the calles and data structures for
    # this problem. Implement a method dispatchCall() which assigns a call
    # to the first available employee.
    class CallCenter
      def initialize
        @staff = Hash[StaffMember.roles.map do |r|
          [r, { available: [], unavailable: [] }]
        end]
        @wait_list = []
      end

      def dispatch_call(call)
        support_role_required = StaffMember.roles[call.level]
        assigned_staff = find_staff_members_for(support_role_required)

        if assigned_staff.nil?
          @wait_list.push(call)
        else
          assigned_staff.assign_call(call)
          mark_unavailable(assigned_staff)
        end
      end

      def add_staff(member)
        @staff[member.support_role][:available].push(member)
        member.add_observer(self)

        member
      end

      def update(member, call)
        mark_available(member)
        @wait_list.push(call)
        dispatch_call(@wait_list.shift) unless @wait_list.empty?
      end

      private

      def find_staff_members_for(support_role)
        @staff[support_role][:available].first
      end

      def mark_unavailable(staff_member)
        available = @staff[staff_member.support_role][:available]
        unavailable = @staff[staff_member.support_role][:unavailable]

        available.delete(staff_member)
        unavailable.push(staff_member)
      end

      def mark_available(staff_member)
        available = @staff[staff_member.support_role][:available]
        unavailable = @staff[staff_member.support_role][:unavailable]

        unavailable.delete(staff_member)
        available.push(staff_member)
      end
    end

    class Call
      attr_reader :respondent, :level

      def initialize
        @level = 0
        yield self if block_given?
      end

      def connected?
        !@respondent.nil?
      end

      def connect(respondent)
        @respondent = respondent
      end

      def disconnect
        @respondent = nil
      end

      def escalate_issue
        @level += 1 if @level < 2
      end
    end

    class StaffMember
      include Observable

      attr_reader :support_role, :current_call

      def initialize(role)
        @support_role = role
      end

      def assign_call(call)
        @current_call = call
        @current_call.connect(self)
      end

      def reassign_call
        @current_call.escalate_issue
        @current_call.disconnect

        call = @current_call
        @current_call = nil
        notify(self, call)
      end

      class << self
        @@roles = %i(respondent manager director).freeze

        @@roles.each do |r|
          define_method r do
            new(r)
          end
        end

        def roles
          @@roles
        end

        private :new
      end

      private

      def notify(member, call)
        changed
        notify_observers(member, call)
      end
    end
  end
end
