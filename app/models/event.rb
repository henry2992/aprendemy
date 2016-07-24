class Event < ActiveRecord::Base
	
	has_one :event_type

	# attr_accessible :event_type_id


	def event_type_id
      self.event_type.try :id
    end
    def event_type_id=(id)
      self.event_type = EventTipe.find_by_id(id)
    end


end
