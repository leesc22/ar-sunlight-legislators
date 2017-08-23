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
def statistics_active_gender(gender)
  gender_string = gender == "M" ? "Male" : "Female"
  senators_active = Senator.where(in_office: true)
  number_senators = senators_active.where(gender: gender).count
  percentage_senators = 100 * number_senators / senators_active.count
  representatives_active = Representative.where(in_office: true)
  number_representatives = representatives_active.where(gender: gender).count
  percentage_representatives = 100 * number_representatives / representatives_active.count
  puts "#{gender_string} Senators: #{number_senators} (#{percentage_senators}%)"
  puts "#{gender_string} Representatives: #{number_representatives} (#{percentage_representatives}%)"
end

statistics_active_gender("M")
statistics_active_gender("F")

# Query 3
def statistics_active_states_all
  # # Hash of states => count
	# hash_senator = Senator.where(in_office: true).group(:state).count
	# hash_representative = Representative.where(in_office: true).group(:state).count
	# hash_total = hash_senator.merge(hash_representative) { |k, v1, v2| v1 + v2 }
	# sorted = hash_total.sort_by { |_, v| v }.reverse
  # states = sorted.map(&:first)

  states = Legislator.where(in_office: true, title: ["Sen", "Rep"]).group(:state).count.sort_by { |_, v| v }.reverse.map(&:first)
  states.each do |state|
    puts "#{state}: #{Senator.where(in_office: true, state: state).count} Senators, #{Representative.where(in_office: true, state: state).count} Representative(s)"
  end
end

statistics_active_states_all

# Query 4
puts "Senators: #{Senator.count}"
puts "Representatives: #{Representative.count}"

# Query 5
Legislator.where(in_office: false).destroy_all
puts "Senators: #{Senator.count}"
puts "Representatives: #{Representative.count}"
