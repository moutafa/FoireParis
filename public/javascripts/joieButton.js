jQuery(document).ready(function() {
	
	jQuery('div.joieButton').each(function(){
	
		var id = jQuery(this).attr('rel');
		var countJ = jQuery(this).attr('rev'); 
		
		var html = '<div class="LikePluginPagelet" ><div id="" class="connect_widget button_count" style=""><table class="connect_widget_interactive_area"><tbody><tr><td class="connect_widget_vertical_center connect_widget_button_cell"><div class="connect_button_slider"><div class="connect_button_container"><a class="connect_widget_like_button clearfix like_button_no_like"  id="LINKjb'+id+'"  rel="'+id+'" rev="'+countJ+'"><div class="tombstone_cross"></div><span class="liketext"></span></a></div></div></td><td class="connect_widget_button_count_excluding" style="opacity: 1; "><table class="uiGrid" cellspacing="0" cellpadding="0"><tbody><tr><td><div class="connect_widget_button_count_nub"><s></s><i></i></div></td><td><div id="SUMjb'+id+'" class="connect_widget_button_count_count">'+countJ+'</div></td></tr></tbody></table></td></tr></tbody></table></div></div>';
		
		jQuery(this).html(html);
	
	});
	
	jQuery('div.joieButton .connect_widget_like_button').live('click', function(){
		var id = jQuery(this).attr('rel');
		var countJ = parseInt(jQuery(this).attr('rev')); 
		var url = 'http://192.168.0.123:3000/fil_joie/vote_positif?idlien='+id+'&p=fil&fil=file';
		jQuery.get(url, function(data) {
		  if(data == 1) {
		  	jQuery('#SUMjb'+id).html(countJ+1);
		  	jQuery('#LINKjb'+id).attr('rev', countJ+1);
		  }
		});
	});
	
});

