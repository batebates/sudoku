class Methode

	def textMethod
		raise "Ceci est une methode abstraite. This is an abstact method.";
	end

	def demoMethod
		raise "Ceci est une methode abstraite. This is an abstact method.";
	end

	def onSudokuMethod
		raise "Ceci est une methode abstraite. This is an abstact method.";
	end

	#===Retourne le nombre de fois où un candidat est présent dans une unité
	#
	#===Paramètres :
	# <b>unite</b> : tableau d'une unité
	def nbCandidate(unite)
		nbCandid = Array.new(9);
		unite.each{ |caze|
			candidats = candidateCaze(caze.x, caze.y)
			candidats.each{ |candid|
				nbCandid[candid]+=1
			}
		}
		return nbCandidate
	end

	#===Regarde si une unité possède un candidat présent une seule fois, si c'est le cas, retourne le candidat en question, retourne 0 sinon
	#
	#===Paramètres :
	#* <b>nbCandid</b> : prend un tableau retourné par nbCandidate
	def uniqueCandidate(nbCandid)
		res = 0
		nbCandid.each{ |nb|
			if nb == 1
				res = nb
			end
		}
		return res
	end
end
