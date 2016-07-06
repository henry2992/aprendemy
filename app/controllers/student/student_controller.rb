class Student::StudentController < ApplicationController
  before_filter :authenticate_user!

  def check_plan
    course_user = CourseUser.where(course: @course, user: current_user).first_or_create
    
    CourseUserPlan.create! course_user: course_user, plan: Plan.where(name: "Free").first if !course_user.course_user_plan.present?

    # Redirigir a pagos si ha expirado el plan contratado del curso
    if Date.today > course_user.course_user_plan.expiration_date
      course_user.course_user_plan.status = 0
      return redirect_to payments_path
    end
  end

  def redirect_if_premium_plan
    course_user = CourseUser.where(course: @course, user: current_user).first
    # Redirigir a pagos si no tiene plan registrado
    return redirect_to payments_path if !course_user.course_user_plan.present?
    # Redirigir si no es un plan Premium
    return redirect_to payments_path if course_user.plan.name == "Premium"
  end

end
