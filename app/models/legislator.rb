require 'time'
require_relative '../../db/config'

class Legislator < ActiveRecord::Base
  validates :title, :firstname, :lastname, :party,  :state, :district, :gender, :birthdate, presence: true
  validates :party, format: { with: /\A[D|I|R]\z/, message: "either 'D', 'I' or 'R'" }
  validates :state, format: { with: /\A[A-Z]{2}\z/, message: "Invalid state code!"}
  validates :in_office, inclusion: { in: [true, false], message: "Must be true or false!" }
  validates :gender, format: { with: /\A[M|F]\z/, message: "Invalid gender!"}
  validates :phone, :fax, allow_blank: true, format: { with: /(.*\d.*){10,}/, message: "Invalid phone number!"}
  validates :senate_class, allow_blank: true, format: { with: /\A(I|II|III)\z/, message: "either 'I', 'II' or 'III'" }


  # Full validation if import every field from CSV
  # TODO update validation details
  # validates :title, :first_name, :last_name, :party,  :state, :district, :in_office, :gender, :bioguide_id, :votesmart_id, :govtrack_id, :crp_id, :congresspedia_url, :birthdate, presence: true
  # validates :bioguide_id, :votesmart_id, :fec_id, :crp_id, :govtrack_id, uniqueness: true
  # validates :party, format: { with: /^[D|I|R]$/, message: "either 'D', 'I' or 'R'" }
  # validates :state, format: { with: /^[A-Z]{2}$/, message: "Invalid state code!"}
  # validates :gender format: { with: /^[M|F]$/, message: "Invalid gender!"}
  # validates :phone, :fax, format: { with: /(.*\d.*){10,}/, message: "Invalid phone number!"}
  # validates :bioguide_id, format: { with: /^[A-Z]{1}\d{6}$/, message: "Invalid bioguide id!" }
  # validates :fec_id, format: { with: /^[A-Z]{1}\d{1}[A-Z]{2}\d{5}$/, message: "Invalid fec id!" }
  # validates :govtrack_id, format: { with: /\d{6}/, message: "Invalid govtrack id!"}
  # validates :crp_id, format: { with: /^[A-Z]{1}\d{8}$/, message: "Invalide crp id!" }
  # validates :senate_class, format: { with: /^[I|II|III]$/, message: "either 'I', 'II' or 'III'" }
end
