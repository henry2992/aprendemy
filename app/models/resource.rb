class Resource < ActiveRecord::Base
	
	belongs_to :material, :polymorphic => true
  belongs_to :section
	has_many :resource_progresses

  validates :name, presence: true
  validates :material, presence: true

  def total_questions
    self.material_type == "Task" ? self.material.questions.count : nil
  end
end
