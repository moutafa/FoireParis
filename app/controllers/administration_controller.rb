class AdministrationController < ApplicationController
  uses_tiny_mce
  #filter_resource_access
  def index
    @liens = Lien.paginate_by_sql("SELECT a.titre_lien, a.url_lien, a.description_lien, a.image_lien, b.lien_id, c.pseudo_auteur, c.prenom_auteur, c.nom_auteur, c.biographie_auteur, c.id_twitter FROM liens a, liens_auteurs b, auteurs c WHERE b.lien_id = a.id AND b.auteur_id = c.id AND c.id_twitter != '' ", :page => params[:page], :per_page => 15)
  end

  def ajout_user
    @auteur = Auteur.new
  end
  def create
    @auteur = Auteur.new(param[:auteur])
    
    if params[:lien][:user] != ""
      @url_lien = params[:lien][:user]
      tab = @url_lien.split("//")
      if tab[0] == "http:"
        @url = @url_lien
      else
        @url = "http://"+@url_lien
      end
      
      #@lien = Lien.new(params[:lien])
      @donnee_url = OpenGraph.fetch(@url)
      if @donnee_url
	      titre = @donnee_url.title
	      desc = @donnee_url.description
	      image = @donnee_url.image
      
      else
	      titre = ""
	      desc = ""
	      image = ""
      end
      @lien = Lien.new(:titre_lien => titre, 
                         :description_lien => desc, 
                         :url_lien => @url,
                         :image_lien => image)
      
      @last_lien = Lien.last
      @last_auteur = Auteur.last
      if @last_lien and @last_auteur
        idlien = @last_lien.id + 1 
        idauteur = @last_auteur.id + 1
      else
        idlien = 1
        idauteur = 1
      end
                        
    if @auteur.save and @lien.save
      
      @lien.liens_auteurs.create(:lien_id => idlien, :auteur_id => idauteur)
      
      respond_to do |format|
        format.html {render :action => 'index'}
        format.xml  { render :xml => @auteur }
      end
      flash[:notice] = "Utilisateur ajouter avec succès"
    else
      respond_to do |format|
        format.html {render :action => 'ajout_user'}
        format.xml  { render :xml => @auteur }
      end
      flash[:notice] = "L'ajout a échoué !!"
    end
    end
  end
  
  def ajout_article
    
  end

  def tracking
    
  end

  def moderation
    #@liens = Lien.order('created_at DESC')
    if params[:tri]
      @liens = Lien.paginate_by_sql("SELECT a.titre_lien, a.url_lien, a.description_lien, a.image_lien, a.created_at, b.lien_id, c.pseudo_auteur, c.prenom_auteur, c.nom_auteur, d.sum_lien_votes_positifs FROM liens a, liens_votes d, liens_auteurs b, auteurs c WHERE b.lien_id = a.id AND b.auteur_id = c.id AND d.lien_id = a.id ORDER BY sum_lien_votes_positifs DESC", :page => params[:page], :per_page => 9) if params[:tri] == 'vote'
      @liens = Lien.paginate_by_sql("SELECT a.titre_lien, a.url_lien, a.description_lien, a.image_lien, a.created_at, b.lien_id, c.pseudo_auteur, c.prenom_auteur, c.nom_auteur FROM liens a, lien_signalers d, liens_auteurs b, auteurs c WHERE b.lien_id = a.id AND b.auteur_id = c.id AND d.lien_id = a.id ", :page => params[:page], :per_page => 9) if params[:tri] == 'signale'
    else
      @liens = Lien.paginate_by_sql("SELECT a.titre_lien, a.url_lien, a.description_lien, a.image_lien, a.created_at, b.lien_id, c.pseudo_auteur, c.prenom_auteur, c.nom_auteur FROM liens a, liens_auteurs b, auteurs c WHERE b.lien_id = a.id AND b.auteur_id = c.id ", :page => params[:page], :per_page => 9)
    end
  end

  def destroy
    @lien = Lien.find(params[:id])
    @lien.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
  
end
