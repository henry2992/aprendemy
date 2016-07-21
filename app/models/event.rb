class Event < ActiveRecord::Base
	has_one :event_type
end
