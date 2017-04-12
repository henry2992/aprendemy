class CourseUser < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :course
  
  has_many :resource_progresses, -> { order(id: :desc) }

  has_many :course_user_tests

  has_one :course_user_plan, :dependent => :destroy
  has_one :plan, :through => :course_user_plan
  
  validates :user, :course, presence: true

  after_create :send_mail

  def progress_percent
    (resource_progresses.where(completed: true).count*100)/total_resources if total_resources != 0
  end

  def total_resources
    Resource.where(section_id: course.sections.map(&:id)).count
  end

  def send_mail
    TakingNewCourse.send_mail(self).deliver
  rescue SparkPostRails::DeliveryException => e
    Rails.logger.error "/----------- Error enviando Email al tomar un nuevo curso --------------/"
    Rails.logger.error "Archivo: app/mailers/taking_new_course.rb"
    Rails.logger.error "Función: send_mail"
    Rails.logger.error "Usuario #: "+ self.user.id
    Rails.logger.error "Email: "+ self.user.email
    Rails.logger.error "Error: "+ e.message
  end
end
