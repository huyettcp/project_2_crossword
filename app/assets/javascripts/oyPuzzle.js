/*

	CWORD JavaScript Crossword Engine

	Copyright (C) 2007-2010 Pavel Simakov
	http://www.softwaresecretweapons.com/jspwiki/cword

	This library is free software; you can redistribute it and/or
	modify it under the terms of the GNU Lesser General Public
	License as published by the Free Software Foundation; either
	version 2.1 of the License, or (at your option) any later version.

	This library is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
	Lesser General Public License for more details.

	You should have received a copy of the GNU Lesser General Public
	License along with this library; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA

*/

//
// This is a typical puzzle
//

function oyCrosswordPuzzle(
	guid,	// universal identifier for this puzzle in your system, i.e. "12345"
	home,	// relative location of js libraries and image files relative to the main HTML file where puzzle is embedded, i.e. "./oy-cword-1.0"
	ns,		// think of it as of your own 'cookie'; you set it and it is carried all the way to the server when the move is submitted, i.e. "67890"
	title,	// title of the puzzle, i.e. "World's Best Puzzle"
	desc,	// description of the puzzle, i.e. "This is for all puzzle lover's out there..."
	clues,	// array of oyCrosswordClue objects for this puzzle
	w,		// play area width in cells, i.e. "20"
	h		// play area height in cells, i.e. "20"
){
	this.uid = oygNextRandomInt();

	this.guid = guid;		
	this.appHome = home;	
	this.ns = ns;			
    this.title = title;		
	this.desc = desc;		
	this.w = w;				
	this.h = h;
	this.clues = clues;
	
	this.xpos = 0;
	this.ypos = 0;
	
	this.focused = null;

	// direction of focus movement when typing
	this.dir = 0;				
	
	// allow override some things
	this.leaveGameURL = null;
	this.publisherURL = null;
	this.publisherName = null;
	this.canTalkToServer = true;
	
	this.menu = null;
	
	this.canReveal = true;
	this.canCheck = true;
	
	this.reorderClues();
	
	this.started = false;
}

oyCrosswordPuzzle.prototype.reorderClues = function(){ 
 
	// make sure that 2A and 2D are in the same cell so we can use same cell image for both
	var oldClues = [].concat(this.clues);
	var overlap = [];
	for (var i=0; i < this.clues.length; i++){	
		for (var j=0; j < this.clues.length; j++){	
			if (this.clues[i] == null || this.clues[j] == null || i == j){
				continue;
			}
		
			if (
				this.clues[i].xpos == this.clues[j].xpos 
				&& 
				this.clues[i].ypos == this.clues[j].ypos 
			){
				overlap.push(this.clues[i]);
				overlap.push(this.clues[j]); 
				this.clues[i] = null;
				this.clues[j] = null;
			}
		}		
	}

	this.hclues = [];	
	this.vclues = []; 

	for (var i=0; i < overlap.length; i++){	
		if (overlap[i].dir == 0){
			this.hclues.push(overlap[i]);
		} else {
			this.vclues.push(overlap[i]);
		}
	}

	for (var i=0; i < this.clues.length; i++){	
		if (this.clues[i] == null){
			continue;
		}
		if (this.clues[i].dir == 0){
			this.hclues.push(this.clues[i]);
		} else {
			this.vclues.push(this.clues[i]);
		}
	} 
	
	this.clues = oldClues;
}

oyCrosswordPuzzle.prototype.init = function(){ 
	this.hlist = new oyClueList(this, "Across", this.hclues, "oygHClue", "H");
	this.vlist = new oyClueList(this, "Down", this.vclues, "oygVClue", "V");
	
	var oThis = this;	
	  
	document.getElementById("oygHeader").innerHTML = 
		"<span class='oyHeaderTitle'>" + this.title + "</span><br><span class='oyHeaderDesc'>" + this.desc + "</span>";
				 
	var buf = "<table border='0' cellspacing='0' cellpadding='0' width='100%'><tr>";
	buf += "<td class='oyFooter' id='oygFooterStatus' align='left'></td>";
	buf += "<td class='oyFooter' id='oygFooterClock' align='left'></td>";  
	buf += "</tr>";

	var cr = "&nbsp;";	
	if (this.publisherName != null){
		cr = this.publisherName;
	}
	
	buf += "<tr><td class='oyCopyright' colspan='2' align='center'><a class='oysTextLink' id='oygCopyright' href=''>" + cr + "</a></tr>";
	buf += "</table>"; 
	document.getElementById("oygFooter").innerHTML = buf;
	
	document.getElementById("oygCopyright").onclick = function(){
		oThis.menu.leaveGameEarly(oThis.publisherURL);
		return false; 
	}	
  
	// var trackAction = "<img id='oygTrackAction' width='1px' height='1px'>" 	 
	// var target = document.getElementById("oygHeaderMenu");
	// target.innerHTML = trackAction + '<a id="oygHeaderMenuBtn" href=""><img style="padding: 4px;" src="' + this.appHome + '/img/whereto.gif" border="0" alt="Leave Game"></a>';
	 
	// document.getElementById("oygHeaderMenuBtn").onclick = function(){
	// 	oThis.menu.leaveGameEarly(oThis.leaveGameURL);
	// 	return false; 
	// }	
 	
	this.footer = new oyCrosswordFooter(this);		
	this.footer.stateBusy("Starting up...");
 
	this.menu = new oyCrosswordMenu(this);	 
}

oyCrosswordPuzzle.prototype.render = function(){
	var buf = "";
	buf += "<table border='0' cellspacing='0' cellpadding='0' style='border-collapse: collapse;'>";
	
	for (var i=0; i < this.h; i++){	
		var row = "<tr>";
		for (var j=0; j < this.w; j++){	
			row += "<td class='oyCellEmpty' id='oyCell" + j + "_" + i + "'></td>";
		} 
		buf += row + "</tr>";
	}	  
	buf += "</table>"; 	  

	var CELL_H_SIZE = 50;
	var MIN_DIV_WIDTH = 800;
	var divWidth = this.w * CELL_H_SIZE; 
	if (divWidth < MIN_DIV_WIDTH){
		divWidth = MIN_DIV_WIDTH; 
	}
	divWidth += "px";
	 
	var target = document.getElementById("oygPuzzleFooter");
	target.style.width = divWidth;
	
	var target = document.getElementById("oygState");
	target.style.width = divWidth; 
	
	var target = document.getElementById("oygPuzzle");
	target.style.width = divWidth;
	
	target.innerHTML = buf; 	
	
	for (var i=0; i < this.hlist.clues.length; i++){	
		this.renderHorz(this.hlist.clues[i]);
	}
	for (var i=0; i < this.vlist.clues.length; i++){	
		this.renderVert(this.vlist.clues[i]);
	}	
	
	var target = document.getElementById("oygListH");
	target.innerHTML = "";			
	target.className = "oyPanelDivHidden";
	
	var target = document.getElementById("oygListV");
	target.innerHTML = "";
	target.className = "oyPanelDivHidden";	
}

// getUrl = function(i, clue, cell){
// //*********************************Not Grabbing Flickr Images Anymore******************************
// //*************************************************************************************************
// //*************************************************************************************************
	
// 	img_array_index = clue.len;
// 	var img_array = [
// 	'Abstract', 'Builder', 'Factory', 'Prototype', 'Singleton', 'Adapter', 'Bridge', 
// 	'Composite', 'Decorator', 'Facade', 'Flyweight', 'Proxy', 'Responsibility', 'Command',
// 	'Interpreter', 'Iterator', 'Mediator', 'Memento', 'Observer', 'State', 'Strategy',
// 	'Template', 'Visitor'];
// 		// var img_array2 = ["beach", "train", "duck", "snake", "beer", "drugs", "peaople", "sky"]

// 		// $.each(img_array, function(index, tag){
// 			$.getJSON("http://api.flickr.com/services/rest/?format=json&sort=random&method=flickr.photos.search&tags="+img_array[img_array_index]+"&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1",function(data){
// 			// console.log(data)
// 			var farmId = data.photos.photo[i].farm;
// 			var serverId = data.photos.photo[i].server;
// 			var id = data.photos.photo[i].id;
// 			var secret = data.photos.photo[i].secret;     //binds photo URL elements to variables

// 			// console.log(farmId);
// 			// console.log(serverId);
// 			// console.log(id);
// 			// console.log(secret);

// 			imgUrl = "http://farm"+farmId+".staticflickr.com/"+serverId+"/"+id+"_"+secret+".jpg"

// 			cell.style.backgroundImage="url("+imgUrl+")";
// 			cell.style.backgroundSize="46px 46px";
// 			cell.style.backgroundRepeat = "no-repeat";
// 			//cell.innerHTML = "<img src='" + imgUrl + "'width='47px' height='50px' style='z-index: -99999;' />";

// 			// console.log(imgUrl);

// 			return imgUrl;
// 		});
// //*************************************************************************************************
// //*************************************************************************************************
// //*************************************************************************************************
// }

var return_data
databaseGrab = function(oThis) {
	$.ajax({
		dataType: "json",
		type: "GET",
		url: "/word_urls",
		success: function(data) {
			return_data = data
			oThis.puzz.bind();	

			oThis.puzz.hlist.clickItem(0);			
			oThis.installContextMenu();
			
			document.getElementById("oygStatic").innerHTML = "";
			
			oThis.footer.stateOk("");

			startLoad();	
		}
	});
	// return return_data;
}

databaseRenderGrab = function(fnc) {
	var return_data;
	$.ajax({
		dataType: "json",
		type: "GET",
		url: "/word_urls",
		success: function(data) {
			return_data = data
			fnc(data)
			onLoad();
			}	
	});
	return return_data;
}

oyCrosswordPuzzle.prototype.renderVert = function(clue){
	databaseRenderGrab(function(data){
		for (var i = 0; i < clue.len; i++) {
			var key = "oyCell" + clue.xpos + "_" + (clue.ypos + i);
			var cell = document.getElementById(key);
			// console.log(cell)
			cell.className = "oyCellFull";
			cell.className += " black_and_white";
			cell.style.backgroundImage="url("+data[i].photos[4]+")";
			cell.style.backgroundSize="46px 46px";
			} 
		});
	}
oyCrosswordPuzzle.prototype.renderHorz = function(clue){
	databaseRenderGrab(function(data){
		for (var i = 0; i < clue.len; i++){	
			var key = "oyCell" + (clue.xpos + i) + "_" + clue.ypos
			var cell = document.getElementById(key);
			cell.className = "oyCellFull";
			cell.className += " black_and_white";
			cell.style.backgroundImage="url("+data[i].photos[3]+")";
			cell.style.backgroundSize="46px 46px";
			}
		});
	}


oyCrosswordPuzzle.prototype.fillVert = function(clue, idx) {
	
	for (var j = 0; j < return_data.length; j++) {

		if (return_data[j].word == clue.answer) {

			for (var i = 0; i < clue.len; i++) {
				var key = "oyCell" + clue.xpos + "_" + (clue.ypos + i);
				var cell = document.getElementById(key);
				cell.className += " oy-cell-cool";
				cell.classList.remove("black_and_white");
				this.fillIn(cell, clue, clue.xpos, clue.ypos + i, i, j, idx, 1);
				this.menu.setCellState(clue.xpos, clue.ypos + i, 0);
			} 
		}
	}
}


oyCrosswordPuzzle.prototype.fillHorz = function(clue, idx) {
	
	for (var j = 0; j < return_data.length; j++) {


		if (return_data[j].word == clue.answer) {


			for (var i = 0; i < clue.len; i++) {
				var key = "oyCell" + (clue.xpos + i) + "_" + clue.ypos;
				var cell = document.getElementById(key);
				cell.className += " oy-cell-cool";
				cell.classList.remove("black_and_white");
				this.fillIn(cell, clue, clue.xpos + i, clue.ypos, i, j, idx, 0);
				this.menu.setCellState(clue.xpos + i, clue.ypos, 0);
			}
		}
	}
}


oyCrosswordPuzzle.prototype.fillIn = function(cell, clue, x, y, i, j, idx, dir) {

	// var $tag = $('<img>').attr('src', return_data[j].photos[i])
	// $tag.load( function() {
		cell.style.backgroundImage="url("+return_data[j].photos[i]+")";
		cell.style.backgroundSize="46px 46px";
		// cell.style.filter="blur(2px) grayscale(100%); -webkit-filter: blur(2px) grayscale(100%); -moz-filter: blur(2px) grayscale(100%)";


		// cell.style.backgroudRepeat = "no-repeat";


		cell.innerHTML = "<input id='oyInput" + x + "_" + y + "' class='oyCellInput' autocomplete='off' type='text' size='1' maxlength='1' value=''>";

	// });
}

oyCrosswordPuzzle.prototype.bind = function(){	
	
	var target = document.getElementById("oygListH");
	target.className = "oyPanelDiv";
	target.innerHTML = this.hlist.render();			
 	
	var target = document.getElementById("oygListV");
	target.className = "oyPanelDiv";		
	target.innerHTML = this.vlist.render();
	
	
	// fill in table with inputs
	var hcount = 0;	
	for (var i=0; i < this.hlist.clues.length; i++){	
		this.fillHorz(this.hlist.clues[i], hcount);
		hcount++;
	}
	  
	var vcount = 0;
	for (var i=0; i < this.vlist.clues.length; i++){	
		this.fillVert(this.vlist.clues[i], vcount);
		vcount++;
	} 
	
	this.inputCache = new oyGridElementCache(this.w, this.h, "oyInput");
	
	
	// bind inputs
	for (var i=0; i < this.h; i++){	
		for (var j=0; j < this.w; j++){	
			this.bindItem(j, i);
		}
	}	
	
	this.menu.bind(); 
	this.footer.bind();
		
	this.hlist.bind();
	this.vlist.bind();	
	
	this.footer.update();	  
	this.started = true;
} 

oyCrosswordPuzzle.prototype.unbind = function(){	

	for (var i=0; i < this.h; i++){	
		for (var j=0; j < this.w; j++){	 
			var target =  this.inputCache.getElement(j, i);
			if (target != null){
				target.onclick = null;
				target.onkeydown = null;
				target.onchange = null;
			}
		}
	}

	this.hlist.unbind();
	this.vlist.unbind();	
	 
	this.footer.unbind();
	this.menu.unbind(); 
}

oyCrosswordPuzzle.prototype.bindItem = function(x, y){	
	var target =  this.inputCache.getElement(x, y);
	if (target != null){
		var oThis = this;			  
	
		target.onclick = function(){
			oThis.unfocusOldCell();
			oThis.focusNewCell(x, y, false);
		}  
		
		target.onkeydown = function(e){ 
			return oThis.handleKeyDown(x, y, e); 
		}		 
		
		target.onkeypress = function(e){ 
			return oThis.handleKeyPress(x, y, e); 
		}		 
	}   
} 

oyCrosswordPuzzle.prototype.focusLists = function(x, y){
	var hidx = this.hlist.getClueIndexForPoint(x, y);
	this.hlist.selectItem(hidx);
		
	var vidx = this.vlist.getClueIndexForPoint(x, y);
	this.vlist.selectItem(vidx);		
}

oyCrosswordPuzzle.prototype.focusCellList = function(all, focused){ 
	for (var i=0; i < all.length; i++){
		var cell = document.getElementById("oyCell" + all[i].x + "_" + all[i].y);			
		var stateCode = this.menu.getCellState(all[i].x, all[i].y);
		if (cell != null){
			if (focused && stateCode == 0){ 
				cell.className = "oyCellFocused";
			} else {  
				this.restoreCellState(cell, all[i].x, all[i].y);
			} 
		}
	} 		
}

oyCrosswordPuzzle.prototype.unfocusOldWord = function(){ 
	if (this.focused != null){
		this.focusCellList(
			this.menu.getCellPosListFor(this.focused),
			false
		);	  
		 
		this.focused = null;
	} 
}

oyCrosswordPuzzle.prototype.focusNewWord = function(x, y){
	var hidx = this.hlist.getClueIndexForPoint(x, y);
	var vidx = this.vlist.getClueIndexForPoint(x, y);
	
	var clue = null;
	if (hidx != -1 && vidx != -1){
		if (this.dir == 0){
			clue = this.hlist.clues[hidx];
		} else {
			clue = this.vlist.clues[vidx];
		}
	} else { 
		if (hidx != -1){
			clue = this.hlist.clues[hidx];
		} 
		if (vidx != -1){
			clue = this.vlist.clues[vidx];
		}	
	}
		 
	return clue;
}
  
oyCrosswordPuzzle.prototype.focusNewCell = function(x, y, focus, clue){
	if (clue != null){
		this.focused = clue;
	} else { 
		this.focused = this.focusNewWord(x, y);
	}
	
	if (this.focused != null){
		this.dir = this.focused.dir;
		
		this.focusCellList(
			this.menu.getCellPosListFor(this.focused),
			true
		);		
	}
	  
	var target = document.getElementById("oyCell" + x + "_" + y);
	console.log(target)		
	if (target != null){
		target.className = "oyCellActive";	 	
		this.focusLists(x, y);
		 
		if (focus){
			var target = this.inputCache.getElement(x, y);
			
			target.focus();
		}
	}
	
	this.xpos = x;
	this.ypos = y;	   
    this.menu.focusNewCell(x, y);
    
	this.menu.invalidateMenu();	 
}

oyCrosswordPuzzle.prototype.unfocusOldCell = function(){ 
	var target = document.getElementById("oyCell" + this.xpos + "_" + this.ypos);			
	if (target != null){  
		this.restoreCellState(target, this.xpos, this.ypos);
	}  
	   
	this.unfocusOldWord();
} 

oyCrosswordPuzzle.prototype.invalidate = function(){
	this.unfocusOldCell();  
	this.focusNewCell(this.xpos, this.ypos, true);
}

oyCrosswordPuzzle.prototype.restoreCellState = function(target, x, y){
	var stateCode = this.menu.getCellState(x, y);		
	switch(stateCode){
		case -1:
			target.className = "oyCellEmpty";
			break; 	
		case 0:
			// console.log(target)
			target.className = "oyCellFull";
			// target.style.background="background-image: url('madden50.png') no-repeat";
			break; 
 		case 1: 
			target.className = "oyCellGuessed"; 		 		
 			break;
		case 2:
	 		target.className = "oyCellRevealed"; 		 	
 			break; 		 			 
	 	default: 
	 		alert("Bad state code!");		
 	} 
}

oyCrosswordPuzzle.prototype.isValidChar = function (c){
	return (c >= "A" && c <= "Z") || c == " ";
}  

oyCrosswordPuzzle.prototype.moveToPrevCell = function(x, y){
	if (this.dir == 0) {
		x--; 
	} else {
		y--; 	
	} 
	 
	var stateCode = this.menu.getCellState(x, y);
	if (stateCode != -1){
		var target = this.inputCache.getElement(x, y);
		if (target != null){ 
			this.unfocusOldCell(); 
			this.focusNewCell(x, y, false);
			target.focus();
		} 
	}
}

oyCrosswordPuzzle.prototype.moveToNextCell = function(x, y){
	if (this.dir == 0) {
		x++; 
	} else {
		y++; 	
	} 
	 
	var stateCode = this.menu.getCellState(x, y);
	if (stateCode != -1){
		var target = this.inputCache.getElement(x, y);
		if (target != null){ 
			this.unfocusOldCell(); 
			this.focusNewCell(x, y, false);
			target.focus();
		}
	}
}
 
oyCrosswordPuzzle.prototype.handleKeyPress = function(x, y, e){
	//
	// space - 32
	//

	if (!e) {
		e = window.event;	
	}
	var keyCode = (e.which) ? e.which : e.keyCode;
	
	var c = String.fromCharCode(keyCode).toUpperCase();		
	if (keyCode == 32){
		c = " ";
	} 
			  
	if (this.isValidChar(c)){ 
		var target = this.inputCache.getElement(x, y);	 			
		if (!target.readOnly){ 
			target.value = c.toUpperCase();
		}
		this.moveToNextCell(x, y);
	}			
	
	return false;
}

oyCrosswordPuzzle.prototype.handleKeyDown = function(x, y, e){
	//
	// left 37
	// up - 38
	// right - 39 
	// down - 40	 
	// backspace - 8
	//
 
	if (!e) {
		e = window.event;	
	} 
	var keyCode = (e.which) ? e.which : e.keyCode;
 
	var dir = (keyCode >= 37 && keyCode <= 40) || keyCode ==8;	
	if (dir) {
		var target = null;
	 
		switch(keyCode){
		   	case 8:
			   	this.moveToPrevCell(x, y);
		   		break;
			case 37:
				while(true){
					if (x > 0){
						x = x - 1;
						target = this.inputCache.getElement(x, y);
						if (target != null){
							break;
						}
					} else {
						break;
					}
				}
			break;
			case 39:
				while(true){
					if (x < this.w - 1){
						x = x + 1;
						target = this.inputCache.getElement(x, y);
						if (target != null){
							break;
						}
					} else {
						break;
					}
				}
			break;
			case 38:
				while(true){
					if (y > 0){
						y = y - 1;
						target = this.inputCache.getElement(x, y);
						if (target != null){
							break;
						}
					} else {
						break;
					}
				}
			break;
			case 40:
				while(true){
					if (y < this.h - 1){
						y = y + 1;
						target = this.inputCache.getElement(x, y);
						if (target != null){
							break;
						}
					} else {
						break;
					}
				}
			break;
		} 
	 
		if (target != null){
			this.unfocusOldCell();
			this.focusNewCell(x, y, false);
			target.focus();
		}	
	}
	
	return true; 
}