# encoding: UTF-8

##
# Version 0.1 : Date : 23/03/2017
#

class ProfilManager

	# la Classe Profile permet de gerer les  profils

	@@listeProfil = [];
	@@dernierPseudo = nil;

	#=== Methode de classe permetant la creation d'un profile
	#
	#=== Paramètres:
	#<b>pseudo</b>  	: pseudo du joueur
	def ajouter(pseudo)
		if(setDernierJoueur(pseudo)) # On modifie le tout si dernier joueur a été changé ...
			self.save()
		end

		if(!self.existe(pseudo)) # ... Ou si on ajoute un nouveau joueur
			@@listeProfil.push(pseudo)
			self.save()
			return true
		else
			return false
		end
	end

	#=== Methode de classe permettant la suppression d'un profile
	#
	#=== Paramètres:
	#<b>pseudo</b>  	: pseudo du joueur
	def supprimer(pseudo)
		if(self.existe(pseudo))
			@@listeProfil.delete_at(@@listeProfil.index(pseudo))
			self.save()
			return true
		else
			return false
		end
	end

	#=== Methode de classe permettant de renommer un profil
	#
	#=== Paramètres:
	#<b>oldName</b>  	: pseudo actuel du profil
	#<b>newName</b>		: nouveau pseudo du profil
	def rename(oldName, newName)
		if(self.existe(oldName))
			@@listeProfil[@@listeProfil.index(oldName)] = newName;
			if(@@dernierPseudo == oldName)
				@@dernierPseudo = newname
			end
			self.save();
		end
	end

	#=== Methode de classe permettant de connecter un joueur
	#
	#=== Paramètres:
	#<b>nom</b>  	: nom du joueur qui se connecte
	def connecter(nom)
		if(self.existe(nom))
			@@dernierPseudo = nom;
			return true
		else
			return false
		end
	end

	#=== Methode de classe permettant de recuperer le pseudo du dernier joueur
	#
	def dernierJoueur()
		return @@dernierPseudo
	end

	#=== Methode de classe permettant de remplacer le dernier joueur
	#
	#=== Paramètres:
	#<b>joueurPseudo</b>  	: nom du joueur
	#=== Return :
	#<b>return vrai si le pseudo a été changé, faux sinon</b>
	def setDernierJoueur(joueurPseudo)
		if joueurPseudo == dernierJoueur
			return false
		else
			@@dernierPseudo = joueurPseudo
			return true
		end
	end

	#=== Methode permettant de tester l'existence d'un profil
	#
	#=== Paramètres :
	#<b>listProfils</b> : tableau de profile dans lesquels vérifier
	#
	#=== Return :
	#<b>return vrai si le pseudo est présent, faux sinon</b>
	def existe(nom)
		@@listeProfil.index(nom) != nil;
	end

	#=== Methode Sauvegardant les profils dans un fichier txt
	#
	def save()
		file = open("save_files/Profils", "w")

		if(!file.closed?)
			#print "Sauvegarde des profils...\n"
		end

		if(@@dernierPseudo != nil)
			file.write(@@dernierPseudo.to_s() + "\n" + "\n")
		end

		@@listeProfil.each { |profil|
			file.write(profil + "\n")
		}

		file.close()
		if(file.closed?)
			#print "Sauvegarde des profils terminées!\n"
		end
	end

	#=== Methode de classes permettant de charger un tableau de profil a partir d'un fichier
	#
	def loadFile()
		@@listeProfil = Array.new()
		if(File.file?("save_files/Profils"))
			profilList = File.open("save_files/Profils", "r")
			fileContent = IO.readlines(profilList)

			# Grids
			if(! profilList.eof? )
				if(!profilList.closed?)
					#print "Chargement des profils...\n"
				end
				profil = Array.new()
				@@dernierPseudo = profilList.readline().gsub("\n",'')
				profilList.each_line{ |ligne|
					if(!ligne.empty?() && ligne != "\n")
						@@listeProfil.push(ligne.gsub("\n",''))
					end
				}
			end

			profilList.close()
			if(profilList.closed?)
				#print "profils chargés !\n"
			end

			return true
		else
			return false
		end
	end

	#===Affiche le tableau des profils
	#
	def toAff()
		@@listeProfil.each { |profil|
			puts "   - " + profil
		}
	end
end

=begin
profil = ProfilManager.new()
profil.ajouter("Alduin")
profil.ajouter("Alduin")
profil.ajouter("Alduin")
profil.ajouter("Dovahkiin")
profil.ajouter("Miraak")
profil.loadFile()
profil.toAff()
profil.save()

#profil.supprimer("Valentin")
#profil.rename("Dimitri", "DemiTruie")
#profil.ajouter("Valentin 2 : Le retour")
#profil.toAff()



#puts"Dernier Joueur = "+profil.dernierJoueur()
#profil.connecter("DemiTruie")
#puts"Dernier Joueur = "+profil.dernierJoueur()
=end
