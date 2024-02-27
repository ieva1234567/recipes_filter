# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
    def please_contact_me(user_email: nil)
        ContactMailer.please_contact_me(user_email: "test@test.test", user_text: "USER TEXT")
    end
end
