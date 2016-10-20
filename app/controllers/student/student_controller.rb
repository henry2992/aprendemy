class Student::StudentController < ApplicationController
  before_filter :authenticate_user!

  def check_plan
    # There must be a plan free first
    CourseUserPlan.create! course_user: course_user, plan: Plan.where(name: "Free").first if !course_user.course_user_plan.present? 
    # Redirigir a pagos si ha expirado el plan contratado del curso
    # raise course_user.course_user_plan.expiration_date.to_yaml
    if course_user.course_user_plan 
      if Date.today > course_user.course_user_plan.expiration_date
        cup = course_user.course_user_plan
        cup.status = "expired" # Marcar como expirado el plan
        cup.save
        redirect_to payments_path 
      end
    end
  end


  # CUAL ES LA DIFERENCIA DE UN PLAN REGISTRADO Y UN PLAN PREMIUM?
  def redirect_if_premium_plan
    # Redirigir a pagos si no tiene plan registrado
    return redirect_to payments_path if !course_user.course_user_plan.present?
    # Redirigir si no es un plan Premium
    return redirect_to payments_path if course_user.plan.name != "Premium"
  end

  def course_user
    CourseUser.where(course: @course, user: current_user).first_or_create
  end

  def update_tests_data
    course_user = CourseUser.where(course: @course, user: current_user).first if @course
    course_user_tests = CourseUserTest.where(course_user: course_user) if course_user
    cuts = course_user_tests
    cuts.where(status: 0).each { |r| 
                                  r.time_left = r.time_left - (Time.now.to_i - r.last_started.to_i)
                                  r.time_left = 0 if r.time_left < 0
                                  r.status = r.time_left == 0 ? 2 : 1
                                  r.last_started = Time.at(Time.now) if !r.completed?
                                  r.time_completed = Time.at(Time.now) if r.completed?
                                  r.save 
                                }
  end

end
