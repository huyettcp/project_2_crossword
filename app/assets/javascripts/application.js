// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require oyPrologue.js
//= require oyJsrAjax.js
//= require oyClue.js
//= require oyMenu.js
//= require oyPuzzle.js
//= require oyServer.js
//= require oySign.js
//= require oyMisc.js
//= require_self
//= require oyEpilogue.js


		var oygCrosswordPuzzle = new oyCrosswordPuzzle(
		  "4284200891058970402",
		  "./oy-cword-1.0",
		  "/a/b",
		  "Spell Basic Colors Crossword",
		  "Do you know how to spell these basic colors?",
		  [
			 new oyCrosswordClue(3, "<span style='width: 40px; height: 20px; border: solid 1px; color: red; background-color:red'>_____</span>", "red", "eb54763de2391d9901a7597150406698", 1, 8, 3)
			,new oyCrosswordClue(4, "<span style='width: 40px; height: 20px; border: solid 1px; color: blue; background-color:blue'>_____</span>", "blue", "ab1009df29473bcde9778bcf564c84d7", 1, 7, 8)
			,new oyCrosswordClue(6, "<span style='width: 40px; height: 20px; border: solid 1px; color: yellow; background-color:yellow'>_____</span>", "yellow", "31b145c2ebd6bf38955b13e7c7d096fa", 1, 10, 3)
			,new oyCrosswordClue(5, "<span style='width: 40px; height: 20px; border: solid 1px; color: green; background-color:green'>_____</span>", "green", "626e1c1e9306fd971da7360a09a02f85", 1, 5, 5)
			,new oyCrosswordClue(6, "<span style='width: 40px; height: 20px; border: solid 1px; color: orange; background-color:orange'>_____</span>", "orange", "0ff4eb9950c75af17fcb1ae1688d8b51", 0, 0, 7)
			,new oyCrosswordClue(5, "<span style='width: 40px; height: 20px; border: solid 1px; color: brown; background-color:brown'>_____</span>", "brown", "fd535f54bff48393a781b1b2a0abc7c0", 0, 7, 8)
			,new oyCrosswordClue(6, "<span style='width: 40px; height: 20px; border: solid 1px; color: purple; background-color:purple'>_____</span>", "purple", "e92239e93d42a78abb9a4a67b5c394a2", 1, 1, 5)
			,new oyCrosswordClue(4, "<span style='width: 40px; height: 20px; border: solid 1px; color: pink; background-color:pink'>_____</span>", "pink", "0383091af51c8730456662f3b06a5043", 1, 3, 5)
			,new oyCrosswordClue(4, "<span style='width: 40px; height: 20px; border: solid 1px; color: gold; background-color:gold'>_____</span>", "gold", "30953589d3da29ca65d9c62ca4269a8f", 0, 5, 5)
			,new oyCrosswordClue(4, "<span style='width: 40px; height: 20px; border: solid 1px; color: gray; background-color:gray'>_____</span>", "gray", "19881938de247ab0c8296183afd5040d", 0, 7, 3)
			,new oyCrosswordClue(5, "<span style='width: 40px; height: 20px; border: solid 1px; color: black; background-color:black'>_____</span>", "black", "7a33875a39196cb27e47360b97575084", 0, 7, 0)
			,new oyCrosswordClue(5, "<span style='width: 40px; height: 20px; border: solid 1px; color: white; background-color:white'>_____</span>", "white", "151a62ede960b02781d25b721ce9bd96", 0, 3, 11)
			,new oyCrosswordClue(4, "<span style='width: 40px; height: 20px; border: solid 1px; color: aqua; background-color:aqua'>_____</span>", "aqua", "adf529574955fb36b83752fbad6efd8a", 1, 9, 0)
		  ],
		  12,
		  12
		);

		oygCrosswordPuzzle.publisherName = "by Pavel Simakov";
		oygCrosswordPuzzle.publisherURL = "http://www.softwaresecretweapons.com";

		// game exit URL
		oygCrosswordPuzzle.leaveGameURL = "http://www.cnn.com";  
      
		// this is how to turn off server support; score submission and action tracking will be disabled
		oygCrosswordPuzzle.canTalkToServer = false;
