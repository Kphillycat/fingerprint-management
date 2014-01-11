class IncidentType < ActiveRecord::Base
  attr_accessible :name

  has_many :criminal_histories
  has_many :people, through: :criminal_histories

  def self.alphabetical
  	order(:name)
  end

  def average_age_of_offenders
  	incident_id = IncidentType.select(:id).find_by_name(self.name) 	
  	Person.select(:age).where(id: CriminalHistory.select(:person_id).where(incident_type_id: incident_id)).average(:age)
  end
end
