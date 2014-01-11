class Person < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :age

  has_many :fingerprints
  has_many :fingerprint_databases, through: :fingerprints
  has_many :scanned_fingerprints, through: :fingerprints
  has_many :criminal_histories

  def tracked_by(org)
	owner_id = FingerprintDatabase.find_by_owner(org).id
  	array_of_fp_ppl_id = []
  	Fingerprint.find_each do |fp|
  		array_of_fp_ppl_id << fp.person_id if fp.fingerprint_database_id == owner_id
  	end
	
  	Person.where(id: array_of_fp_ppl_id)
  end

  def with_history_of(incident_type)
  	Person.where(id: CriminalHistory.select(:person_id).where(incident_type_id: incident_type.id))
  end

  def fbi_tracked_robbers
  	Person.where(id: CriminalHistory.select(:person_id), id: Fingerprint.select(:person_id).where(fingerprint_database_id: 2))
  end
end
