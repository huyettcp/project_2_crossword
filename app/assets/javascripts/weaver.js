
  var board = [];
  var wordlist= word_list;
  var board_width = 14;
  var board_board = 14;
  var Horizontal = [];
  var Vertical = [];
  var clues = [];
  var crossings = 0



 function getRandomSubarray(arr, size) {
    var shuffled = arr.slice(0), i = arr.length, temp, index;
    while (i--) {
        index = Math.floor(i * Math.random());
        temp = shuffled[index];
        shuffled[index] = shuffled[i];
        shuffled[i] = temp;
    }
    return shuffled.slice(0, size);
  }


  // MG - builds the empty board.
  function ClearBoard(){
     board = [];
     for(x = 0; x < board_width; x++){
         board.push([]);
       for(y = 0; y <board_width; y++){
         board[x].push(' ');    
       }
      }
  }

  function MatchedLetters(Word){
    var Locations = []; 
     for(x = 0; x < board_width;  x++){
       for(y = 0; y < board_width; y++){
         var c = board[x][y].toUpperCase();
         if (Word.indexOf(c) > -1){
             Locations.push(new Array(c,x,y));  //'M',1,2
         }
       } 
     }
    return Locations;
  }

  // MG - Sets a blank crossword cell before word so words don't ajoin on same row or column.  
  function BlankPrior(x,y,dx,dy,word){
    dx = dx * -1; dy = dy * -1;
    x = x + dx;
    y = y + dy;
    if(board[x]) {
    if (board[x][y] == " ") { 
        return true; 
       } else {
        return false;
       }  
    }  
    return true; 
  }

  // MG - Sets a blank crossword cell after word so words don't ajoin on same row or column.  
  function BlankAfter(x,y,dx,dy,word){
    dx = dx * (word.length + 1); dy = dy * (word.length + 1);
    x = x + dx;
    y = y + dy;
    if(board[x]) {
       if (board[x][y] == " ") { 
        return true; 
       } else {
        return false;
       }  
    }  
    return true; 
  }


  function ScorePath(x,y,dx,dy,word){
    var score = 0;
    var size = word.length;
    var blank = 0;

     px = x - dx;
     py = y - dy;
      if(board[px]) {
      if (board[px][py] != " ") {
        return -1;
      }
      }


    for(var i = 0; i < size; i++) {
     if (((x<board_width) && (y<board_board) && (x>-1) && (y>-1))) {
       if (board[x][y] != " ") {
           if(board[x][y] == word[i]) { 
            score+=1; 
           } else {
            return -1;
           }
       } else blank += 1;

       if (board[x][y] != word[i]) {
         if (dx == 1) {
             var subscore = 0; 
             if(board[x][y-1]) {
                if(board[x][y - 1] == " ")  subscore+=1
                } else subscore += 1;
             if(board[x][y + 1]) {
                if(board[x][y + 1]==" ") subscore+=1
                } else  subscore += 1;
             if (subscore==2) {
                score += 1
             } else {
                return -1;
             }
           }
         if(dy == 1){
             var subscore = 0; 
             if(board[x-1]) {
                if(board[x - 1][y] == " ") subscore += 1
              } else  subscore+=1;
             if(board[x + 1]) {
                if(board[x + 1][y] == " ") subscore += 1
              } else  subscore+=1;
             if (subscore == 2) {
                  score+=1
              } else {
                return -1;
              }
           }
          }

     } else return -1;
      x = x + dx;
      y = y + dy;
    }
     
      if(board[x]) {
        if (board[x][y] != " ") {
          return -1;
        }
      }

 
    if (blank == word.length) score=0;
    return score;
  }


  function CrossablePlaces(word){
    var Places = [];
    var StartingPoints = MatchedLetters(word);
    var dx = 0;
    var dy = 0;
    var bestscore = 0;
    var bestdx = 0;
    var bestx= 0;
    var bestdy = 0;
    var besty = 0;
   
    for(x = 0; x < board_width; x++) {
       for(y = 0; y < board_width; y++) {
          Hscore = ScorePath(x,y,1,0,word);
          Vscore = ScorePath(x,y,0,1,word); 
          if(Hscore> bestscore) { 
              bestscore = Hscore;
              bestx = x;
              besty = y;
              bestdx = 1;
              bestdy =0 ;
          }
          if(Vscore> bestscore) { 
              bestscore = Vscore;
              bestx = x;
              besty = y;
              bestdx = 0;
              bestdy = 1;
          }
       }  
    }
    if(bestscore > 0){
        Places.push(new Array(bestscore,bestx,besty,bestdx,bestdy));
     }
    return Places;
  } 
   
  function PlaceWord(x,y,dx,dy,word){
    if (x != null && y != null && dx != null && dy != null && word != null) {
      clues.push(new oyCrosswordClue(word.length, "", word, "", dy, x, y));
    }
    var size = word.length;
    for(var i = 0; i < size; i++) {
      if(board[x]) {
          board[x][y] = word[i];
      }
      x = x + dx;
      y = y + dy;
    }

    if (dx == 1) {
      Horizontal.push(new Array(x,y,word));
    }
    if(dy == 1) {
      Vertical.push(new Array(x,y,word));
    }
    return true;
  }

  function PathIsClear(x,y,dx,dy,word){
    var size = word.length;
    for(var i = 0; i < size; i++) {
       if(board[x]) {
          if (board[x][y] != " ") { 
            return false; 
          }
            if (ScorePath(x,y,dx,dy,word) < 0) {
              return false;
            }
     } else return false;
      x = x + dx;
      y = y + dy;
    }
    return true;
  }

  function PlaceAtRandom(word) {  
    var trynum = 0; 
    var keeptrying = true;
    while(keeptrying) {
        var x = Math.floor(Math.random() * board_width);
        var y = Math.floor(Math.random() * board_width);
        var HorV = Math.floor(Math.random() * 20);
        if(HorV % 2 == 0) { 
            dx = 0;
            dy = 1;
        } else { 
            dx = 1;
            dy = 0;
        }
        keeptrying = ((trynum<board_width*board_board) && (!PathIsClear(x,y,dx,dy,word)));
        trynum++;
    } 
    if (PathIsClear(x,y,dx,dy,word)) { 
      PlaceWord(x,y,dx,dy,word);
    }
  }

  function PlaceAtBestCrossing(places,word){
    var x = places[0][1];  
    var y = places[0][2];
    var dx = places[0][3];
    var dy = places[0][4];
    PlaceWord(x,y,dx,dy,word);
  }

  //1. Loops 


  function BuildCrossword(){
    ClearBoard();
    Horizontal = [];
    Vertical = [];
    clues = [];
    crossings = 0;
    board_width = 14;
    board_board = 14;
    xwordlist = []
    xwordlist = getRandomSubarray(wordlist, 100);   
    var Retry = [];
    var Retry2 = [];
    while(xwordlist.length > 0) {
      var word = xwordlist.pop(); 
      var places = CrossablePlaces(word);
        if (places.length > 0) {   
         PlaceAtBestCrossing(places,word);  //so Mia could cross both Mike and Ann..
         crossings++;
       } else {
         if (Retry.indexOf(word) == -1) {
          Retry.push(word); xwordlist.push(word);
         } else if (Retry2.indexOf(word)==-1) {
          Retry2.push(word); xwordlist.push(word);
         } else {
           PlaceAtRandom(word); 
           }
        }
    }  
  }


  function ScreenDumpCrossword() {
     // document.write("!<pre>");  
     for(x = 0; x < board_width; x++) {
       for(y = 0; y < board_width; y++) {
         var c = board[x][y];       
       }
      }
     
   
   
   for(var i = 0; i < Vertical.length; i++) { 
   }
   for(var i = 0; i < Horizontal.length; i++) {
  
   }
  }

  function CrosswordTable() {
   
     for(x = 0; x < board_width; x++) {
       for(y = 0; y < board_width; y++) {
         var c = board[x][y]; 
         if( c == " ") {
         } else {        
         }
       }
      }
     for(var i = 0; i < Vertical.length; i++) { 
     }
     for(var i = 0; i < Horizontal.length; i++) {
     }
  }

  var threshold = 19
  var attempts = 0

  while(crossings < threshold){
    BuildCrossword();
    // console.log(crossings);
    console.log(threshold);
     if(attempts > 50){
        threshold -= 1
        attempts = 0
      }
    attempts++;
    }
  CrosswordTable(); 
  

    var oygCrosswordPuzzle = new oyCrosswordPuzzle (
          "5748185539682739085",
          "./oy-cword-1.0",
          "/a/a",
          "",
          "",
          clues,
          14,
          14
    );

  oygCrosswordPuzzle.canTalkToServer = false;


