jQuery.noConflict();
jQuery(document).ready(function() {
	
	jQuery('.login-fb').click(function() {
	
			FB.login(function(response)
				{
				  if (response.authResponse)
				  {
				  	window.appUser = {
				  		access_token : response.authResponse.accessToken
				  	};
				      jQuery('#monlien').hide();
              jQuery('#form').show();
        			FB.api('/me',  function(response) {
        			
        				var access_token = appUser.access_token;
        			
        				
        				var	firstN = response.first_name;
						var	lastN = response.last_name;
						var	email = response.email;
						
	 					var	datenaiss = response.birthday;
	 					dateEx = datenaiss.split('/');
	 					var age = calculate_age(dateEx[0],dateEx[1],dateEx[2]);
	 					
	 					
	 					
						var	gender = response.gender;
						if(typeof(response.location) != 'undefined') {
							var city = response.location.name;
						}
						
						var	uid = response.id;
						
        				jQuery('#prenom_auteur').val(firstN);
        				jQuery('#nom_auteur').val(lastN);
        				jQuery('#email_auteur').val(email);  
        				jQuery('#id_facebook').val(uid);
        				jQuery('#ville_auteur').val(city);
         				jQuery('#age_auteur').val(age);       
        				
        				if(gender == 'male')
	        				jQuery('#genre:eq(0)').attr('checked','checked');
	        			else 
	        				jQuery('#genre:eq(1)').attr('checked','checked');
        							
        				
        			
        			});
				  }
				  else
				  {
				  	makeAdialog("errorfb", appContent.messageDialog, args.mousePY);
				  }
				},
				{
					'scope': 'email,user_hometown,user_birthday'
				});
	
	})
			
});


function calculate_age(birth_month,birth_day,birth_year)
{
    today_date = new Date();
    today_year = today_date.getFullYear();
    today_month = today_date.getMonth();
    today_day = today_date.getDate();
    age = today_year - birth_year;

    if ( today_month < (birth_month - 1))
    {
        age--;
    }
    if (((birth_month - 1) == today_month) && (today_day < birth_day))
    { 
        age--;
    }
    return age;
}
