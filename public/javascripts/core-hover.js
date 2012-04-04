jQuery(document).ready(function() {

		var fond = jQuery('.show img').attr('rev');
		jQuery.get('/auteurs/?p=user2&fil=file&type=rand&pic='+encodeURIComponent(fond), function(data) {
			if(data != 0) {
				jQuery('.show img').attr('src', 'http://'+window.location.host+'/'+data);
			}
		});
	
	jQuery('.tools div').click(function() {
		var type = jQuery(this).attr('rev');
		var fond = jQuery('.show img').attr('rev');
		jQuery.get('/auteurs/?p=user&fil=file&type='+type+'&pic='+encodeURIComponent(fond), function(data) {
			if(data != 0) {
				jQuery('.show img').attr('src', 'http://'+window.location.host+'/'+data);
			}
		});
		return false;
	});
	
	jQuery('#addtoprofile').click(function() {	
		var url = jQuery('#badge .show img').attr('src');
		FB.login(function(response)
			{
			 if (response.authResponse)
				  {
				  	 FB.api('/me/photos&url=' + encodeURIComponent(url) + '&method=POST',
    				function(response) {
							window.location.replace('http://www.facebook.com/photo.php?fbid='+response.id+'&makeprofile=1');
   					 });
				  }
				  else
				  {}
			},
			{
			'scope': 'publish_stream'
			});
	});
	
});
