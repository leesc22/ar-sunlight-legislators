require 'byebug'
require 'csv'
require 'date'
require_relative '../app/models/legislator'
require_relative '../app/models/representative'
require_relative '../app/models/senator'

class SunlightLegislatorsImporter
  def self.import(filename)
    csv = CSV.new(File.open(filename), :headers => true)
    attributes = ["title", "firstname", "middlename", "lastname", "name_suffix", "party", "state", "district", "in_office", "gender", "phone", "fax", "website", "webform", "twitter_id", 'senate_class', "birthdate"]
    csv.each do |row|
      row = row.to_h
      hash = {}
      row.each do |field, value|
        hash[field] = value
        hash.keep_if { |k, v| attributes.include?(k) }
      end
      birthday = Date.strptime(hash["birthdate"], "%m/%d/%Y")
      hash["birthdate"] = birthday
      if hash["title"] == "Rep"
        Representative.create!(hash)
      elsif hash["title"] == "Sen"
        Senator.create!(hash)
      else
        Legislator.create!(hash)
      end
    end
  end
end

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end


# SunlightLegislatorsImporter.import('../db/data/legislators.csv')

