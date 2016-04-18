class Resource < ActiveRecord::Base

	belongs_to :material, :polymorphic => true
	belongs_to :tutorial
end
