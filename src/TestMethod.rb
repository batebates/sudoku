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

require "./controller/SudokuAPI.rb"
require "./controller/Config.rb"

require "./controller/MethodUniqueCandidate.rb"

Config.registerConfigs();
Config.load();
testd = MethodUniqueCandidate.new.demoMethod;
