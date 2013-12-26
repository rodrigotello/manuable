class City < ActiveRecord::Base
  # attr_accessible :name
  belongs_to :state

  def as_json options={}
    if self.read_attribute(:state_name) && self.read_attribute(:sid)
      {
        id: id,
        name: name,
        state: {
          id: self.read_attribute(:sid),
          name: self.read_attribute(:state_name)
        }
      }
    else
      super options
    end
  end
end
