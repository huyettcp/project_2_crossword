# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# test_words = ["sausage","blubber","pencil","cloud","moon","water","computer","school","network","hammer","walking","violently","mediocre","literature","chair","two","window","cords","musical","zebra","xylophone","penguin","home","dog","final","ink","teacher","fun","website","banana","uncle","softly","mega","ten","awesome","attatch","blue","internet","bottle","tight","zone","tomato","prison","hydro","cleaning","telivision","send","frog","cup","book","zooming","falling","evily","gamer","lid","juice","moniter","captain","bonding","loudly","thudding","guitar","shaving","hair","soccer","water","racket","table","late","media","desktop","flipper","club","flying","smooth","monster","purple","guardian","bold","hyperlink","presentation","world","national","comment","element","magic","lion","sand","crust","toast","jam","hunter","forest","foraging","silently","joshing","pong"]

# test_words.each do |name|
#   Word.create(name: name)
# end

Photo.delete_all
Word.delete_all

complaint_record = HTTParty.get('http://data.cityofnewyork.us/resource/erm2-nwe9.json')


complaint_record.each do |complaint_record|

	new_complaint = Complaint.new

	new_complaint.address = complaint_record['incident_address']
	new_complaint.zip = complaint_record['incident_zip']
	new_complaint.latitude = complaint_record['latitude']
	new_complaint.longitude = complaint_record['longitude']
	new_complaint.descriptor = complaint_record['descriptor']

	unless new_complaint.save 
		puts "complaint ingnored"
	end
end