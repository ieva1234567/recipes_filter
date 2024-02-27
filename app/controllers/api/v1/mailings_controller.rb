class Api::V1::MailingsController < Api::V1::BaseController

    def send_please_contact_me_mail
        err = {}
        err[:message] = "Negali būti tuščias" if params[:message].blank?
        if params[:email].blank?
            err[:email] = "Negali būti tuščias"
        else
            err[:email] = "Netinkamas formatas" if (params[:email] =~ /^([\w.%+-]+)@([\w-]+\.)+([\w]{2,})$/i).nil?
        end   
        if err.present?
            render json: {errors: err}, status: :ok
        else
            ContactMailer.please_contact_me(user_email: params[:email], user_text: params[:message]).deliver_now
            render json: {message: "email shipping sheduled"}, status: :ok
        end
    end

end