class Amine < ActiveRecord::Migration
  def change
  	add_column :utilisateurs,:admin,:integer,default:0
  end
end
