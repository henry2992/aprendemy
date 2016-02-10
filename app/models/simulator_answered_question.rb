class SimulatorAnsweredQuestion < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :question, dependent: :destroy
  belongs_to :simulator, dependent: :destroy
  enum status: [:unanswered, :correct, :wrong]
  enum marked_status: [:unmarked, :marked]

  def self.create_simulation_questions question_ids, user_id, simulator_id
    question_ids.each do |question_id|
      create(user_id: user_id, question_id: question_id, simulator_id: simulator_id)
    end
  end
end
