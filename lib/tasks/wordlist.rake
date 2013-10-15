
namespace :wordlist do
      desc "Generate wordlist"
      task :seed => :environment do

        require 'nokogiri'
        require 'open-uri'

        Photo.delete_all
        Word.delete_all

        puts "Welcome to the Crossword"

        exclude_words = ["a", "and", "are", "but", "it", "I", "you", "he", "they", "we", "she", "who", "them", "me", "him", "one", "her", "us", "something", "nothing", "anything", "himself", "everything", "someone", "themselves", "everyone", "itself", "anyone", "myself",'the','be','to','of','and','a','in','that','have','I','it','for','not','on','with','he','as','you','do','at','this','but','his','by','from','they','we','say','her','she','or','an','will','my','one','all','would','there','their','what','so','up','out','if','about','who','get','which','go','me','when','make','can','like','time','no','just','him','know','take','person','into','year','your','good','some','could','them','see','other','than','then','now','look','only','come','its','over','think','also','back','after','use','two','how','our','work','first','well','way','even','new','want','because','any','these','give','day','most','us']
        sports_page = Nokogiri::HTML(open("http://www.nytimes.com/pages/sports/index.html"))
        sports_story_text = sports_page.css('h1','h2', 'h5', 'h3').text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
        sports_arr = []
        sports_arr.push sports_story_text.split(" ")
        sports_arr = sports_arr.flatten.uniq
        sports_arr.delete_if { |x| x.length <= 3 || exclude_words.include?(x)}
        count = sports_arr.length
        sports_arr_index = 0

      while sports_arr_index < count

          photos_sports = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=random&method=flickr.photos.search&tags=#{sports_arr[sports_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
            i = 0
            sport_word = Word.create(name: sports_arr[sports_arr_index])
            unless photos_sports.empty?
              while i < sports_arr[sports_arr_index].length
                if photos_sports['photos'] && photos_sports['photos']['photo'] && photos_sports['photos']['photo'][i]
                  farmId = photos_sports['photos']['photo'][i]['farm']
                  serverId = photos_sports['photos']['photo'][i]['server']    
                  id = photos_sports['photos']['photo'][i]['id'];
                  secret = photos_sports['photos']['photo'][i]['secret']
                  imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"
                
                  sport_word.photos << Photo.create(url: imgUrl)
                end
              i += 1
              end
        end
        sports_arr_index += 1
    end
  end
end
