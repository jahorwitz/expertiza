describe 'Tests MailerHelper' do
    before do
        @user = User.first
        @subject = "test"
        @partial_name = "new_submission"
        @password = "pa$Sw0rD"
    end

    it 'Check if send_mail_to_user can properly send emails using generic message' do 
        ActionMailer::Base.deliveries.clear
        MailerHelper.send_mail_to_user(
            User.first, @subject, @partial_name, @password
        )
        ActionMailer::Base.deliveries.last.tap do |mail|
            expect(mail.from).to eq(["expertiza.development@gmail.com"])
            expect(mail.to).to eq(["expertiza.development@gmail.com"])
            expect(mail.subject).to eq("Test")
            expect(mail.body).to eq(email.body)
          end
    end
end
  