class SimulatedCategory < ActiveRecord::Base
  belongs_to :category, inverse_of: :simulated_categories
end
