require_relative 'models/representative'
require_relative 'models/senator'


# Query 1
def list_legislators_by_state(state)
	puts "Senators:"
	Senator.where(state: state).order(:lastname).each do |s|
	  puts "  #{s.firstname} #{s.middlename} #{s.lastname} (#{s.party})".squeeze(" ")
	end

	puts "Representatives:"
	Representative.where(state: state).order(:lastname).each do |r|
		puts "  #{r.firstname} #{r.middlename} #{r.lastname} (#{r.party})".squeeze(" ")
	end
end

list_legislators_by_state("CA")

# Query 2
def statistics_active(gender)
  gender_string = gender == "M" ? "Male" : "Female"
  senators_active = Senator.where(in_office: true)
  number_senators = senators_active.where(gender: gender).count
  percentage_senators = 100 * number_senators / senators_active.count
  representatives_active = Representative.where(in_office: true)
  number_represenetatives = representatives_active.where(gender: gender).count
  percentage_representatives = 100 * number_represenetatives / representatives_active.count
  puts "#{gender_string} Senators: #{number_senators} (#{percentage_senators}%)"
  puts "#{gender_string} Representatives: #{number_represenetatives} (#{percentage_representatives}%)"
end

statistics_active("M")
statistics_active("F")
