

namespace :wordlist do
      desc "Generate wordlist"
      task :seed => :environment do

        require 'nokogiri'
        require 'open-uri'

        # Word.destroy_all()
        Word.destroy_all(["created_at < ?", 2.days.ago])
      
        puts "Flosswords is being seeded. This may take a few moments"

        exclude_words = ["a", "and", "are", "but", "it", "I", "you", "he", "harding" "they", "we", "she", "who", "them", "me", "him", "one", "her", "us", "something", "nothing", "anything", "himself", "everything", "someone", "themselves", "everyone", "itself", "anyone", "myself",'the','be','to','of','and','a','in','that','have','I','it','for','not','on','with','he','as','you','do','at','this','but','his','by','from','they','we','say','her','she','or','an','will','my','one','all','would','there','their','what','so','up','out','if','about','who','get','which','go','me','when','make','can','like','time','no','just','him','know','take','person','into','year','your','good','some','could','them','see','other','than','then','now','look','only','come','its','over','think','also','back','after','use','two','how','our','work','first','well','way','even','new','want','because','any','these','give','day','most','us', 'should', 'exceed', 'puts', 'almost', 'enough']
        exclude_names = ["James", "John", "Robert", "Michael", "William", "David", "Richard", "Joseph", "Charles", "Thomas", "Christopher", "Daniel", "Matthew", "Donald", "Anthony", "Paul", "Mark", "George", "Steven", "Kenneth", "Andrew", "Edward", "Brian", "Joshua", "Kevin", "Ronald", "Timothy", "Jason", "Jeffrey", "Gary", "Ryan", "Nicholas", "Eric", "Stephen","Jacob","Larry","Frank","Jonathan","Scott","Justin","Raymond","Brandon","Gregory","Samuel","Patrick","Benjamin","Jack","Dennis","Jerry","Alexander","Tyler","Douglas","Henry","Peter","Walter","Aaron","Jose","Adam","Harold","Zachary","Nathan","Carl","Kyle","Arthur","Gerald","Lawrence","Roger","Albert","Keith","Jeremy","Terry","Joe","Sean","Willie","Jesse","Ralph","Billy","Austin","Bruce","Christian","Roy","Bryan","Eugene","Louis","Harry","Wayne","Ethan","Jordan","Russell","Alan","Philip","Randy","Juan","Howard","Vincent","Bobby","Dylan","Johnny","Phillip","Craig"]
        exclude_girls_names = ["Mary", "Patricia", "Elizabeth", "Jennifer","Linda","Barbara","Susan","Margaret","Jessica","Dorothy","Sarah","Karen","Nancy","Betty","Lisa","Sandra","Helen","Donna","Ashley","Kimberly","Carol","Michelle","Amanda","Emily","Melissa","Laura","Deborah","Stephanie","Rebecca","Sharon","Cynthia","Ruth","Kathleen","Anna","Shirley","Amy","Angela","Virginia","Brenda","Pamela","Catherine","Katherine","Nicole","Christine","Janet","Debra","Carolyn","Samantha","Rachel","Heather","Maria","Diane","Frances","Joyce","Julie","Martha","Joan","Evelyn","Kelly","Christina","Emma","Lauren","Alice","Judith","Marie","Doris","Ann","Jean","Victoria","Cheryl","Megan","Kathryn","Andrea","Jacqueline","Gloria","Teresa","Janice","Sara","Rose","Julia","Hannah","Theresa","Judy","Mildred","Grace","Beverly","Denise","Marilyn","Amber","Danielle","Brittany","Diana","Jane","Lori","Olivia","Tiffany","Kathy","Tammy","Crystal","Madison"]
    
# ################################### NY TIMES FRONT PAGE ##########################################################
        front_page = Nokogiri::HTML(open("http://www.nytimes.com/"))
        front_story_text = front_page.css('h1','h2', 'h5', 'h3').text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
        front_arr = []
        front_arr.push front_story_text.split(" ")
        front_arr = front_arr.flatten.uniq


        front_arr.delete_if { |x| x.length <= 5 || exclude_words.include?(x) || exclude_names.include?(x) || exclude_girls_names.include?(x) }
        

        ####### This adjusts the amount of words ################
        front_arr = front_arr.sample(200)
        #########################################################

        count_front = front_arr.length
        front_arr_index = 0

    
        while front_arr_index < count_front

            photos_front = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=relevance&method=flickr.photos.search&tags=#{front_arr[front_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
              counter_front = 0
              front_word = Word.create(name: front_arr[front_arr_index])
              
            unless photos_front.empty?
                
                while counter_front < front_arr[front_arr_index].length
                  if photos_front['photos'] && photos_front['photos']['photo'] && photos_front['photos']['photo'][counter_front]
                    farmId = photos_front['photos']['photo'][counter_front]['farm']
                    serverId = photos_front['photos']['photo'][counter_front]['server']    
                    id = photos_front['photos']['photo'][counter_front]['id'];
                    secret = photos_front['photos']['photo'][counter_front]['secret']
                    imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"
                
                    puts imgUrl
                    puts imgUrl.length
                    
                    front_word.photos << Photo.create(url: imgUrl)

                  end
                  counter_front += 1
                end

                if front_word.photos.empty?
                    front_word.destroy
                end
            end
          front_arr_index += 1
        end


################## GOOGLE NEWS FRONTPAGE #####################################################################      

        google_news = Nokogiri::HTML(open("https://news.google.com/"))
        google_news_text = google_news.css(".titletext").text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
        google_arr = []
        google_arr.push google_news_text.split(" ")
        google_arr = google_arr.flatten.uniq

        google_arr.delete_if { |x| x.length <= 2 || exclude_words.include?(x) || exclude_names.include?(x) || exclude_girls_names.include?(x) }

        google_arr = google_arr.sample(200)
        count_google = google_arr.length
        google_arr_index = 0
     
        
        while google_arr_index < count_google

            photos_google = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=relevance&method=flickr.photos.search&tags=#{google_arr[google_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
              counter_google = 0
              google_word = Word.create(name: google_arr[google_arr_index])
              unless photos_google.empty?
                while counter_google < google_arr[google_arr_index].length
                  if photos_google['photos'] && photos_google['photos']['photo'] && photos_google['photos']['photo'][counter_google]
                    farmId = photos_google['photos']['photo'][counter_google]['farm']
                    serverId = photos_google['photos']['photo'][counter_google]['server']    
                    id = photos_google['photos']['photo'][counter_google]['id'];
                    secret = photos_google['photos']['photo'][counter_google]['secret']
                    imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"
                  

                        google_word.photos << Photo.create(url: imgUrl)
                    

                  end
                counter_google += 1
                end
                if google_word.photos.empty?
                    google_word.destroy
                end
          end
          google_arr_index += 1
        end

###################### NY TIMES SPORTS FRONT PAGE ##############################################################


        sports_page = Nokogiri::HTML(open("http://www.nytimes.com/pages/sports/index.html"))
        sports_story_text = sports_page.css('h1','h2', 'h5', 'h3').text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
        sports_arr = []
        sports_arr.push sports_story_text.split(" ")
        sports_arr = sports_arr.flatten.uniq
        sports_arr.delete_if { |x| x.length <= 4 || exclude_words.include?(x)}
        sports_arr = sports_arr.sample(10)
        count_sports = sports_arr.length
        sports_arr_index = 0

        
        while sports_arr_index < count_sports

          photos_sports = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=relevance&per_page=50&page=1&method=flickr.photos.search&tags=#{sports_arr[sports_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
                counter_sports = 0
                sport_word = Word.create(name: sports_arr[sports_arr_index])
                unless photos_sports.empty?
                  while counter_sports < sports_arr[sports_arr_index].length
                    if photos_sports['photos'] && photos_sports['photos']['photo'] && photos_sports['photos']['photo'][counter_sports]
                      farmId = photos_sports['photos']['photo'][counter_sports]['farm']
                      serverId = photos_sports['photos']['photo'][counter_sports]['server']    
                      id = photos_sports['photos']['photo'][counter_sports]['id'];
                      secret = photos_sports['photos']['photo'][counter_sports]['secret']
                      imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"
                    
                      sport_word.photos << Photo.create(url: imgUrl)
                    end
                  counter_sports += 1
                  end
                end
                sports_arr_index += 1
            end



end

end
