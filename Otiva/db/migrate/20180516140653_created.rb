class Created < ActiveRecord::Migration
  def change
  	add_column :produits,:created_at,:datetime
  	add_column :produits,:updated_at,:datetime
  end
end
