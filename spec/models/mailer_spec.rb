describe 'Tests mailer' do
  it 'should send email to required email address with proper content ' do
    # Send the email, then test that it got queued
    email = Mailer.sync_message(
      to: 'tluo@ncsu.edu',
      subject: "Test",
      body: {
        obj_name: 'assignment',
        type: 'submission',
        location: '1',
        first_name: 'User',
        partial_name: 'update'
      }
    ).deliver_now

    expect(email.from[0]).to eq("expertiza.development@gmail.com")
    expect(email.to[0]).to eq('expertiza.development@gmail.com')
    expect(email.subject).to eq('Test')
  end

  it 'should send email to required email address when score is outside acceptable value ' do
    let(:assignment) {
      build(:assignment, name: "test_assignment")
    }
    # Send the email, then test that it got queued
    email = Mailer.notify_grade_conflict_message(
      to: 'tluo@ncsu.edu',
      subject: "Test",
      body: {
        assignment: assignment,
        type: 'review',
        reviewer_name: 'Reviewer',
        reviewee_name: 'Reviewee',
        new_score: 0.95,
        conflicting_response_url: 'https://expertiza.ncsu.edu/response/view?id=1',
        summary_url: 'https://expertiza.ncsu.edu/grades/view_team?id=1',
        assignment_edit_url: 'https://expertiza.ncsu.edu/assignments/1/edit'
      }
    ).deliver_now

    expect(email.from[0]).to eq("expertiza.development@gmail.com")
    expect(email.to[0]).to eq('expertiza.development@gmail.com')
    expect(email.subject).to eq('Test')
  end
end
