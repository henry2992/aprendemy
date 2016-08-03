class Resource < ActiveRecord::Base
	
	belongs_to :material, :polymorphic => true
  belongs_to :section
	has_many :resource_progresses

  validates :name, presence: true
  validates :material, presence: true

  #validates :section_id, presence: true, unless: ->(resource){resource.tutorial_id.present?}
  #validates :tutorial_id, presence: true, unless: ->(resource){resource.section_id.present?}

  def total_questions
    self.material_type == "Task" ? self.material.questions.count : nil
  end
end
