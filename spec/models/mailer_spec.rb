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

  it 'should send email with a suggested topic is approved' do
    # Send the email, then test that it got queued
    email = Mailer.suggested_topic_approved_message(
      to: 'tluo@ncsu.edu',
      cc: 'tluo2@ncsu.edu',
      subject: "Suggested topic 'Test' has been approved",
      body: {
        approved_topic_name: 'assignment',
        proposer: 'User'
      }
    ).deliver_now

    expect(email.from[0]).to eq("expertiza.development@gmail.com")
    expect(email.to[0]).to eq('expertiza.development@gmail.com')
    expect(email.bcc[0]).to eq('expertiza.development@gmail.com')
    expect(email.subject).to eq("Suggested topic 'Test' has been approved")
  end
end
