describe 'Tests mailer' do

  it 'this is a test' do
    #this is a test
    test = 1 
    expect(test).to eq(0)
  end

  it ''

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

end
