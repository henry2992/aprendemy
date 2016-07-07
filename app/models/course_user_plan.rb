class CourseUserPlan < ActiveRecord::Base
  belongs_to :course_user
  belongs_to :plan

  enum status: [:expired, :active]

  validates_presence_of :course_user, :plan

  before_create :set_expiration_date_and_status

  private
    def set_expiration_date_and_status
      # Para asegurar la relación de 1-1 cada vez que se cree un nuevo registro
      # se debe eliminar los anteriores pertenecientes a ese CourseUser
      CourseUserPlan.destroy_all(course_user: self.course_user)
      # Se configuran los campos antes de almacenar el registro
      self.expiration_date = Date.today + self.plan.expiration_days
      self.status = :active
    end
end
