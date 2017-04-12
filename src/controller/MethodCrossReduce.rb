#<b>Auteur</b> Decrand Baptiste
#
#<b>Version</b> 1.0
#
#<b>Date</b> 05/04/2017
#
#=== Methode de la reduction par croix
#<b>Liste des méthodes
#*textMethod
#*demoMethod
#*onSudokuMethod
#firstCazeValue0
#</b>
class MethodCrossReduce < Methode
  @cazeonSudokuMethod
  #===renvoi un texte expliquant la methode de reduction par croix
  def textMethod()
    case @step
     when nil
      @type = "textMethod"
      @step = 0
      SudokuAPI.API.hideMenu(true)
      SudokuAPI.API.sudokuEditable(true)
       SudokuAPI.API.assistantMessage=("Cette méthode applique les règles de base du Sudoku")
     when 1
       SudokuAPI.API.assistantMessage=("Une case ne peut pas avoir pour valeur les chiffres\n déjà inscrit dans les unités(Ligne,colonne,région) de cette case")
     when 2
       SudokuAPI.API.assistantMessage=("Les candidats d'une case sont l'ensemble des\nchiffres qui ne sont pas présent dans les unités de cette case")
     when 3
      SudokuAPI.API.assistantMessage=("");
        SudokuAPI.API.hideMenu(false)
      SudokuAPI.API.sudokuEditable(false)
    end
    @step+=1
  end
  #===Creer un sudoku demontrant la technique de la reduction par croix
  def demoMethod()
    @type = "demoMethod"
    case @step
      when nil
        @step = 0
        SudokuAPI.API.hideMenu(true)
        SudokuAPI.API.sudokuEditable(true)
        SudokuAPI.API.saveSudoku("old");
        gridDemo = "375648129010925070200371000732089060400267000060034792020453917147896235953712648"
        SudokuAPI.API.setSudoku(Sudoku.create(gridDemo),Sudoku.create(gridDemo),Sudoku.create(gridDemo));
        SudokuAPI.API.assistantMessage=("Bienvenue dans la démo (cliquez sur suivant pour continuer)");
    when 1
      SudokuAPI.API.cazeAt(2,1).color=Colors::CL_HIGHLIGHT_METHOD;
      0.upto(8) do |i|
        0.upto(8) do |j|
          SudokuAPI.API.setHintAt(i,j,false)
        end
      end
      SudokuAPI.API.assistantMessage=("Nous allons appliquer la méthode sur la case verte");
     when 2
       SudokuAPI.API.squareRowColumn(2,1).each do |elt|
         SudokuAPI.API.cazeAt(elt.x,elt.y).color=Colors::CL_HIGHLIGHT_LINE;
       end
        SudokuAPI.API.cazeAt(2,1).color=Colors::CL_HIGHLIGHT_METHOD;
        SudokuAPI.API.assistantMessage=("Les candidats de cette case sont l'ensemble des\nchiffres qui ne sont pas présent dans\n les unités (bleu clair) de cette case");
     when 3
       SudokuAPI.API.squareRowColumn(2,1).each do |elt|
         SudokuAPI.API.cazeAt(elt.x,elt.y).color=Colors::CL_BLANK;
       end
       SudokuAPI.API.cazeAt(2,1).color=Colors::CL_HIGHLIGHT_METHOD;
       SudokuAPI.API.setHintAt(2,1,true)
       SudokuAPI.API.assistantMessage=("On obtient donc ces candidats pour cette case");
     when 4
        SudokuAPI.API.loadSudoku("old");
        SudokuAPI.API.assistantMessage=("Bonjour, je suis l'assistant, je suis là pour vous aider");
        SudokuAPI.API.hideMenu(false)
        SudokuAPI.API.sudokuEditable(false)
     end
    @step+=1
  end

  # Applique la methode sur la grile de sudoku actuel
  def onSudokuMethod()
    if @cazeonSudokuMethod == nil
      @cazeonSudokuMethod = firstCazeValue0()
    end
    @type = "onSudokuMethod"
    case @step
    when nil
        @step = 0
        SudokuAPI.API.hideMenu(true)
        SudokuAPI.API.sudokuEditable(true)
        SudokuAPI.API.assistantMessage=("Bienvenue dans la méthode (cliquez sur suivant pour continuer)");
    when 1
      SudokuAPI.API.cazeAt(@cazeonSudokuMethod.x,@cazeonSudokuMethod.y).color=Colors::CL_HIGHLIGHT_METHOD;
      0.upto(8) do |i|
        0.upto(8) do |j|
          SudokuAPI.API.setHintAt(i,j,false)
        end
      end
      SudokuAPI.API.assistantMessage=("Nous allons appliquer la méthode sur la case verte");
     when 2
       SudokuAPI.API.squareRowColumn(@cazeonSudokuMethod.x,@cazeonSudokuMethod.y).each do |elt|
         SudokuAPI.API.cazeAt(elt.x,elt.y).color=Colors::CL_HIGHLIGHT_LINE;
       end
        SudokuAPI.API.cazeAt(@cazeonSudokuMethod.x,@cazeonSudokuMethod.y).color=Colors::CL_HIGHLIGHT_METHOD;
        SudokuAPI.API.assistantMessage=("Les candidats de cette case sont l'ensemble des\nchiffres qui ne sont pas présent dans\n les unités (bleu clair) de cette case");
     when 3
       SudokuAPI.API.squareRowColumn(@cazeonSudokuMethod.x,@cazeonSudokuMethod.y).each do |elt|
         SudokuAPI.API.cazeAt(elt.x,elt.y).color=Colors::CL_BLANK;
       end
       SudokuAPI.API.cazeAt(@cazeonSudokuMethod.x,@cazeonSudokuMethod.y).color=Colors::CL_HIGHLIGHT_METHOD;
       SudokuAPI.API.setHintAt(@cazeonSudokuMethod.x,@cazeonSudokuMethod.y,true)
       SudokuAPI.API.assistantMessage=("On obtient donc ces candidats pour cette case");
     when 4
        SudokuAPI.API.loadSudoku("old");
        SudokuAPI.API.assistantMessage=("Bonjour, je suis l'assistant, je suis là pour vous aider");
        SudokuAPI.API.hideMenu(false)
        SudokuAPI.API.sudokuEditable(false)
      end
    @step+=1
  end

  # renvoi la premiere case n'ayant pas de valeur
  def firstCazeValue0()
    0.upto(8) do |i|
      0.upto(8) do |j|
        if(SudokuAPI.API.cazeAt(i,j).value == 0)
          return SudokuAPI.API.cazeAt(i,j)
        end
      end
    end
  end
end
