class AnsweredQuestion < ActiveRecord::Base
  belongs_to :question, counter_cache: true
  belongs_to :user

  has_many :choices, through: :question
  after_save :allocate_points

  def allocate_points
    binding.pry
    point_action = PointAction.find_by_action('answer_question')
    Point.create(owner_id: self.id, owner_type: 'AnsweredQuestion', pointable_id: point_action.id, pointable_type: 'PointAction', recipient_id: self.user_id, recipient_type: 'User', points: point_action.points_alloted) if self.correct && point_action
  end
end
