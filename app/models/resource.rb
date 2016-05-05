class Resource < ActiveRecord::Base
	belongs_to :material, :polymorphic => true
  belongs_to :tutorial
	belongs_to :section
end
