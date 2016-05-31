class License < ActiveRecord::Base
  enum plan: {free: 10, premium: 0, expired: nil} unless defined? License
  belongs_to :user
end
