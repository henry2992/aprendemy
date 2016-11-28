class TakingNewCourse < ApplicationMailer
  def send_mail (course_user)
    
    # sub_data = { 
    #               first_name: course_user.user.first_name, 
    #               last_name: course_user.user.last_name, 
    #               course_name: course_user.course.name
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
    #   template_id: "welcome-to-course"
    # }
    # mail(to: course_user.user.email, subject: "Bienvenido al curso #{course_user.course.name}", body: "", sparkpost_data: data)
  end
end
