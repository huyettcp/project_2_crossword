var top_scores

cleanUrl = function(_this) {
	var imageUrl = $(_this).css('background-image');
	var clean_imageUrl = imageUrl.replace('url(','').replace(')','');
	return clean_imageUrl
}

$(document).on('mouseover', ".oyCellFull", function(){
	var _this = this;
	$(this).qtip({
	   overwrite: false,
	   content: '<img src="' + cleanUrl(_this) + '" />',
	    style: {
        classes: 'qtip-dark qtip-rounded'
  	},
	  	show: {
      		ready: true
    	}
	})
});

$(document).on('mouseover', ".oyCellInput", function(){
	var _this = this;
	$(this).qtip({
	   overwrite: false,
	   content: '<img src="' + cleanUrl(_this) + '" />',
	    style: {
        classes: 'qtip-dark qtip-rounded'
  },
	  show: {
      		ready: true
    	}
	})
});

$(document).on('mouseover', ".oyCellFocused", function(){
	var _this = this;
	$(this).qtip({
	   overwrite: false,
	   content: '<img src="' + cleanUrl(_this) + '" />',
	    style: {
        classes: 'qtip-dark qtip-rounded'
  },
	   show: {
      		ready: true
    	}
	})
});

$(document).on('mouseover', ".oyCellFocused", function(){
	var _this = this;
	$(this).qtip({
	   overwrite: false,
	   content: '<img src="' + cleanUrl(_this) + '" />',
	    style: {
        classes: 'qtip-dark qtip-rounded'
  },
	   show: {
      		ready: true
    	}
	})
});

$(document).on('mouseover', ".info", function(){
	var _this = this;
	$(this).qtip({
	   overwrite: false,
	   content: '<div><p>Instructions coming</p><br><p>soon</p></div>',
	   style: {
          classes: 'qtip-light .qtip-content'
      },
	  show: {
      	  ready: true
    	},
      position: {
          my: 'center',
          at: 'center',
          target: $(window)
        },
       show: {
             modal: true
         },
       hide: true
	})
});

$(function() {
  $.ajax({
    url: '/highscores',
    method: 'GET',
    dataType: 'json',
    }).done(function(data){
        top_scores = data
    }); 
});

$(document).on('mouseover', ".high_score", function() {
  console.log(top_scores);
  var _this = this;
	$(this).qtip({
	   overwrite: false,
	   content: "<p>" + top_scores[0].game_score + " " + top_scores[0].user_name + "</p> <br> <p>" + top_scores[1].game_score + " " + top_scores[1].user_name + "</p> <br> <p>" + top_scores[2].game_score + " " + top_scores[2].user_name + "</p>",
	   style: {
          classes: 'qtip-light .qtip-content'
      },
	   show: {
      	  ready: true
    	},
       position: {
          my: 'center',
          at: 'center',
          target: $(window)
        },
       show: {
          modal: true
        },
       hide: true
	})
});
