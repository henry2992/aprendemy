class License < ActiveRecord::Base
  enum plan: {free: 10, premium: 0, expired: nil}
  belongs_to :user
end
