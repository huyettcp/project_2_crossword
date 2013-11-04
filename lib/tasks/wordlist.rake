
namespace :wordlist do
      desc "Generate wordlist"
      task :seed => :environment do

        require 'nokogiri'
        require 'open-uri'

        Photo.delete_all
        Word.delete_all

        

        puts "Flosswords is being seeded. This may take a few moments"


        # categories = ["front", "sports"]

        # categories.each do |x|
        #    x = business
        #  end


        
        exclude_words = ["a", "and", "are", "but", "it", "I", "you", "he", "they", "we", "she", "who", "them", "me", "him", "one", "her", "us", "something", "nothing", "anything", "himself", "everything", "someone", "themselves", "everyone", "itself", "anyone", "myself",'the','be','to','of','and','a','in','that','have','I','it','for','not','on','with','he','as','you','do','at','this','but','his','by','from','they','we','say','her','she','or','an','will','my','one','all','would','there','their','what','so','up','out','if','about','who','get','which','go','me','when','make','can','like','time','no','just','him','know','take','person','into','year','your','good','some','could','them','see','other','than','then','now','look','only','come','its','over','think','also','back','after','use','two','how','our','work','first','well','way','even','new','want','because','any','these','give','day','most','us', 'should', 'exceed', 'puts', 'almost', 'enough']
        exclude_names = ["James", "John", "Robert", "Michael", "William", "David", "Richard", "Joseph", "Charles", "Thomas", "Christopher", "Daniel", "Matthew", "Donald", "Anthony", "Paul", "Mark", "George", "Steven", "Kenneth", "Andrew", "Edward", "Brian", "Joshua", "Kevin", "Ronald", "Timothy", "Jason", "Jeffrey", "Gary", "Ryan", "Nicholas", "Eric", "Stephen","Jacob","Larry","Frank","Jonathan","Scott","Justin","Raymond","Brandon","Gregory","Samuel","Patrick","Benjamin","Jack","Dennis","Jerry","Alexander","Tyler","Douglas","Henry","Peter","Walter","Aaron","Jose","Adam","Harold","Zachary","Nathan","Carl","Kyle","Arthur","Gerald","Lawrence","Roger","Albert","Keith","Jeremy","Terry","Joe","Sean","Willie","Jesse","Ralph","Billy","Austin","Bruce","Christian","Roy","Bryan","Eugene","Louis","Harry","Wayne","Ethan","Jordan","Russell","Alan","Philip","Randy","Juan","Howard","Vincent","Bobby","Dylan","Johnny","Phillip","Craig"]
        exclude_girls_names = ["Mary", "Patricia", "Elizabeth", "Jennifer","Linda","Barbara","Susan","Margaret","Jessica","Dorothy","Sarah","Karen","Nancy","Betty","Lisa","Sandra","Helen","Donna","Ashley","Kimberly","Carol","Michelle","Amanda","Emily","Melissa","Laura","Deborah","Stephanie","Rebecca","Sharon","Cynthia","Ruth","Kathleen","Anna","Shirley","Amy","Angela","Virginia","Brenda","Pamela","Catherine","Katherine","Nicole","Christine","Janet","Debra","Carolyn","Samantha","Rachel","Heather","Maria","Diane","Frances","Joyce","Julie","Martha","Joan","Evelyn","Kelly","Christina","Emma","Lauren","Alice","Judith","Marie","Doris","Ann","Jean","Victoria","Cheryl","Megan","Kathryn","Andrea","Jacqueline","Gloria","Teresa","Janice","Sara","Rose","Julia","Hannah","Theresa","Judy","Mildred","Grace","Beverly","Denise","Marilyn","Amber","Danielle","Brittany","Diana","Jane","Lori","Olivia","Tiffany","Kathy","Tammy","Crystal","Madison"]
        sampler = (0..30).to_a;
    
#Front page with sampler        
        # front_page = Nokogiri::HTML(open("http://www.nytimes.com/"))
        # front_story_text = front_page.css('h1','h2', 'h5', 'h3').text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
        # front_arr = []
        # front_arr.push front_story_text.split(" ")
        # front_arr = front_arr.flatten.uniq
        # front_arr.delete_if { |x| x.length <= 4 || exclude_words.include?(x) || exclude_names.include?(x) || exclude_girls_names.include?(x) }
        # front_arr = front_arr.sample(150)
        # count_front = front_arr.length
        # front_arr_index = 0

    
        
        
        # while front_arr_index < count_front

        #     photos_front = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=relevance&per_page=50&page=1&method=flickr.photos.search&tags=#{front_arr[front_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
        #       counter_front = 0
        #       front_word = Word.create(name: front_arr[front_arr_index])
        #       unless photos_front.empty?
        #         while counter_front < front_arr[front_arr_index].length
        #             front_samp = sampler.sample;
        #           if photos_front['photos'] && photos_front['photos']['photo'] && photos_front['photos']['photo'][counter_front]
        #             farmId = photos_front['photos']['photo'][front_samp]['farm']
        #             serverId = photos_front['photos']['photo'][front_samp]['server']    
        #             id = photos_front['photos']['photo'][front_samp]['id'];
        #             secret = photos_front['photos']['photo'][front_samp]['secret']
        #             imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"
                  
        #             front_word.photos << Photo.create(url: imgUrl)
        #           end
        #         counter_front += 1
        #         end
        #   end
        #   front_arr_index += 1
        # end

#Google with sampler
        # google_news = Nokogiri::HTML(open("https://news.google.com/"))
        # google_news_text = google_news.css(".titletext").text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
        # google_arr = []
        # google_arr.push google_news_text.split(" ")
        # google_arr = google_arr.flatten.uniq
        # google_arr.delete_if { |x| x.length <= 4 || exclude_words.include?(x) || exclude_names.include?(x) || exclude_girls_names.include?(x) }
        # google_arr = google_arr.sample(150)
        # count_google = google_arr.length
        # google_arr_index = 0
     
        
        # while google_arr_index < count_google

        #     photos_google = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=relevance&per_page=50&page=1&method=flickr.photos.search&tags=#{google_arr[google_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
        #       counter_google = 0
        #       google_word = Word.create(name: google_arr[google_arr_index])
        #       unless photos_google.empty?
        #         while counter_google < google_arr[google_arr_index].length
        #             google_samp = sampler.sample;
        #           if photos_google['photos'] && photos_google['photos']['photo'] && photos_google['photos']['photo'][counter_google]
        #             farmId = photos_google['photos']['photo'][google_samp]['farm']
        #             serverId = photos_google['photos']['photo'][google_samp]['server']    
        #             id = photos_google['photos']['photo'][google_samp]['id'];
        #             secret = photos_google['photos']['photo'][google_samp]['secret']
        #             imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"
                  
        #             google_word.photos << Photo.create(url: imgUrl)
        #           end
        #         counter_google += 1
        #         end
        #   end
        #   google_arr_index += 1
        # end


        # sports_page = Nokogiri::HTML(open("http://www.nytimes.com/pages/sports/index.html"))
        # sports_story_text = sports_page.css('h1','h2', 'h5', 'h3').text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
        # sports_arr = []
        # sports_arr.push sports_story_text.split(" ")
        # sports_arr = sports_arr.flatten.uniq
        # sports_arr.delete_if { |x| x.length <= 4 || exclude_words.include?(x)}
        # sports_arr = sports_arr.sample(50)
        # count_sports = sports_arr.length
        # sports_arr_index = 0

        
        # while sports_arr_index < count_sports

        #   photos_sports = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=relevance&per_page=50&page=1&method=flickr.photos.search&tags=#{sports_arr[sports_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
        #     #if photos_sports.length >= 30 
        #         counter_sports = 0
        #         sport_word = Word.create(name: sports_arr[sports_arr_index])
        #         unless photos_sports.empty?
        #           while counter_sports < sports_arr[sports_arr_index].length
        #             sports_samp = sampler.sample;
        #             if photos_sports['photos'] && photos_sports['photos']['photo'] && photos_sports['photos']['photo'][sports_samp]
        #               farmId = photos_sports['photos']['photo'][sports_samp]['farm']
        #               serverId = photos_sports['photos']['photo'][sports_samp]['server']    
        #               id = photos_sports['photos']['photo'][sports_samp]['id'];
        #               secret = photos_sports['photos']['photo'][sports_samp]['secret']
        #               imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"
                    
        #               sport_word.photos << Photo.create(url: imgUrl)
        #             end
        #           counter_sports += 1
        #           end
        #         end
        #         sports_arr_index += 1
        #     end












 
    # business_page = Nokogiri::HTML(open("http://www.nytimes.com/pages/business/index.html"))
    # business_story_text = business_page.css('h1','h2', 'h5', 'h3').text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
    # business_arr = []
    # business_arr.push business_story_text.split(" ")
    # business_arr = business_arr.flatten.uniq
    # business_arr.delete_if { |x| x.length <= 3 || exclude_words.include?(x)}
    # business_arr = business_arr.sample(150)
    # count_business = business_arr.length
    # business_arr_index = 0
    #     while business_arr_index < count_business

        
    #     photos_business = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=relevance&method=flickr.photos.search&tags=#{business_arr[business_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
    #       counter_business = 0
    #       business_word = Word.create(name: business_arr[business_arr_index])
    #       unless photos_business.empty?
    #         while counter_business < business_arr[business_arr_index].length
    #           if photos_business['photos'] && photos_business['photos']['photo'] && photos_business['photos']['photo'][counter_business]
    #             farmId = photos_business['photos']['photo'][counter_business]['farm']
    #             serverId = photos_business['photos']['photo'][counter_business]['server']    
    #             id = photos_business['photos']['photo'][counter_business]['id'];
    #             secret = photos_business['photos']['photo'][counter_business]['secret']
    #             imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"
                
    #             business_word.photos << Photo.create(url: imgUrl)
    #           end
    #         counter_business += 1
    #         end
    #   end
    #   business_arr_index += 1
    # end

    # technology_page = Nokogiri::HTML(open("http://www.nytimes.com/pages/technology/index.html"))
    # technology_story_text = technology_page.css('h1','h2', 'h5', 'h3').text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
    # technology_arr = []
    # technology_arr.push technology_story_text.split(" ")
    # technology_arr = technology_arr.flatten.uniq
    # technology_arr.delete_if { |x| x.length <= 3 || exclude_words.include?(x)}
    # count_technology = technology_arr.length
    # technology_arr_index = 0
    #     while technology_arr_index < count_technology

    #     photos_technology = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=random&method=flickr.photos.search&tags=#{technology_arr[technology_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
    #       counter_technology = 0
    #       technology_word = Word.create(name: technology_arr[technology_arr_index])
    #       unless photos_technology.empty?
    #         while counter_technology < technology_arr[technology_arr_index].length
    #           if photos_technology['photos'] && photos_technology['photos']['photo'] && photos_technology['photos']['photo'][counter_technology]
    #             farmId = photos_technology['photos']['photo'][counter_technology]['farm']
    #             serverId = photos_technology['photos']['photo'][counter_technology]['server']    
    #             id = photos_technology['photos']['photo'][counter_technology]['id'];
    #             secret = photos_technology['photos']['photo'][counter_technology]['secret']
    #             imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"
                
    #             technology_word.photos << Photo.create(url: imgUrl)
    #           end
    #         counter_technology += 1
    #         end
    #   end
    #   technology_arr_index += 1
    # end
        



        # google_news = Nokogiri::HTML(open("https://news.google.com/"))
        # google_news_text = google_news.css(".titletext").text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
        # google_arr = []
        # google_arr.push google_news_text.split(" ")
        # google_arr = google_arr.flatten.uniq

        # google_arr.delete_if { |x| x.length <= 4 || exclude_words.include?(x) || exclude_names.include?(x) || exclude_girls_names.include?(x) }

        # google_arr = google_arr.sample(150)
        # count_google = google_arr.length
        # google_arr_index = 0
     
        
        # while google_arr_index < count_google

        #     photos_google = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=relevance&method=flickr.photos.search&tags=#{google_arr[google_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
        #       counter_google = 0
        #       google_word = Word.create(name: google_arr[google_arr_index])
        #       unless photos_google.empty?
        #         while counter_google < google_arr[google_arr_index].length
        #           if photos_google['photos'] && photos_google['photos']['photo'] && photos_google['photos']['photo'][counter_google]
        #             farmId = photos_google['photos']['photo'][counter_google]['farm']
        #             serverId = photos_google['photos']['photo'][counter_google]['server']    
        #             id = photos_google['photos']['photo'][counter_google]['id'];
        #             secret = photos_google['photos']['photo'][counter_google]['secret']
        #             imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"
                  

        #                 google_word.photos << Photo.create(url: imgUrl)
                    

        #             end

        #           end
        #         counter_google += 1
        #         end
        #   end
        #   google_arr_index += 1
        # end




        front_page = Nokogiri::HTML(open("http://www.nytimes.com/"))
        front_story_text = front_page.css('h1','h2', 'h5', 'h3').text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
        front_arr = []
        front_arr.push front_story_text.split(" ")
        front_arr = front_arr.flatten.uniq
        front_arr.delete_if { |x| x.length <= 4 || exclude_words.include?(x) || exclude_names.include?(x) || exclude_girls_names.include?(x) }
        front_arr = front_arr.sample(100)
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

   #     photos_business = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=relevance&method=flickr.photos.search&tags=#{business_arr[business_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
    #       counter_business = 0
    #       business_word = Word.create(name: business_arr[business_arr_index])
    #       unless photos_business.empty?
    #         while counter_business < business_arr[business_arr_index].length
    #           if photos_business['photos'] && photos_business['photos']['photo'] && photos_business['photos']['photo'][counter_business]
    #             farmId = photos_business['photos']['photo'][counter_business]['farm']
    #             serverId = photos_business['photos']['photo'][counter_business]['server']    
    #             id = photos_business['photos']['photo'][counter_business]['id'];
    #             secret = photos_business['photos']['photo'][counter_business]['secret']
    #             imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"
                
    #             business_word.photos << Photo.create(url: imgUrl)
    #           end
    #         counter_business += 1
    #         end
    #   end
    #   business_arr_index += 1
    # end
        





        # sports_page = Nokogiri::HTML(open("http://www.nytimes.com/pages/sports/index.html"))
        # sports_story_text = sports_page.css('h1','h2', 'h5', 'h3').text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
        # sports_arr = []
        # sports_arr.push sports_story_text.split(" ")
        # sports_arr = sports_arr.flatten.uniq
        # sports_arr.delete_if { |x| x.length <= 4 || exclude_words.include?(x)}
        # sports_arr = sports_arr.sample(50)
        # count_sports = sports_arr.length
        # sports_arr_index = 0

        
        # while sports_arr_index < count_sports

        #   photos_sports = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=relevance&per_page=50&page=1&method=flickr.photos.search&tags=#{sports_arr[sports_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
        #     #if photos_sports.length >= 30 
        #         counter_sports = 0
        #         sport_word = Word.create(name: sports_arr[sports_arr_index])
        #         unless photos_sports.empty?
        #           while counter_sports < sports_arr[sports_arr_index].length
        #             sports_samp = sampler.sample;
        #             if photos_sports['photos'] && photos_sports['photos']['photo'] && photos_sports['photos']['photo'][sports_samp]
        #               farmId = photos_sports['photos']['photo'][sports_samp]['farm']
        #               serverId = photos_sports['photos']['photo'][sports_samp]['server']    
        #               id = photos_sports['photos']['photo'][sports_samp]['id'];
        #               secret = photos_sports['photos']['photo'][sports_samp]['secret']
        #               imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"
                    
        #               sport_word.photos << Photo.create(url: imgUrl)
        #             end
        #           counter_sports += 1
        #           end
        #         end
        #         sports_arr_index += 1
        #     end



end

end
