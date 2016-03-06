namespace :create do
  desc "Creates default actions so we can allocate points to them"
  task actions: :environment do
    success = PointAction.create([
      {action: 'finish_simulator', description: 'finish a simulator'},
      {action: 'answer_question', description: 'answer a question', points_alloted: 10}
    ])
    p 'Defaults successfully created' if success
  end
end

namespace :destroy do
  desc "Delete default actions created by the 'create' task"
  task actions: :environment do
    success = PointAction.where(action: ['finish_simulator', 'answer_question']).delete_all
    p 'Defaults successfully deleted' if success
  end
end
