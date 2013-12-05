# FLOSSWORDS

![Flosswords icon](http://glumac.net/flosswordsredsmall.png)

####Description:

** Flosswords is a dynamically generated crossword puzzle created with words from today's New York Times headlines and picture clues from Flickr. It can be played at   [Flosswords.com](http://www.flowsswords.com) **

#####Flosswords is Ruby application comprised of five main elements: 
1. A Nokogiri scrape, that collects words daily from New York Times headlines (and also, for the moment, Google News). These results are filtered to exclude common and other undesirable words.
2. Interface with the Flickr.com API. URLs for photo clues that have been tagged with wordsfrom the daily scrape are stored in a database. Currently the game uses Getty images that have uploaded to flickr, as they tend to make better clues. 
3. A crossword weaver, which takes the array of topical words, and turns places them on a grid connected through common letters.  The crossword weaver is configured to run muliple times to create a game with more crossing points.  
4. A game engine, which facilitates gameplay and scoring on grid of words created by the crossword weaver. 
5. A database of high scores, that records the names and point totals of the game's most succesful players.  


#####Gems
* Rails
* Nokogiri 
* HttParty

#####Javascript Resources
*  <http://www.softwaresecretweapons.com/jspwiki/cword>
*  <http://www.startup-something.com/files/cross.html>
*  <http://qtip2.com/>

