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

