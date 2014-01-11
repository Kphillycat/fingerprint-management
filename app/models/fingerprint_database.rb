class FingerprintDatabase < ActiveRecord::Base
  attr_accessible :name, :owner

  has_many :fingerprints

  def unknown_people_fingerpints
  	Fingerprint.where(fingerprint_database_id: self.id, person_id: nil)
  end

  def self.fingerprint_counts
  	Fingerprint.group(:fingerprint_database_id).count
  end
end
