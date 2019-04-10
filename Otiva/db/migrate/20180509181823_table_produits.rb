class TableProduits < ActiveRecord::Migration
  def change
  	create_table :produits
  	add_column :produits, :utilisateur_id, :integer
  	add_index :produits, :utilisateur_id
  	add_column :produits, :categorie, :string
  	add_column :produits, :type, :string
  	add_column :produits, :ville, :string
  	add_column :produits, :titre, :string
  	add_column :produits, :description, :text
  	add_column :produits, :prix, :integer
  end
end
