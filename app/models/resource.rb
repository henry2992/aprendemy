class Resource < ActiveRecord::Base
	
	belongs_to :material, :polymorphic => true
  belongs_to :section
	has_many :resource_progresses

  validates :name, presence: true
  validates :material, presence: true

  before_save :set_position

  def set_position
    if self.section_id != nil
      if self.position == 0
        self.position = self.section.top_position + 1
      end
    else
      self.position = 0
    end
  end

  def total_questions
    self.material_type == "Task" ? self.material.questions.count : nil
  end
end
