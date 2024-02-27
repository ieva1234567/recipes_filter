class ContactMailer < ApplicationMailer

    def please_contact_me(user_email: nil, user_text: nil)
        @user_email = user_email
        @mail_text = user_text
        mail(to: "receptufiltras@gmail.com", subject: "SUSISIEK SU MANIM #{user_email}")
    end

end
