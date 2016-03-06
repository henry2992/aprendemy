class License < ActiveRecord::Base
  enum plan: {free: 10, premium: 0, expired: 0}
  belongs_to :user
end
