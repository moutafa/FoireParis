class FilJoieController < ApplicationController
  require 'open-uri'
  
  def index
    if params[:url]
        LienSignaler.create(:lien_id => params[:idlien], :url_lien => params[:url])
        flash[:error] = "Merci de votre compliment !!"
        #@liens = Lien.paginate_by_sql("SELECT a.titre_lien, a.url_lien, a.description_lien, a.image_lien, b.lien_id, c.pseudo_auteur, c.prenom_auteur, c.nom_auteur FROM liens a, liens_auteurs b, auteurs c WHERE b.lien_id = a.id AND b.auteur_id = c.id ", :page => params[:page], :per_page => 9)
      end
    if params[:tri]
      @liens = Lien.paginate_by_sql("SELECT a.titre_lien, a.url_lien, a.description_lien, a.image_lien, a.created_at, b.lien_id, c.pseudo_auteur, c.prenom_auteur, c.nom_auteur FROM liens a, liens_auteurs b, auteurs c WHERE b.lien_id = a.id AND b.auteur_id = c.id ORDER BY created_at DESC", :page => params[:page], :per_page => 9) if params[:tri] == 'desc'
      @liens = Lien.paginate_by_sql("SELECT a.titre_lien, a.url_lien, a.description_lien, a.image_lien, a.created_at, b.lien_id, c.pseudo_auteur, c.prenom_auteur, c.nom_auteur, d.sum_lien_votes_positifs FROM liens a, liens_votes d, liens_auteurs b, auteurs c WHERE b.lien_id = a.id AND b.auteur_id = c.id AND d.lien_id = a.id ORDER BY sum_lien_votes_positifs DESC", :page => params[:page], :per_page => 9) if params[:tri] == 'vote'
    else
      @liens = Lien.paginate_by_sql("SELECT a.titre_lien, a.url_lien, a.description_lien, a.image_lien, b.lien_id, c.pseudo_auteur, c.prenom_auteur, c.nom_auteur FROM liens a, liens_auteurs b, auteurs c WHERE b.lien_id = a.id AND b.auteur_id = c.id ", :page => params[:page], :per_page => 9)
    end
  end

  def apercu
  end
  
  def vote_positif
    if params[:url]
        LienSignaler.create(:lien_id => params[:idlien], :url_lien => params[:url])
        flash[:error] = "Merci de votre compliment !!"
        #@liens = Lien.paginate_by_sql("SELECT a.titre_lien, a.url_lien, a.description_lien, a.image_lien, b.lien_id, c.pseudo_auteur, c.prenom_auteur, c.nom_auteur FROM liens a, liens_auteurs b, auteurs c WHERE b.lien_id = a.id AND b.auteur_id = c.id ", :page => params[:page], :per_page => 9)
      end
    if params[:tri]
      @liens = Lien.paginate_by_sql("SELECT a.titre_lien, a.url_lien, a.description_lien, a.image_lien, a.created_at, b.lien_id, c.pseudo_auteur, c.prenom_auteur, c.nom_auteur FROM liens a, liens_auteurs b, auteurs c WHERE b.lien_id = a.id AND b.auteur_id = c.id ORDER BY created_at DESC", :page => params[:page], :per_page => 9) if params[:tri] == 'desc'
      @liens = Lien.paginate_by_sql("SELECT a.titre_lien, a.url_lien, a.description_lien, a.image_lien, a.created_at, b.lien_id, c.pseudo_auteur, c.prenom_auteur, c.nom_auteur, d.sum_lien_votes_positifs FROM liens a, liens_votes d, liens_auteurs b, auteurs c WHERE b.lien_id = a.id AND b.auteur_id = c.id AND d.lien_id = a.id ORDER BY sum_lien_votes_positifs DESC", :page => params[:page], :per_page => 9) if params[:tri] == 'vote'
    else
      @liens = Lien.paginate_by_sql("SELECT a.titre_lien, a.url_lien, a.description_lien, a.image_lien, b.lien_id, c.pseudo_auteur, c.prenom_auteur, c.nom_auteur FROM liens a, liens_auteurs b, auteurs c WHERE b.lien_id = a.id AND b.auteur_id = c.id ", :page => params[:page], :per_page => 9)
    end
    
    ipclient = request.remote_ip
    useragent = request.headers['HTTP_USER_AGENT']
    @lienvote = LiensVotesPositif.where(:lien_id => params[:idlien], :ip_lien_votes_positifs => ipclient, :user_agent_lien_votes_positifs => useragent).first
    if @lienvote

      #redirect_to :back
      #redirect_to :action => "js", :notice => '1'
      #puts 0
      flash[:notice] = "0"
      #return 0
    else
      LiensVotesPositif.create(:lien_id => params[:idlien], :ip_lien_votes_positifs => ipclient, :user_agent_lien_votes_positifs => useragent)
      sum = LiensVote.find_or_create_by_lien_id(:lien_id => params[:idlien], :sum_lien_votes_positifs => 0)
            @sum_positif = sum.sum_lien_votes_positifs + 1
            #@sum_negatif = sum.sum_lien_votes_negatifs
            LiensVote.update(sum.id, :sum_lien_votes_positifs => @sum_positif)#.where("lien_id = #{sum.lien_id}")

      #redirect_to :action => "index", :p => 'fil'
      #puts 1
      #flash[:notice] = "votre vote a été pris en compte"
      flash[:notice] = "1"
    end
    
  end
  
  def vote_negatif
    ipclient = request.remote_ip
    useragent = request.headers['HTTP_USER_AGENT']
    @lienvotenegatif = LiensVotesNegatif.find_or_create_by_lien_id_and_ip_lien_votes_negatifs_and_user_agent_lien_votes_negatif(:lien_id => params[:idlien], :ip_lien_votes_negatifs => ipclient, :user_agent_lien_votes_negatif => useragent)
    if @lienvotenegatif
      sum = LiensVote.find(:lien_id => params[:idlien])
      @sum_negatif = sum.sum_lien_votes_negatifs + 1
      LiensVote.update(sum.lien_id, :sum_liens_votes_negatifs => @sum_negatif)
      
      redirect_to :action => "index"
      flash[:notice] = "Vous avez deja voté pour ce lien"
    else
      redirect_to :action => "index"
      flash[:notice] = "votre vote a été pris en compte"
    end
  
  end
end
