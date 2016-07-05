class Plan < ActiveRecord::Base

  enum licence_type: [:free,:paid]

  validates_presence_of :name, :expiration_days, :licence_type, :price

end
