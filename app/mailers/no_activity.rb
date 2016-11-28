class NoActivity < ApplicationMailer
  def send_mail (user)
    # sub_data = { 
    #               first_name: user.first_name, 
    #               last_name: user.last_name, 
    #             }
    # data = {
    # #   track_opens: true,
    # #   track_clicks: false,
    # #   campaign_id: "My Campaign",
    # #   transactional: true,
    # #   ip_pool = "SPECIAL_POOL",
    # #   api_key = "MESSAGE_SPECIFIC_API_KEY"
    # #   subaccount = "123"
    #   substitution_data: sub_data, 
    #   template_id: "no-activity"
    # }
    # mail(to: user.email, subject: "Hola #{user.first_name}, hace tiempo que no sabemos de ti", body: "", sparkpost_data: data)
  end
end
