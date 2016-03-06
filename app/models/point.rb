class Point < ActiveRecord::Base
  belongs_to :point_action


  def recipient_type_enum
    ['SubCategory', 'Simulator']
  end
end
