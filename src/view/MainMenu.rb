require 'gtk3'
require "../model/AssetManager.rb"
require "./CSSStyle.rb"

#
#
# => WORK IN PROGRESS
#
#

class MainMenu

	@mainWindow = Gtk::Window.new("Menu")
	@mainWindow.signal_connect('destroy'){
		Gtk.main_quit
	}

	#=================Methods===============#
	#Define

	#@@opt = OptionsFrame.new

	#Image
	@iOpt = Gtk::Image.new(:file=>AssetManager.assetsResource('assistant.png'))
	@iOpt2 = Gtk::Image.new(:file=>AssetManager.assetsResource('gears.png'))
	@iNG = Gtk::Image.new(:file=>AssetManager.assetsResource('grid.png'))
	@iSav = Gtk::Image.new(:file=>AssetManager.assetsResource('save.png'))
	@iLoad = Gtk::Image.new(:file=>AssetManager.assetsResource('load.png'))

	lOpt = Gtk::Label.new("Options")
	lNG = Gtk::Label.new("Nouvelle Grille")
	lSav = Gtk::Label.new("Sauvegarder")
	lLoa = Gtk::Label.new("Charger Grille")

	box1 = Gtk::Box.new(:vertical,0).add(@iOpt).add(lOpt)
	box2 = Gtk::Box.new(:vertical,0).add(@iNG).add(lNG)
	box3 = Gtk::Box.new(:vertical,0).add(@iSav).add(lSav)
	box4 = Gtk::Box.new(:vertical,0).add(@iLoad).add(lLoa)
	#!

	@bNewGrid = Gtk::Button.new().add(box2)
	@bSaveGrid = Gtk::Button.new().add(box3)
	@bLoadGrid = Gtk::Button.new().add(box4)
	@bOptions = Gtk::Button.new().add(box1)
	@bQuit = Gtk::Button.new(:label=>'Quitter')


	@cC = Gtk::ColorChooserDialog.new(:title=>"Select Color")

	@menuLab = Gtk::Label.new
	@menuLab.set_selectable(false)
	@menuLab.set_markup("<span foreground='green'><big> <b> Menu Principal </b></big></span>")


	@box = Gtk::Box.new(:horizontal,0).add(@menuLab)

	@vBox = Gtk::Box.new(:vertical,0)
	@vBox.pack_start(@box)
	@vBox.pack_start(@bNewGrid)
	@vBox.pack_start(@bSaveGrid)
	@vBox.pack_start(@bLoadGrid)
	@vBox.pack_start(@bOptions)
	@vBox.pack_start(@bQuit)

	#End Define

	#Quitter
	@bQuit.signal_connect('clicked'){
		#Pop up de validation

		#Quit
		Gtk.main_quit
	}

	@bOptions.signal_connect('clicked'){
		@@opt.run
	}
	#End Quitter

	#NewGrid
	@bNewGrid.signal_connect('pressed'){
		@bNewGrid.override_color(:normal,Gdk::RGBA.new(255,211,13,1))
		#newGrid();
	}
	@bNewGrid.signal_connect('released'){
		@bNewGrid.override_color(:normal,Gdk::RGBA.new(0,0,0,1))
	}
	#End newGrid


	#Show

	@mainWindow.add(@vBox)
	@mainWindow.show_all


end

Gtk.main