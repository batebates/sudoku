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
	#
	#=== Return :
	#<b>return vrai si l'ajout est fait, faux sinon</b>
	def ProfilManager.ajouter(pseudo)
		if(!ProfilManager.existe(pseudo))
			@@listeProfil.push(pseudo)
			ProfilManager.save()
			return true
		else
			return false
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
		if(ProfilManager.existe(pseudo) && pseudo != @@dernierPseudo)
			@@listeProfil.delete_at(@@listeProfil.index(pseudo))
			ProfilManager.save()

			if (File.file?("save_files/" + pseudo + ".yml"))
				File.delete("save_files/" + pseudo + ".yml");
			end

			if (File.file?("save_files/" + pseudo))
				File.delete("save_files/" + pseudo);
			end

			return true
		else
			return false
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
		if(ProfilManager.existe(oldName) && !ProfilManager.existe(newName))
			@@listeProfil[@@listeProfil.index(oldName)] = newName;
			if(@@dernierPseudo == oldName)
				@@dernierPseudo = newName
			end
			ProfilManager.save();

			if (File.file?("save_files/" + oldName + ".yml"))
				File.rename("save_files/" + oldName + ".yml", "save_files/" + newName + ".yml");
			end

			if (File.file?("save_files/" + oldName))
				File.rename("save_files/" + oldName, "save_files/" + newName);
			end

			return true
		end
		return false
	end

	#=== Methode de classe permettant de connecter un joueur
	#
	#=== Paramètres:
	#<b>nom</b>  	: nom du joueur qui se connecte
	def ProfilManager.connecter(nom)
		if(ProfilManager.existe(nom))
			@@dernierPseudo = nom;
			ProfilManager.save();
			SudokuAPI.API.username = nom;
			return true
		else
			return false
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
		return @@listeProfil
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

	#=== Methode Sauvegardant les profils dans un fichier txt
	#
	def ProfilManager.save()
		userFile = File.new("save_files/users.yml","w")

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
		if(!File.file?("save_files/users.yml"))
            return;
		end

		userFile = YAML.load_file("save_files/users.yml")
		if(userFile)
			@@dernierPseudo = userFile[0];
			@@listeProfil = userFile[1];
		end
	end

	#===Affiche le tableau des profils
	#
	def ProfilManager.toAff()
		print "\n Affichage des profils :\n"
		@@listeProfil.each { |profil|
			puts "   - " + profil
		}
	end
end
