require "gtk3"
require "gio2"
require "gdk3"
require "pango"
require "observer"
require "yaml"

require "./view/Window.rb"
require "./view/GridView.rb"
require "./view/SquareView.rb"
require "./view/AssistantView.rb"
require "./view/CSSStyle.rb"
require "./view/Colors.rb"
require "./view/OverlayManager.rb"
require "./view/Header.rb"
require "./view/Menu.rb"
require "./view/ScoreDialog.rb"
require "./view/UserDialog.rb"
require "./view/ConfigDialog.rb"
require "./view/RegisterView.rb"

require "./model/AssetManager.rb"
require "./model/Generator.rb"
require "./model/Caze.rb"
require "./model/Sudoku.rb"
require "./model/ConfigEntry.rb"
<<<<<<< HEAD
require "./model/Score.rb"
require "./model/ScoreTable.rb"
=======
require "./model/ProfilManager.rb"
>>>>>>> refs/remotes/origin/master

require "./controller/SudokuAPI.rb"
require "./controller/Config.rb"
=begin
require "./controller/Method.rb"
require "./controller/MethodCrossReduce.rb"
require "./controller/MethodGroupIsolated.rb"
require "./controller/MethodInteractionsRegion.rb"
require "./controller/MethodTwinsAndTriplets.rb"
require "./controller/MethodUniqueCandidate.rb"
=end

Config.registerConfigs();
<<<<<<< HEAD
#Config.load();
=======
Config.load();

>>>>>>> refs/remotes/origin/master
myGenerator = Generator.new(0)

=begin HOW TO USE PROFILS
myProfil = ProfilManager.new()
myProfil.loadFile()
puts "Last found profile : " + myProfil.dernierJoueur()
=end

SudokuAPI.API.setSudoku(Sudoku.create(myGenerator.to_s), Sudoku.create(myGenerator.to_sPlayer), Sudoku.create(myGenerator.to_sCorrect));
Window.init();
