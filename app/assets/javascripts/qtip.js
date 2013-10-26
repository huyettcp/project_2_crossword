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
	   content: 'Do I reallly have to tell you how to tell you how to solve a crossword puzzle?',
	    style: {
        classes: 'qtip-dark qtip-rounded'
  },
	  show: {
      		ready: true
    	}
	})
});

$(document).on('mouseover', ".high_score", function(){
	
  var _this = this;
	$(this).qtip({
	   overwrite: false,
	   content: 'coming soon',
	    style: {
        classes: 'qtip-dark .qtip-content'
  },
	   show: {
      		ready: true
    	}
	})
});
