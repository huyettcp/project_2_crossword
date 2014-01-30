onLoad = function() {
  // Cache selector for the progress bar
  var $progress_bar = $('#progress-bar');
  // Initialize our loading progress counter
  var done = 0;
  // Grab all the images
  var $pics = $('td');
  // console.log($pics);
  // Hide all the image tags
  $pics.hide();
  // Loop through each image and custom load their sources

  var count = 0
  $pics.each(function() {
    // Cache the 'this' selector for use here and in the event handler
    var $pic = $(this);

    // Grab the image source from our HTML img tag
    var src = $pic.css('background-image');
   
    var clean_src = $.trim(src.replace('url(','').replace(')',''));
 	
 	if(clean_src != '' && clean_src != "none") {
 		count++;
	    $pic.css('background-image','');
	    // Create a temporary img tag in memory (i.e. document.createElement)
	    var $pic_tag = $('<img>');
	    // Give our temporary img tag a source, which starts loading the image
	    $pic_tag.attr('src', clean_src);
	    // Add an event handler for when the img src load is complete (browser has downloaded the full image source)
	    // i.e. $(document).ready() for an image tag
	    $pic_tag.load(function() {
	      // Increment our progress counter
		    $pic.css('background-image', src);
	        done++;
	      
	      // Update the progress bar
	      updateProgress();
	    });
	}
  });

  function updateProgress() {
    // If we've loaded all the images
    if(done == count) {
      // // Set the progress bar to full width
      $progress_bar.css('width', '0%');
      // // Fade out the progress bar
      $progress_bar.fadeOut(200);
      // // Fade in the loaded images
      $pics.fadeIn(3000);
      // Run masonry on the image containers for super shnazzy layout
    } else {
      // Move progress bar
      $progress_bar.stop().animate({width: ((done / count) * 100) + '%'}, 3000);
    }
  }

};



