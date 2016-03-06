class AnsweredQuestion < ActiveRecord::Base
  belongs_to :question, counter_cache: true
  belongs_to :user

  has_many :choices, through: :question
  after_save :allocate_points

  def allocate_points
    point_action = PointAction.find_by_action('answer_question')
    binding.pry
    if self.correct? && point_action
      point = Point.find_or_create_by(owner_id: self.id, owner_type: 'AnsweredQuestion', recipient_id: self.user_id, recipient_type: 'User')
      point.update(point_action_id: point_action.id,points: point_action.points_alloted)
    end
  end
end
