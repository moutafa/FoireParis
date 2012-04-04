class AuteursController < ApplicationController
  # GET /auteurs
  # GET /auteurs.xml
  require 'open-uri'
  def index
    begin
      @auteurs = Auteur.all
    
      type = params[:type]
      if type == 'rand'
        type = 1+rand(3)
      end
      image_or = Magick::ImageList.new
      urlimage = open(CGI::unescape(params[:pic]))
      #image_or = Magick::Image.read()[0]
      image_or.from_blob(urlimage.read)
      #image = image_or.crop_resized!(297, 195, Magick::NorthGravity)
      des_img = "badgethumb"+Time.now.to_i.to_s+".jpg"
      dst = "public/images/user_badge/"+des_img #Magick::Image.read("public/images/badge"+Random.rand(24)+".jpg")[0]
      var= 1 + rand(19)
      src = Magick::Image.read("public/images/badges/badge"+type.to_s+"-"+var.to_s+".png")[0]
      if type == "2"
        larg = image_or.columns
        haut = image_or.rows
        #img = Magick::Image.new(larg+45, haut+45){self.background_color = 'transparency'}
        img = Magick::Image.read("public/images/background.png")[0]
        image = img.crop_resized!(larg+45, haut+45, Magick::NorthGravity)
        imgsrc = "#{RAILS_ROOT}/public/images/user_badge/badge"+Time.now.to_i.to_s+".jpg"
        #img_new = "public/images/user_badge/newbadge"+Time.now.to_i.to_s+".jpg"
        #img.write(imgsrc) do self.quality = 100 end
        #img_src = Magick::Image.read(imgsrc)
        img_result = image.composite(image_or, Magick::NorthWestGravity, Magick::OverCompositeOp)
        img_result.write(imgsrc) do self.quality = 100 end
        result = img_result.composite(src, Magick::SouthEastGravity, Magick::OverCompositeOp)
      else
        result = image_or.composite(src, Magick::SouthEastGravity, Magick::OverCompositeOp)
      end
      result.write(dst) do self.quality = 100 end
      flash[:notice] = "images/user_badge/"+des_img #"https://graph.facebook.com/diengmoustapha/picture?type=large"
    
      #@Newauteur.save
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @auteurs }
      end
    rescue
      flash[:notice] = "Désolé monsieur ou madame !!"
      redirect_to '/'
    end 
 end

  # GET /auteurs/1
  # GET /auteurs/1.xml
  def show
    begin
      @auteur = Auteur.find(params[:id])
      #flash[:notice] = "images/profile.jpg"
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @auteur }
      end
    rescue
      flash[:notice] = "Désolé monsieur ou madame !!"
      redirect_to '/'
    end
      #return ""
  end
  
  def tag
    
  end

  # GET /auteurs/new
  # GET /auteurs/new.xml
  def new
    begin
      @auteur = Auteur.new
    
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @auteur }
      end
    rescue
      flash[:notice] = "Désolé monsieur ou madame !!"
      redirect_to '/'
    end
  end

  # GET /auteurs/1/edit
  def edit
    begin
      @auteur = Auteur.find(params[:id])
    rescue
      flash[:notice] = "Désolé monsieur ou madame !!"
      redirect_to '/'
    end
  end

  # POST /auteurs
  # POST /auteurs.xml
  def create
    if params[:user][:id] != ''
      begin
        @auteur = Auteur.find(params[:user][:id])
        
        respond_to do |format|
          if @auteur.update_attributes(params[:auteur])
            @id = Auteur.find(params[:user][:id])
            #flash[:notice] = "https://graph.facebook.com/"+@id.id_facebook.to_s+"/picture?type=large"
            if @id.id_facebook != ''
              format.html { redirect_to("/auteurs/#{params[:user][:id]}?p=user2&q=add", :p => 'user2', :q => 'add') }
              format.xml  { head :ok }
            else
              format.html { redirect_to(:controller => 'home', :action => 'index')}
              format.xml  { head :ok }
            end
            #flash[:notice] = 'Nous vous tenerons informer de votre billet pour assister à la foire.'
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @auteur.errors, :status => :unprocessable_entity }
          end
        end
      rescue
        redirect_to :contoller => 'auteurs', :action => 'new', :p=>'user'
        flash[:notice] = 'Remplir tous les champ du formulaire !!'
      end
    else
      begin
        @auteur = Auteur.new(params[:auteur])
        if params[:lien][:user] != "" and params[:lien][:user] != "Votre lien ..." 
          @url_lien = params[:lien][:user]
          element = @url_lien.split(".")
          tab = @url_lien.split("//")
          if tab[0] == "http:"
            @url = @url_lien
          else
            @url = "http://"+@url_lien
          end
          #@auteur = params[:auteur][:pseudo_auteur]
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
      
            image = "http://api.url2png.com/v3/P4F280C28BB8E7/#{Digest::MD5.hexdigest('S94BC47B3A5190+'+@url)}/297x195/#{@url}"#"https://www.apercite.fr/api/apercite/800x600/oui/oui/#{@url}"
          end
          image_or = Magick::Image.read(image)[0]
          image = image_or.crop_resized!(297, 195, Magick::NorthGravity)
          #dst = Magick::Image.read(”#{RAILS_ROOT}/public/#{self.public_filename}”).first
          #src = Magick::Image.read("public/images/RubanPhoto.png")[0]
          #result = image.composite(src, Magick::SouthEastGravity, Magick::OverCompositeOp)
          image.write("public"+name) do self.quality = 100 end
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
      
          respond_to do |format|
            if @auteur.save and @lien.save
              @lien.liens_auteurs.create(:lien_id => idlien, :auteur_id => idauteur)
              #@auteur.roles_auteurs.create(:role_id => params[:Administrateur]) if params[:Administrateur]
              #@auteur.roles_auteurs.create(:role_id => params[:vip]) if params[:vip]
              #@auteur.roles_auteurs.create(:role_id => params[:user]) if params[:user]
              #@auteur.roles_auteurs.create(:role_id => params[:anonyme]) if params[:anonyme]
              format.html { redirect_to(:controller => 'administration')}
              flash[:notice] = 'Ajout effectuer avec succès.'
              format.xml  { render :xml => @auteur, :status => :created, :location => @auteur }
            else
              format.html { render :action => "new" }
              format.xml  { render :xml => @auteur.errors, :status => :unprocessable_entity }
            end
          end
        else
          redirect_to(:controller => 'administration', :action => "ajout_user")
          flash[:notice] = 'Remplir tous les champ du formulaire !!'
        end
      rescue
        redirect_to(:controller => 'administration', :action => "ajout_user")
        flash[:notice] = 'Remplir tous les champ du formulaire !!'
      end
    end
  end

  # PUT /auteurs/1
  # PUT /auteurs/1.xml
  def update
    @auteur = Auteur.find(params[:id])

    respond_to do |format|
      if @auteur.update_attributes(params[:auteur])
        format.html { redirect_to(@auteur, :notice => 'Auteur was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @auteur.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /auteurs/1
  # DELETE /auteurs/1.xml
  def destroy
    @auteur = Auteur.find(params[:id])
    @auteur.destroy

    respond_to do |format|
      format.html { redirect_to(auteurs_url) }
      format.xml  { head :ok }
    end
  end
end
