class FingerprintScanner < ActiveRecord::Base
  attr_accessible :location

  has_many :scanned_fingerprints
  has_many :fingerprints, through: :scanned_fingerprints

  def self.has_scanned_fingerprints_for_database_id(db_id)
  	FingerprintScanner.where(id: ScannedFingerprint.select(:fingerprint_scanner_id).where(fingerprint_id: Fingerprint.select(:id).where(fingerprint_database_id: db_id)))
  end
end
