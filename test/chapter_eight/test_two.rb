require 'config_test'

module ChapterEight::Two
  describe CallCenter do

    subject { CallCenter.new }

    it { subject.must_respond_to :dispatch_call }
    it { subject.must_respond_to :add_staff }

    describe '#add_staff' do
      let(:respondent) { StaffMember.respondent }
      it 'adds the staff member as an available staff' do
        staff = subject.instance_variable_get(:@staff)
        staff.values.map { |h| h.values }.flatten.must_be_empty

        actual = subject.add_staff(respondent)

        staff[respondent.support_role][:available].must_include respondent
        staff[respondent.support_role][:unavailable].wont_include respondent
        actual.must_equal respondent
      end

      it 'adds the call center as an observer of the staff member' do
        respondent.count_observers.must_equal 0
        subject.add_staff(respondent)
        respondent.count_observers.must_equal 1
      end
    end

    describe '#dispatch_call' do
      before do
        @respondent = subject.add_staff(StaffMember.respondent)
        @manager = subject.add_staff(StaffMember.manager)
        @director = subject.add_staff(StaffMember.director)
        @call = Call.new
      end

      describe 'if a respondent is available' do
        it 'connects the call with a staff member' do
          subject.dispatch_call(@call)
          @respondent.current_call.must_equal @call
        end

        it 'connects the call with a staff member who is capable' do
          @call.escalate_issue
          subject.dispatch_call(@call)
          @manager.current_call.must_equal @call
        end

        describe 'the call requires respondent with higher support tier' do
          before do
            manager_call = Call.new { |c| c.escalate_issue }
            director_call = Call.new { |c| 2.times { c.escalate_issue } }
            subject.dispatch_call(@call)
            subject.dispatch_call(manager_call)
            subject.dispatch_call(director_call)
          end

          it 'the call is added to the waiting list' do
            @respondent.reassign_call
            subject.instance_variable_get(:@wait_list).must_include @call
          end

          it 'returns the original respondent to the available staff' do
            @respondent.reassign_call

            staff = subject.instance_variable_get(:@staff)
            staff[@respondent.support_role][:unavailable].wont_include @respondent
            staff[@respondent.support_role][:available].must_include @respondent
          end

          describe 'other calls waiting' do
            before do
              @other_call = Call.new
              subject.dispatch_call(@other_call)
            end

            it 'dispatches the first waiting call' do
              @respondent.reassign_call
              @respondent.current_call.must_equal @other_call
            end
          end
        end
      end

      describe 'if no staff member is available' do
        before { subject.dispatch_call(@call) }

        it 'queues the call until a staff member is available' do
          other_call = Call.new
          subject.dispatch_call(other_call)

          other_call.wont_be :connected?
          other_call.respondent.must_be_nil
          subject.instance_variable_get(:@wait_list).must_include other_call
        end
      end
    end

  end

  describe Call do

    subject { Call.new }

    it { subject.must_respond_to :connect }
    it { subject.must_respond_to :disconnect }
    it { subject.must_respond_to :connected? }
    it { subject.must_respond_to :respondent }
    it { subject.must_respond_to :level }
    it { subject.must_respond_to :escalate_issue }

    let(:respondent) { StaffMember.respondent }

    it 'starts out disconnected' do
      subject.wont_be :connected?
      subject.respondent.must_be_nil
    end

    describe '#connect' do
      it 'connects the call with a respondent' do
        subject.connect(respondent)
        subject.must_be :connected?
        subject.respondent.must_equal respondent
      end
    end

    describe '#disconnect' do
      before { subject.connect(respondent) }

      it 'disconnects the call from the respondent' do
        subject.disconnect
        subject.wont_be :connected?
        subject.respondent.must_be_nil
      end
    end

    describe '#escalate_issue' do
      it 'escalates the level of the call' do
        subject.level.must_equal 0
        subject.escalate_issue
        subject.level.must_equal 1
      end

      it 'does not escalate past level 2' do
        6.times { subject.escalate_issue }
        subject.level.must_equal 2
      end
    end

  end

  describe StaffMember do

    subject { StaffMember.respondent }

    it { subject.must_respond_to :assign_call }
    it { subject.must_respond_to :reassign_call }
    it { subject.must_respond_to :current_call }

    it do
      StaffMember.respondent.support_role.must_equal :respondent
      StaffMember.manager.support_role.must_equal :manager
      StaffMember.director.support_role.must_equal :director
    end

    let(:call) { Call.new }

    describe '#assign_call' do

      it do
        subject.assign_call(call)
        subject.current_call.must_equal call
        call.must_be :connected?
        call.respondent.must_equal subject
      end
    end

    describe '#reassign_call' do
      before do
        subject.assign_call(call)
      end

      it 'notifies observers' do
        call_center = mock('call center')
        call_center.stubs(:update)
        subject.add_observer(call_center)

        call_center.expects(:update).with(subject, call)
        subject.reassign_call
      end

      it 'escalates the call' do
        subject.current_call.level.must_equal 0
        subject.reassign_call
        call.level.must_equal 1
      end

      it 'disconnects the call' do
        subject.reassign_call
        call.wont_be :connected?
        subject.current_call.must_be_nil
      end
    end

  end

end
