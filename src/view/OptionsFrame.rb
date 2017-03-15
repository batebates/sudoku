require 'gtk3'
#load 'MainMenu.rb'


#
#
# => WORK IN PROGRESS
#
#

class OptionsFrame < Gtk::Frame

	#Gtk.init

	@wid = Gtk::Window.new("Options")
	@wid.signal_connect('destroy'){
		Gtk.main_quit
	}
	@wid.set_default_size(200,600)
	@wid.set_resizable(FALSE)

	def initialize
		self.set_title("Options")
		self.signal_connect('destroy'){
			Gtk.main_quit
		}

	end

	#== BOXES

	@mainBox = Gtk::Box.new(:vertical,6) 		#Boite principale / Container Principal
	@vbox = Gtk::Box.new(:vertical,0) 			#Boite verticale contenant les éléments
	@colorBox = Gtk::Box.new(:horizontal,10)		#Boite de gestion des couleurs
	@profilBox = Gtk::Box.new(:vertical,2)	
	@gameBox = Gtk::Box.new(:vertical,2)	

	#==UTILS

	@scroll = Gtk::Scrollbar.new(Gtk::Orientation::VERTICAL)

	#===========================Game======================================#
	@gameLab = Gtk::Label.new
	@gameLab.set_markup("<span foreground='black'><big> <b> Jeu  </b></big></span>")

	@gBox = Gtk::Box.new(:horizontal, 2)
	ngBtn = Gtk::Button.new(:label=>"Nouveau")
	sgBtn = Gtk::FileChooserButton.new("Sauvegarder", Gtk::FileChooserAction::OPEN)
	lgBtn = Gtk::FileChooserButton.new("Charger", Gtk::FileChooserAction::OPEN)

	@gBox.pack_start(sgBtn, :expand=>true, :fill=>true, :padding=>1)	
	@gBox.pack_start(lgBtn, :expand=>true, :fill=>true, :padding=>1)

	@vgBox = Gtk::Box.new(:horizontal, 2)
	sLab = Gtk::Label.new("Sauvegarder")
	lLab = Gtk::Label.new("Charger")

	@vgBox.pack_start(sLab, :expand=>false, :fill=>true, :padding=>20)
	@vgBox.pack_start(lLab, :expand=>true, :fill=>true, :padding=>2)


	@gameBox.pack_start(ngBtn, :expand=>true, :fill=>true, :padding=>5)
	@gameBox.pack_start(@vgBox, :expand=>true, :fill=>true, :padding=>1)
	@gameBox.pack_start(@gBox, :expand=>true, :fill=>true, :padding=>1)

	
	@gameBox.set_border_width(2)

	#===========================Profil======================================#

	@prLab = Gtk::Label.new
	@prLab.set_markup("<span foreground='black'><big> <b> Profil  </b></big></span>")

	@bBox = Gtk::Box.new(:horizontal, 2)
	newBtn = Gtk::Button.new(:label=>"Nouv. Profil")
	changeBtn = Gtk::Button.new(:label=>"Gest. Profils")

	@bBox.pack_start(newBtn,:expand=>true,:fill=>true,:padding=>2)
	@bBox.pack_start(changeBtn,:expand=>true,:fill=>true,:padding=>2)
	
	@profilBox.add(@bBox)

	#===========================COLOR======================================#
	errBox = Gtk::Box.new(:vertical,2)
	errLab = Gtk::Label.new("Erreur")
	errorColBtn = Gtk::ColorButton.new
	errorColBtn.set_rgba(Gdk::RGBA.new(0.9,0,0,1))
	errBox.add(errorColBtn)
	errBox.add(errLab)
	#==Good
	goodBox = Gtk::Box.new(:vertical,2)
	goodLab = Gtk::Label.new("Correct")
	goodColBtn = Gtk::ColorButton.new
	goodColBtn.set_rgba(Gdk::RGBA.new(0,0.9,0,1))
	goodBox.add(goodColBtn)
	goodBox.add(goodLab)
	#==Indication
	indBox = Gtk::Box.new(:vertical,2)
	indLab = Gtk::Label.new("Indic.1")
	indColBtn = Gtk::ColorButton.new
	indColBtn.set_rgba(Gdk::RGBA.new(0.6,0.6,0.6,1))
	indBox.add(indColBtn)
	indBox.add(indLab)

	ind2Box = Gtk::Box.new(:vertical,2)
	ind2Lab = Gtk::Label.new("Indic.2")
	ind2ColBtn = Gtk::ColorButton.new
	ind2ColBtn.set_rgba(Gdk::RGBA.new(0.9,0.9,0.3,1))
	ind2Box.add(ind2ColBtn)
	ind2Box.add(ind2Lab)
	#==

	@colorBox.pack_start(errBox,:expand=>true, :fill=>true,:padding=>3)

	@colorBox.pack_start(goodBox,:expand=>true, :fill=>true,:padding=>3)

	@colorBox.pack_start(indBox,:expand=>true, :fill=>true,:padding=>3)

	@colorBox.pack_start(ind2Box,:expand=>true, :fill=>true,:padding=>3)	

	@colorLab = Gtk::Label.new
	@colorLab.set_markup("<span foreground='black'><big> <b> Colorisation  </b></big></span>")

	#===========================COLOR======================================#

	@mainBox.pack_start(@colorLab, :expand=>false, :fill=>true, :padding=>5)
	@mainBox.pack_start(@colorBox, :expand=>false, :fill=>true, :padding=>10)
	@mainBox.pack_start(@prLab, :expand=>false, :fill=>true, :padding=>5)
	@mainBox.pack_start(@profilBox, :expand=>false, :fill=>true, :padding=>10)
	@mainBox.pack_start(@gameLab, :expand=>false, :fill=>true, :padding=>5)
	@mainBox.pack_start(@gameBox, :expand=>false, :fill=>true, :padding=>10)

	@wid.add(@mainBox)
	@wid.show_all()

end
Gtk.main