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

require 'open-uri'

Photo.delete_all
Word.delete_all

img_array = ['Abstract','Builder','Factory','Prototype','Singleton','Adapter','Bridge','Composite','Decorator','Facade','Flyweight','Proxy','Responsibility','Command','Interpreter','Iterator','Mediator','Memento','Observer','State','Strategy','Template','Visitor']

count = img_array.length
img_array_index = 0

while img_array_index < count

	photos = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=random&method=flickr.photos.search&tags=#{img_array[img_array_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
	sleep(2)	
		# puts photos['photos']['photo'].length
			i = 0
			temp_word = Word.create(name: img_array[img_array_index])
			unless photos.empty?
				while i < img_array[img_array_index].length

					if photos['photos'] && photos['photos']['photo'] && photos['photos']['photo'][i]
						farmId = photos['photos']['photo'][i]['farm']

						serverId = photos['photos']['photo'][i]['server']
								 
						id = photos['photos']['photo'][i]['id'];

						secret = photos['photos']['photo'][i]['secret']
						           

						imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"


					
					# if HTTParty.get()
						temp_word.photos << Photo.create(url: imgUrl)
					end
					i += 1

				end
			end
	img_array_index += 1
end