class FilVipController < ApplicationController
  def index
    if params[:url]
        LienSignaler.create(:lien_id => params[:idlien], :url_lien => params[:url])
        flash[:error] = "Merci de votre compliment !!"
        #@liens = Lien.paginate_by_sql("SELECT a.titre_lien, a.url_lien, a.description_lien, a.image_lien, b.lien_id, c.pseudo_auteur, c.prenom_auteur, c.nom_auteur FROM liens a, liens_auteurs b, auteurs c WHERE b.lien_id = a.id AND b.auteur_id = c.id ", :page => params[:page], :per_page => 9)
      end
    @liens = Lien.paginate_by_sql("SELECT a.titre_lien, a.url_lien, a.description_lien, a.image_lien, b.lien_id, c.pseudo_auteur, c.prenom_auteur, c.nom_auteur, c.biographie_auteur, c.id_twitter FROM liens a, liens_auteurs b, auteurs c WHERE b.lien_id = a.id AND b.auteur_id = c.id AND c.id_twitter != '' ", :page => params[:page], :per_page => 15)
  end
  
  def vote_positif
    ipclient = request.remote_ip
    useragent = request.headers['HTTP_USER_AGENT']
    @lienvote = LiensVotesPositif.where(:lien_id => params[:idlien], :ip_lien_votes_positifs => ipclient, :user_agent_lien_votes_positifs => useragent).first
    if @lienvote

      redirect_to :back
      #redirect_to :action => "js", :notice => '1'
      #puts 0
      flash[:notice] = "Vous avez deja voté pour ce lien"
      #return 0
    else
      LiensVotesPositif.create(:lien_id => params[:idlien], :ip_lien_votes_positifs => ipclient, :user_agent_lien_votes_positifs => useragent)
      sum = LiensVote.find_or_create_by_lien_id(:lien_id => params[:idlien], :sum_lien_votes_positifs => 0)
            @sum_positif = sum.sum_lien_votes_positifs + 1
            #@sum_negatif = sum.sum_lien_votes_negatifs
            LiensVote.update(sum.id, :sum_lien_votes_positifs => @sum_positif)#.where("lien_id = #{sum.lien_id}")

      redirect_to :action => "index", :p => 'vip'
      #puts 1
      flash[:notice] = "votre vote a été pris en compte"
      #return 1
    end

  end
end
