class Offre < ActiveRecord::Migration
  def change
  	add_column :produits, :genre, :string
  	remove_column :produits, :type, :string
  	remove_column :produits, :prix, :integer
  	add_column :produits, :prix, :float
  end
end
