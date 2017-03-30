require "gtk3"
require "gio2"
require "gdk3"
require "pango"
require "observer"

require "./view/Window.rb"
require "./view/GridView.rb"
require "./view/SquareView.rb"
require "./view/AssistantView.rb"
require "./view/CSSStyle.rb"
require "./view/Colors.rb"
require "./view/OverlayManager.rb"
require "./view/Header.rb"
require "./view/Menu.rb"
require "./view/OptionsDialog.rb"
require "./view/UserDialog.rb"
require "./view/ConfigDialog.rb"
require "./view/RegisterView.rb"

require "./model/AssetManager.rb"
require "./model/Generator.rb"
require "./model/Caze.rb"
require "./model/Sudoku.rb"
require "./model/ConfigEntry.rb"
require "./model/ProfilManager.rb"

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
Config.load();

myGenerator = Generator.new(0)

=begin HOW TO USE PROFILS
myProfil = ProfilManager.new()
myProfil.loadFile()
puts "Last found profile : " + myProfil.dernierJoueur()
=end

SudokuAPI.API.setSudoku(Sudoku.create(myGenerator.to_s), Sudoku.create(myGenerator.to_sPlayer), Sudoku.create(myGenerator.to_sCorrect));
Window.init();
