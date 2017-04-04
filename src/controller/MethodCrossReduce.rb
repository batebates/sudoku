class MethodCrossReduce < Methode
  #===renvoi un texte expliquant la methode de reduction par croix
  def textMethod()
    raise "Pour placer un chiffre, rayez toutes les lignes, colonnes et régions qui contiennent déjà ce chiffre. Le chiffre devient alors candidat pour toutes les cases non rayées"
  end
  #===Creer un sudoku demontrant la technique de la reduction par croix
  def demoMethod()

  end

  def onSudokuMethod()
    self.grid.each do |nligne|
      nligne.each do |ncase|
        if ncase.getValue ==0
            tcandidats = Array.new()
            sRC = @sudokuAPI.squareRowColumn(ncase.x,ncase.y)
            1..9.each do |n|
              if(!sRC.include?(n) && ncase.candidats[n]==true)
                tcandidats.push(n)
              end
            end
            if !tcandidats.empty?

            end
        end
      end
    end
  end
end
