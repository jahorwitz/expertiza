describe 'Tests MailerHelper' do
    let(:user) do
        User.new name: 'abc', fullname: 'abc xyz', email: 'abcxyz@gmail.com', password: '12345678', password_confirmation: '12345678',
                 email_on_submission: 1, email_on_review: 1, email_on_review_of_review: 0, copy_of_emails: 1, handle: 'handle'
    end
    
    before do
        @subject = "Test"
        @partial_name = "new_submission"
        @password = "pa$Sw0rD"
    end

    it 'Check if send_mail_to_user can properly send emails using generic message' do 
        ActionMailer::Base.deliveries.clear
        MailerHelper.send_mail_to_user(
            user, @subject, @partial_name, @password
        ).deliver_now

        email = Mailer.generic_message(
            to: 'tluo@ncsu.edu',
            subject: "Test",
            body: {
              partial_name: "new_submission",
              user: "John Doe",
              first_name: "John",
              password: "Password",
              new_pct: 97,
              avg_pct: 90,
              assignment: "code assignment"
            }
          )
        ActionMailer::Base.deliveries.last.tap do |mail|
            expect(mail.from).to eq(["expertiza.development@gmail.com"])
            expect(mail.to).to eq(["expertiza.development@gmail.com"])
            expect(mail.subject).to eq("Test")
          end
    end
end
  
