require_relative 'models/representative'
require_relative 'models/senator'


# Query 1
puts "Senators:"
Senator.where(state: "CA").order(:lastname).each do |s|
  puts "  #{s.firstname} #{s.middlename} #{s.lastname} (#{s.party})".squeeze(" ")
end

puts "Representatives:"
Representative.where(state: "CA").order(:lastname).each do |r|
	puts "  #{r.firstname} #{r.middlename} #{r.lastname} (#{r.party})".squeeze(" ")
end
