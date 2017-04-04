require "yaml"

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
	#
	#=== Return :
	#<b>return vrai si l'ajout est fait, faux sinon</b>
	def ProfilManager.ajouter(pseudo)
		if(!self.existe(pseudo))
			@@listeProfil.push(pseudo)
			self.save()
			return true
		else
			puts "Pseudo deja pris"
		end
		return false
	end

	#=== Methode de classe permettant la suppression d'un profile
	#
	#=== Paramètres:
	#<b>pseudo</b>  	: pseudo du joueur
	#
	#=== Return :
	#<b>return vrai si la suppression est faite, faux sinon</b>
	def ProfilManager.supprimer(pseudo)
		if(self.existe(pseudo))
			@@listeProfil.delete_at(@@listeProfil.index(pseudo))
			self.save()
			return true
		else
			puts "Pseudo non présent"
		end
		return false
	end

	#=== Methode de classe permettant de renommer un profil
	#
	#=== Paramètres:
	#<b>oldName</b>  	: pseudo actuel du profil
	#<b>newName</b>		: nouveau pseudo du profil
	#
	#=== Return :
	#<b>return vrai si le pseudo a été renommer, faux sinon</b>
	def ProfilManager.rename(oldName, newName)
		if(self.existe(oldName) && !self.existe(newName))
			@@listeProfil[@@listeProfil.index(oldName)] = newName;
			if(@@dernierPseudo == oldName)
				@@dernierPseudo = newname
			end
			self.save();
			return true
		end
		return false
	end

	#=== Methode de classe permettant de connecter un joueur
	#
	#=== Paramètres:
	#<b>nom</b>  	: nom du joueur qui se connecte
	def ProfilManager.connecter(nom)
		if(self.existe(nom))
			@@dernierPseudo = nom;
			self.save();
		else
			puts "Pseudo non présent"
		end
	end

	#=== Methode de classe permettant de recuperer le pseudo du dernier joueur
	#
	def ProfilManager.dernierJoueur()
		return @@dernierPseudo
	end

	#=== Methode de classe permettant de recuperer la liste des pseudo
	#
	def ProfilManager.listeProfile()
		return @@listeProfile
	end

	#=== Methode permettant de tester l'existence d'un profil
	#
	#=== Paramètres :
	#<b>listProfils</b> : tableau de profile dans lesquels vérifier
	#
	#=== Return :
	#<b>return vrai si le pseudo est présent, faux sinon</b>
	def ProfilManager.existe(nom)
		@@listeProfil.index(nom) != nil;
	end

	#=== Methode Sauvegardant les profiles dans un fichier txt
	#
	def ProfilManager.save()
		userFile = File.new("users.yml","w")
        
		if(!userFile.closed?)
            puts "Ouverture liste utilisateur\n"
		end
	
		dumpArray = [];
		dumpArray.push(@@dernierPseudo);
		dumpArray.push(@@listeProfil);

		userFile.puts YAML::dump(dumpArray)
		userFile.close

        if(!userFile.closed?)
            puts "Fermeture liste utilisateur\n"
		end
	end

	#=== Methode de classes permettant de charger un tableau de profil a partir d'un fichier
	#
	def ProfilManager.loadFile()
		if(!File.file?("users.yml"))
            return;
		end

		userFile = YAML.load_file("users.yml")
		if(userFile)
			@@dernierPseudo = userFile[0];
			@@listeProfil = userFile[1];
		end	
	end

	#===Affiche le tableau des profiles
	#
	def ProfilManager.toAff()
		print "\n Affichage des profils :\n"
		@@listeProfil.each { |profil|
			puts profil
		}
	end

end


profil = ProfilManager.new()
ProfilManager.loadFile()
ProfilManager.ajouter("Valentin")
ProfilManager.ajouter("Dimitri")
ProfilManager.toAff()

ProfilManager.supprimer("Valentin")
ProfilManager.rename("Dimitri", "The Mighty Dimitri")
ProfilManager.ajouter("Valention The Boss")
ProfilManager.toAff()


ProfilManager.connecter("The Mighty Dimitri")
puts"\nDernier Joueur = "+ProfilManager.dernierJoueur().to_s





