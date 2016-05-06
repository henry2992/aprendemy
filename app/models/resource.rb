class Resource < ActiveRecord::Base
	belongs_to :material, :polymorphic => true
  belongs_to :tutorial
  validates :generic_name, presence: true
  validates :material, presence: true
end
