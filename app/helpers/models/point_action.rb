class PointAction < ActiveRecord::Base
  has_many :points

  def rails_admin_displayed_label
    self.action
  end
end
