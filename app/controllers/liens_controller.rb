class LiensController < ApplicationController
  # GET /liens
  # GET /liens.xml
  require 'opengraph'
  require 'hpricot'
  require 'open-uri'
  require 'htmlentities'
  require 'digest'
  def index
    begin
      render :action => "new", :p=>"home"
      @liens = Lien.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @liens }
      end
    rescue
      flash[:notice] = "Désolé monsieur ou madame !!"
      redirect_to '/'
    end
  end

  # GET /liens/1
  # GET /liens/1.xml
  def show
    #begin
      #@lien = Lien.find(params[:id])
      @liens = Lien.find_by_sql("SELECT a.titre_lien, a.url_lien, a.description_lien, a.image_lien, a.created_at, b.lien_id, c.pseudo_auteur, c.prenom_auteur, c.nom_auteur, d.sum_lien_votes_positifs FROM liens a LEFT JOIN liens_auteurs b ON (b.lien_id = a.id) LEFT OUTER JOIN liens_votes d ON (d.lien_id = a.id) LEFT JOIN auteurs c ON (b.auteur_id = c.id) WHERE a.id=#{params[:id].to_i}")      
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @lien }
      end
    #rescue
      #flash[:notice] = "Désolé monsieur ou madame !!"
      #redirect_to '/'
    #end
  end

  # GET /liens/new
  # GET /liens/new.xml
  def new
    begin
      @lien = Lien.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @lien }
      end
    rescue
      flash[:notice] = "Désolé monsieur ou madame !!"
      redirect_to '/'
    end 
 end

  # GET /liens/1/edit
  def edit
    begin
      @lien = Lien.find(params[:id])
    rescue
      flash[:notice] = "Désolé monsieur ou madame !!"
      redirect_to '/'
    end 
 end

  # POST /liens
  # POST /liens.xml
  def create
    #begin
    if params[:lien][:url_lien] != "" and params[:lien][:url_lien] != "Votre lien ..." 
      @url_lien = params[:lien][:url_lien]
      element = @url_lien.split(".")
      tab = @url_lien.split("//")
      if tab[0] == "http:"
        @url = @url_lien
      else
        @url = "http://"+@url_lien
      end
      @auteur = params[:auteur][:pseudo_auteur]
      #@lien = Lien.new(params[:lien])
      begin
        @donnee_url = OpenGraph.fetch(@url)
      rescue
        redirect_to (:controller => 'liens', :action => "new", :p => "home")
        return 1
      end
      name = "/images_liens/thumb#{Time.now.to_i}.jpg"
      if @donnee_url
	      titre = @donnee_url.title
	      desc = @donnee_url.description
	      image = @donnee_url.image
        image_or = Magick::Image.read(image)[0]
        image = image_or.crop_resized!(297, 195, Magick::NorthGravity)
        image.write("public"+name) do self.quality = 100 end
          
      else
        begin
          uri =URI(@url)
          hdrs = {"User-Agent"=>"Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/2.0.0.1", "Accept-Charset"=>"utf-8", "Accept"=>"text/html"}
          my_html = ""
          open(@url, hdrs).each{|s| my_html << s}
          doc = Hpricot(my_html)
          desc = HTMLEntities.new.decode(doc.search("meta[@name*=description]").map {|e| e.get_attribute("content") }.to_s)#soup.find('meta', {'name' => 'description'})['content']
          titre = HTMLEntities.new.decode(doc.at("html/head/title").inner_html)#soup.html.head.title.string
	      rescue
          titre = ""
          flash[:error] = "Ce lien est certainement plein de joie mais malheureusement, le format n'est pas conforme à la Boite à Joie, peut être existe t-il un autre lien qui vous rende joyeux ?"
          redirect_to (:controller => 'liens', :action => "new", :p => "home")
          return 0
        end
      
        #desc = ""
	      name = "http://api.url2png.com/v3/P4F280C28BB8E7/#{Digest::MD5.hexdigest('S94BC47B3A5190+'+@url)}/297x195/#{@url}"#"https://www.apercite.fr/api/apercite/800x600/oui/oui/#{@url}"
      end
      
          #puts titre
      @lien = Lien.new(:titre_lien => titre, 
                         :description_lien => desc, 
                         :url_lien => @url,
                         :image_lien => name)
      
      #Recupère le dernier enregistrement de lien et auteur pour renseigner liens_auteurs
      
      @last_lien = Lien.last
      @last_auteur = Auteur.last
      if @last_lien and @last_auteur
        idlien = @last_lien.id + 1 
        idauteur = @last_auteur.id + 1
      else
        idlien = 1
        idauteur = 1
      end
      
      @Newauteur = "INSERT INTO auteurs (`pseudo_auteur`) VALUES ('#{@auteur}')"#Auteur.new(:pseudo_auteur => @auteur)
      
      #@Newauteur.save
        respond_to do |format|
          if @lien.save
            ActiveRecord::Base.connection.execute(@Newauteur)
            @lien.liens_auteurs.create(:lien_id => idlien, :auteur_id => idauteur)
          
            format.html { redirect_to(:controller => 'auteurs', :action => 'new', :id => idauteur, :p => "user", :idlien => idlien, :auteur => @auteur) }
            format.xml  { render :xml => @lien, :status => :created, :location => @lien }
          else
            format.html { redirect_to :controller => 'liens', :action => "new", :p => "home" }
            format.xml  { render :xml => @lien.errors, :status => :unprocessable_entity }
            flash[:error] = "Lien invalide !!"
          end
        end
      else
        redirect_to(:controller => 'liens', :action => 'new', :p => "home")
        flash[:error] = "Merci de renseigner un lien !"
      end
  #rescue
   #   redirect_to(:controller => 'liens', :action => 'new', :p => "home")
  #end
  end

  # PUT /liens/1
  # PUT /liens/1.xml
  def modifier_lien
    if params[:lien] != ""  
      @lien = Lien.find(params[:id])
      @donnee_url = OpenGraph.fetch(params[:lien])
    
      @url_lien = params[:lien]
      element = @url_lien.split(".")
      tab = @url_lien.split("//")
      if tab[0] == "http:"
        @url = @url_lien
      else
        @url = "http://"+@url_lien
      end
      name = "/images_liens/thumb#{Time.now.to_i}.jpg"
    if @donnee_url
	    titre = @donnee_url.title
	    desc = @donnee_url.description
	    image = @donnee_url.image
      image_or = Magick::Image.read(image)[0]
        image = image_or.crop_resized!(297, 195, Magick::NorthGravity)
        image.write("#{RAILS_ROOT}/public"+name) do self.quality = 100 end
    else
	    begin
          uri =URI(@url)
          #htmlcontent = #Net::HTTP.get(uri)
          #soup = BeautifulSoup.new(htmlcontent)
          hdrs = {"User-Agent"=>"Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/2.0.0.1", "Accept-Charset"=>"utf-8", "Accept"=>"text/html"}
          my_html = ""
        
          open(@url, hdrs).each{|s| my_html << s}
          doc = Hpricot(my_html)
          desc = HTMLEntities.new.decode(doc.search("meta[@name*=description]").map {|e| e.get_attribute("content") }.to_s)#soup.find('meta', {'name' => 'description'})['content']
          titre = HTMLEntities.new.decode(doc.at("html/head/title").inner_html)#soup.html.head.title.string
	      rescue
          titre = ""
          flash[:error] = "Ce lien est certainement plein de joie mais malheureusement, le format n'est pas conforme à la Boite à Joie, peut être existe t-il un autre lien qui vous rende joyeux ?"
          redirect_to (:controller => 'liens', :action => "new", :p => "home")
          return 0
        end
      
        #desc = ""
	      name = "http://api.url2png.com/v3/P4F280C28BB8E7/#{Digest::MD5.hexdigest('S94BC47B3A5190+'+@url)}/297x195/#{@url}"#"https://www.apercite.fr/api/apercite/800x600/oui/oui/#{@url}"
      end
      
    
    respond_to do |format|
      if Lien.update(params[:id], :titre_lien =>titre, :description_lien => desc, :url_lien => params[:lien], :image_lien => name)
        format.html { redirect_to(:controller => 'auteurs', :action => 'new', :id => params[:idauteur], :p => "user", :idlien => params[:id], :auteur => params[:auteur][:pseudo_auteur]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "new", :p => "home" }
        format.xml  { render :xml => @lien.errors, :status => :unprocessable_entity }
      end
    end
    else
      flash[:notice] = "Désolé monsieur ou madame !!"
      redirect_to :back
    end
  end
  def update
    @lien = Lien.find(params[:id])

    respond_to do |format|
      if @lien.update_attributes(params[:lien])
        format.html { redirect_to(@lien, :notice => 'Lien was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lien.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /liens/1
  # DELETE /liens/1.xml
  def destroy
    @lien = Lien.find(params[:id])
    @lien.destroy

    respond_to do |format|
      format.html { redirect_to(liens_url) }
      format.xml  { head :ok }
    end
  end
end
