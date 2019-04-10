class Utilisateur < ActiveRecord::Base
	has_many :produits
end