# encoding: UTF-8

##
# Version 0.1 : Date : 23/03/2017
#

class ProfilManager

	# la Classe Profile permet de gerer les  profiles

	@@listeProfil = [];
	@@dernierPseudo = nil;

	#=== Methode de classe permetant la creation d'un profile
	#
	#=== Paramètres:
	#<b>pseudo</b>  	: pseudo du joueur
	def ajouter(pseudo)
		if(!self.existe(pseudo))
			@@listeProfil.push(pseudo)
			self.save()
		else
			puts "Pseudo deja pris"
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
		else
			puts "Pseudo non présent"
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
		else
			puts "Pseudo non présent"
		end
	end

	#=== Methode de classe permettant de recuperer le pseudo du dernier joueur
	#
	def dernierJoueur()
		return @@dernierPseudo
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

	#=== Methode Sauvegardant les profiles dans un fichier txt
	#
	def save()
		file = open("saveProfil", "w")

		if(!file.closed?)
			#print "Sauvegarde des profiles...\n"
		end

		file.write(@@dernierPseudo.to_s() + "\n")

		@@listeProfil.each { |profil|
			file.write(profil + "\n")
		}

		file.close()
		if(file.closed?)
			#print "Sauvegarde des profiles terminées!\n"
		end
	end

	#=== Methode de classes permettant de charger un tableau de profil a partir d'un fichier
	#
	def loadFile()
		profilList = File.open("saveProfil", "r")
		cpt=0

		if(!profilList.closed?)
			#print "Chargement des profiles...\n"
		end
	
		@@dernierPseudo = profilList.readline()
		profilList.each_line{ |ligne|
			if(!ligne.empty?())			
				@@listeProfil.push(ligne)
			end
		}	
		
		profilList.close()
		if(profilList.closed?)
			#print "Profiles chargés !\n"
		end
	end

	#===Affiche le tableau des profiles
	#
	def toAff()
		print "\n Affichage des profils :\n"
		@@listeProfil.each { |profil|
			puts profil
		}
	end

end


profil = ProfilManager.new()
profil.loadFile()
profil.ajouter("Valentin")
profil.ajouter("Dimitri")
profil.toAff()

#profil.supprimer("Valentin")
#profil.rename("Dimitri", "DemiTruie")
#profil.ajouter("Valentin 2 : Le retour")
#profil.toAff()



#puts"Dernier Joueur = "+profil.dernierJoueur()
#profil.connecter("DemiTruie")
#puts"Dernier Joueur = "+profil.dernierJoueur()





