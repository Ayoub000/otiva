class ChercherproduitController < ApplicationController
    
  def index
    if session[:util_id]
        @util_courant=Utilisateur.find(session[:util_id])
    end
    if params[:ville] == "*"
      
        unless params[:categorie].empty?
            unless params[:titre].empty?
                @produits = Produit.where("titre LIKE '%#{params[:titre]}%' AND genre = ?
                AND categorie = ?",params[:genre] ,params[:categorie]).paginate(:page => params[:page], :per_page => 3)
            else
              @produits = Produit.where(genre: params[:genre],categorie: params[:categorie]).paginate(:page => params[:page], :per_page => 3)
            end
        else
            unless params[:titre].empty?
                @produits = Produit.where("titre LIKE '%#{params[:titre]}%' AND genre = ?",
                params[:genre]).paginate(:page => params[:page], :per_page => 3)
            else
                @produits = Produit.where(genre: params[:genre]).paginate(:page => params[:page], :per_page => 3)
            end
        end
    else
        unless params[:categorie].empty?
            unless params[:titre].empty?
                @produits = Produit.where("titre LIKE '%#{params[:titre]}%' AND genre = ?
                AND categorie = ? AND ville = ?",params[:genre] ,params[:categorie], params[:ville]).paginate(:page => params[:page], :per_page => 3)
            else
              @produits = Produit.where(genre: params[:genre],categorie: params[:categorie], ville: params[:ville])
              .paginate(:page => params[:page], :per_page => 3)
            end
        else
            unless params[:titre].empty?
                @produits = Produit.where("titre LIKE '%#{params[:titre]}%' AND genre = ? AND ville = ?",
                params[:genre], params[:ville]).paginate(:page => params[:page], :per_page => 3)
            else
                @produits = Produit.where(genre: params[:genre], ville: params[:ville]).
                paginate(:page => params[:page], :per_page => 3)
            end
        end
      end

    end


  def show
    if session[:util_id]
        @util_courant=Utilisateur.find(session[:util_id])
    end
    @produits = Produit.where(id: params[:id])
    @produits.each do |pr| 
        @util=Utilisateur.where(id:pr.utilisateur_id)
        @product=Produit.where("categorie = ? AND NOT id = ?",pr.categorie,pr.id).limit(1)
    end
    #@produits = Produit.where("id = ? AND genre = ?", params[:id], params[:genre])
    
  end 
  def destroy
    session[:util_id] = nil
    redirect_to root_path
  end

end
