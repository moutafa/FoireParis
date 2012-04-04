class AuthentificationController < ApplicationController

  def home
  end

  def sign_in
    if params[:user]
      @user = Auteur.find_by_pseudo_auteur(params[:user][:pseudo_auteur])
			#@user = Auteur.authenticate(params[:user][:pseudo_auteur],params[:user][:mot_de_passe])
			if @user

        session[:user_id] = @user.id
				session[:username] = @user.pseudo_auteur
        flash[:notice] = 'Utilisateur connecte'
				redirect_to '/administration/ajout_user'
			else
				flash[:notice] = 'Utilisateur inconnu'
			end
		end
  end

  def sign_out
    reset_session
		redirect_to '/authentification/sign_in'

  end

end
