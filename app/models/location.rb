class Location < ApplicationRecord
  belongs_to :user

  geocoded_by :address
  after_validation :geocode # auto-fetch coordinates after validating

  validate :check_invalid_address

  def check_invalid_address  	
  	 if latitude.blank?  	 	
  	 	errors.add(:location_Error, "Invalid Address, please Try with different Address")
  	 end
  end
end
