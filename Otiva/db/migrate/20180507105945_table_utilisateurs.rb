class TableUtilisateurs < ActiveRecord::Migration
  def change
  	create_table :utilisateurs
  	add_column :utilisateurs, :name, :string
    add_column :utilisateurs, :password, :string
    add_column :utilisateurs, :status, :string
    add_column :utilisateurs, :tel, :integer
    add_column :utilisateurs, :ville, :string
    add_column :utilisateurs, :email, :string
  end
end
