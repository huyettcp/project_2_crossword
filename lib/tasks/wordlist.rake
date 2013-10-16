
namespace :wordlist do
      desc "Generate wordlist"
      task :seed => :environment do

        require 'nokogiri'
        require 'open-uri'

        Photo.delete_all
        Word.delete_all

        puts "Welcome to the Crossword"


        # categories = ["front", "sports"]

        # categories.each do |x|
        #    x = business
        #  end


        exclude_words = ["a", "and", "are", "but", "it", "I", "you", "he", "they", "we", "she", "who", "them", "me", "him", "one", "her", "us", "something", "nothing", "anything", "himself", "everything", "someone", "themselves", "everyone", "itself", "anyone", "myself",'the','be','to','of','and','a','in','that','have','I','it','for','not','on','with','he','as','you','do','at','this','but','his','by','from','they','we','say','her','she','or','an','will','my','one','all','would','there','their','what','so','up','out','if','about','who','get','which','go','me','when','make','can','like','time','no','just','him','know','take','person','into','year','your','good','some','could','them','see','other','than','then','now','look','only','come','its','over','think','also','back','after','use','two','how','our','work','first','well','way','even','new','want','because','any','these','give','day','most','us']
        
        # sports_page = Nokogiri::HTML(open("http://www.nytimes.com/pages/sports/index.html"))
        # sports_story_text = sports_page.css('h1','h2', 'h5', 'h3').text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
        # sports_arr = []
        # sports_arr.push sports_story_text.split(" ")
        # sports_arr = sports_arr.flatten.uniq
        # sports_arr.delete_if { |x| x.length <= 3 || exclude_words.include?(x)}
        # count_sports = sports_arr.length
        # sports_arr_index = 0

    #   while sports_arr_index < count_sports

    #       photos_sports = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=random&method=flickr.photos.search&tags=#{sports_arr[sports_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
    #         counter_sports = 0
    #         sport_word = Word.create(name: sports_arr[sports_arr_index])
    #         unless photos_sports.empty?
    #           while counter_sports < sports_arr[sports_arr_index].length
    #             if photos_sports['photos'] && photos_sports['photos']['photo'] && photos_sports['photos']['photo'][counter_sports]
    #               farmId = photos_sports['photos']['photo'][counter_sports]['farm']
    #               serverId = photos_sports['photos']['photo'][counter_sports]['server']    
    #               id = photos_sports['photos']['photo'][counter_sports]['id'];
    #               secret = photos_sports['photos']['photo'][counter_sports]['secret']
    #               imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"
                
    #               sport_word.photos << Photo.create(url: imgUrl)
    #             end
    #           counter_sports += 1
    #           end
    #     end
    #     sports_arr_index += 1
    # end
      
      front_page = Nokogiri::HTML(open("http://www.nytimes.com/"))
      front_story_text = front_page.css('h1','h2', 'h5', 'h3').text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
      front_arr = []
      front_arr.push front_story_text.split(" ")
      front_arr = front_arr.flatten.uniq
      front_arr.delete_if { |x| x.length <= 3 || exclude_words.include?(x)}
      count_front = front_arr.length
      front_arr_index = 0
      
      while front_arr_index < count_front

          photos_front = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=random&method=flickr.photos.search&tags=#{front_arr[front_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
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
                
                  front_word.photos << Photo.create(url: imgUrl)
                end
              counter_front += 1
              end
        end
        front_arr_index += 1
    end
 
  #   business_page = Nokogiri::HTML(open("http://www.nytimes.com/pages/business/index.html"))
  #   business_story_text = business_page.css('h1','h2', 'h5', 'h3').text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
  #   business_arr = []
  #   business_arr.push business_story_text.split(" ")
  #   business_arr = business_arr.flatten.uniq
  #   business_arr.delete_if { |x| x.length <= 3 || exclude_words.include?(x)}
  #   count_business = business_arr.length
  #   business_arr_index = 0
  #       while business_arr_index < count_business

  #       photos_business = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=random&method=flickr.photos.search&tags=#{business_arr[business_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
  #         counter_business = 0
  #         business_word = Word.create(name: business_arr[business_arr_index])
  #         unless photos_business.empty?
  #           while counter_business < business_arr[business_arr_index].length
  #             if photos_business['photos'] && photos_business['photos']['photo'] && photos_business['photos']['photo'][counter_business]
  #               farmId = photos_business['photos']['photo'][counter_business]['farm']
  #               serverId = photos_business['photos']['photo'][counter_business]['server']    
  #               id = photos_business['photos']['photo'][counter_business]['id'];
  #               secret = photos_business['photos']['photo'][counter_business]['secret']
  #               imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"
                
  #               business_word.photos << Photo.create(url: imgUrl)
  #             end
  #           counter_business += 1
  #           end
  #     end
  #     business_arr_index += 1
  #   end

  #   technology_page = Nokogiri::HTML(open("http://www.nytimes.com/pages/technology/index.html"))
  #   technology_story_text = technology_page.css('h1','h2', 'h5', 'h3').text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
  #   technology_arr = []
  #   technology_arr.push technology_story_text.split(" ")
  #   technology_arr = technology_arr.flatten.uniq
  #   technology_arr.delete_if { |x| x.length <= 3 || exclude_words.include?(x)}
  #   count_technology = technology_arr.length
  #   technology_arr_index = 0
  #       while technology_arr_index < count_technology

  #       photos_technology = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=random&method=flickr.photos.search&tags=#{technology_arr[technology_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
  #         counter_technology = 0
  #         technology_word = Word.create(name: technology_arr[technology_arr_index])
  #         unless photos_technology.empty?
  #           while counter_technology < technology_arr[technology_arr_index].length
  #             if photos_technology['photos'] && photos_technology['photos']['photo'] && photos_technology['photos']['photo'][counter_technology]
  #               farmId = photos_technology['photos']['photo'][counter_technology]['farm']
  #               serverId = photos_technology['photos']['photo'][counter_technology]['server']    
  #               id = photos_technology['photos']['photo'][counter_technology]['id'];
  #               secret = photos_technology['photos']['photo'][counter_technology]['secret']
  #               imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"
                
  #               technology_word.photos << Photo.create(url: imgUrl)
  #             end
  #           counter_technology += 1
  #           end
  #     end
  #     technology_arr_index += 1
  #   end
  #   arts_page = Nokogiri::HTML(open("http://www.nytimes.com/pages/arts/index.html"))
  #   arts_story_text = arts_page.css('h1','h2', 'h5', 'h3').text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
  #   arts_arr = []
  #   arts_arr.push arts_story_text.split(" ")
  #   arts_arr = arts_arr.flatten.uniq
  #   arts_arr.delete_if { |x| x.length <= 3 || exclude_words.include?(x)}
  #   count_arts = arts_arr.length
  #   arts_arr_index = 0
  #       while arts_arr_index < count_arts

  #       photos_arts = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=random&method=flickr.photos.search&tags=#{arts_arr[arts_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
  #         counter_arts = 0
  #         arts_word = Word.create(name: arts_arr[arts_arr_index])
  #         unless photos_arts.empty?
  #           while counter_arts < arts_arr[arts_arr_index].length
  #             if photos_arts['photos'] && photos_arts['photos']['photo'] && photos_arts['photos']['photo'][counter_arts]
  #               farmId = photos_arts['photos']['photo'][counter_arts]['farm']
  #               serverId = photos_arts['photos']['photo'][counter_arts]['server']    
  #               id = photos_arts['photos']['photo'][counter_arts]['id'];
  #               secret = photos_arts['photos']['photo'][counter_arts]['secret']
  #               imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"
                
  #               arts_word.photos << Photo.create(url: imgUrl)
  #             end
  #           counter_arts += 1
  #           end
  #     end
  #     arts_arr_index += 1
  #   end
  #   science_page = Nokogiri::HTML(open("http://www.nytimes.com/pages/science/index.html"))
  #   science_story_text = science_page.css('h1','h2', 'h5', 'h3').text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
  #   science_arr = []
  #   science_arr.push science_story_text.split(" ")
  #   science_arr = science_arr.flatten.uniq
  #   science_arr.delete_if { |x| x.length <= 3 || exclude_words.include?(x)}
  #   count_science = science_arr.length
  #   science_arr_index = 0
  #       while science_arr_index < count_science

  #       photos_science = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=random&method=flickr.photos.search&tags=#{science_arr[science_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
  #         counter_science = 0
  #         science_word = Word.create(name: science_arr[science_arr_index])
  #         unless photos_science.empty?
  #           while counter_science < science_arr[science_arr_index].length
  #             if photos_science['photos'] && photos_science['photos']['photo'] && photos_science['photos']['photo'][counter_science]
  #               farmId = photos_science['photos']['photo'][counter_science]['farm']
  #               serverId = photos_science['photos']['photo'][counter_science]['server']    
  #               id = photos_science['photos']['photo'][counter_science]['id'];
  #               secret = photos_science['photos']['photo'][counter_science]['secret']
  #               imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"
                
  #               science_word.photos << Photo.create(url: imgUrl)
  #             end
  #           counter_science += 1
  #           end
  #     end
  #     science_arr_index += 1
  #   end

  #   movies_page = Nokogiri::HTML(open("http://www.nytimes.com/pages/movies/index.html"))
  #   movies_story_text = movies_page.css('h1','h2', 'h5', 'h3').text.gsub("\"", " ").gsub("\n"," ").gsub!(/\W+/, " ").gsub(/(?<=[a-z])(?=[A-Z])/, " ").downcase
  #   movies_arr = []
  #   movies_arr.push movies_story_text.split(" ")
  #   movies_arr = movies_arr.flatten.uniq
  #   movies_arr.delete_if { |x| x.length <= 3 || exclude_words.include?(x)}
  #   count_movies = movies_arr.length
  #   movies_arr_index = 0
  #       while movies_arr_index < count_movies

  #       photos_movies = HTTParty.get("http://api.flickr.com/services/rest/?format=json&sort=random&method=flickr.photos.search&tags=#{movies_arr[movies_arr_index]}&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")
  #         counter_movies = 0
  #         movies_word = Word.create(name: movies_arr[movies_arr_index])
  #         unless photos_movies.empty?
  #           while counter_movies < movies_arr[movies_arr_index].length
  #             if photos_movies['photos'] && photos_movies['photos']['photo'] && photos_movies['photos']['photo'][counter_movies]
  #               farmId = photos_movies['photos']['photo'][counter_movies]['farm']
  #               serverId = photos_movies['photos']['photo'][counter_movies]['server']    
  #               id = photos_movies['photos']['photo'][counter_movies]['id'];
  #               secret = photos_movies['photos']['photo'][counter_movies]['secret']
  #               imgUrl = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{id}_#{secret}.jpg"
                
  #               movies_word.photos << Photo.create(url: imgUrl)
  #             end
  #           counter_movies += 1
  #           end
  #     end
  #     movies_arr_index += 1
  # end


end
end
