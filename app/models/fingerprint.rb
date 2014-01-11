class Fingerprint < ActiveRecord::Base
  attr_accessible :taken_at

  has_many :scanned_fingerprints
  has_many :fingerprint_scanners, through: :scanned_fingerprints

  belongs_to :fingerprint_database

  belongs_to :person
  has_many :criminal_histories, through: :person

  def self.for_offenders_of(incident_type)
  	Fingerprint.where(person_id: CriminalHistory.select(:person_id).where(incident_type_id: incident_type.id))
  end

  def self.of_unknown_people
  	Fingerprint.where(person_id: nil)
  end

  def self.early_twentieth_century
  	Fingerprint.where(taken_at: Time.utc(1900)...Time.utc(1931))
  end
end
