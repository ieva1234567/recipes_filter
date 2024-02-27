require "test_helper"

class ContactMailerTest < ActionMailer::TestCase

  test "new please contact me email" do

    # Set up an email using the order contents
    email = ContactMailer.with(user_text: "Naudotojo tekstas").please_contact_me(user_email: "test@test.test")

    # Check if the email is sent
    assert_emails 1 do
      email.deliver_now
    end

    # Check the contents are correct
    assert_match "SUSISIEK SU MANIM test@test.test", email.subject
    assert_match "Naudotojo tekstas", email.html_part.body.encoded
    assert_match "Naudotojo tekstas", email.text_part.body.encoded
  end

end
