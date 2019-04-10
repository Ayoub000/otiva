class Del < ActiveRecord::Migration
  def change
  	remove_column :produits,:type,:string
  	add_column :produits,:photo,:string
  end
end
