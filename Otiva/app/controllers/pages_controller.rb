class PagesController < ApplicationController
  def home
  	if session[:util_id]
  		@util_courant=Utilisateur.find(session[:util_id])
  	end
    @produit=Produit.all
  end
  def annonce
    if session[:util_id]
      @util_courant=Utilisateur.find(session[:util_id])
    end
  end
  def creation_ann
    if !session[:util_id]
      inser_prod
      inser_user
      user_id=Utilisateur.find_by_name(params[:name]).id
      Produit.find_by_titre(params[:titre]).update utilisateur_id: user_id
      redirect_to root_path
    else
      inser_prod
      redirect_to root_path
    end
  end
  def inser_prod
    uploaded_io = params[:photo]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    file.write(uploaded_io.read)
    end
    Produit.create categorie: params[:categorie],ville: params[:ville],genre: params[:genre],
                    titre: params[:titre],description: params[:description],
                    prix: params[:prix],photo: uploaded_io.original_filename,
                    utilisateur_id: session[:util_id]
  end
  def inser_user
    Utilisateur.create name: params[:name],password: params[:password],
                      email: params[:email],tel: params[:tel],
                      status: params[:statut],ville: params[:ville]

  end
  def insertion
    inser_user
    redirect_to login_path
  end
  def supr_prod
    Produit.find(params[:id]).destroy
    @util_courant=Utilisateur.find(session[:util_id])
    if @util_courant.admin?
      redirect_to admin_path
    else
      redirect_to mes_annonces_path
    end
  end
  def mes_annonces
    @produit=Produit.where(utilisateur_id:session[:util_id])
    if session[:util_id]
      @util_courant=Utilisateur.find(session[:util_id])
    end
  end
  def modifier_annonce
    if session[:util_id]
      @util_courant=Utilisateur.find(session[:util_id])
    end
  end
  def modif_ann
    uploaded_io = params[:photo]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    file.write(uploaded_io.read)
    end
        Produit.find(params[:id]).update categorie: params[:categorie],ville: params[:ville],genre: params[:genre],
                    titre: params[:titre],description: params[:description],
                    prix: params[:prix],photo: uploaded_io.original_filename
    @util_courant=Utilisateur.find(session[:util_id])
    if @util_courant.admin?
      redirect_to admin_path
    else
      redirect_to mes_annonces_path
    end
  end
  def login
  end
  def inscription
  end

  def admin
    @util_courant=Utilisateur.find(session[:util_id])
    @produit=Produit.all
  end

  def verif
  	@util_courant = Utilisateur.where(name: params[:name], password: params[:password]).first
    if @util_courant
      session[:util_id]=@util_courant.id
      redirect_to root_path
    else
      session[:util_id]=nil
      redirect_to "/login"
    end
  end
  def deco
  	session[:util_id] = nil
    redirect_to root_path
  end
  def qui
    if session[:util_id]
      @util_courant=Utilisateur.find(session[:util_id])
    end
  end
end
