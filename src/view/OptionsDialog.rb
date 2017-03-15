require 'gtk3'
#load 'MainMenu.rb'

class OptionsDialog

	#Gtk.init
	private_class_method :new

	@optDialog
	@errorColBtn
	@goodColBtn
	@indColBtn
	@ind2ColBtn

	def OptionsDialog.init()
		new()
	end

	def initialize()
		@optDialog = Gtk::Dialog.new(:title=>"Options")
		@optDialog.set_default_size(300,600)

		init_elemts

		@optDialog.add_button("Appliquer", Gtk::ResponseType::OK)
		@optDialog.add_button(Gtk::Stock::CANCEL, Gtk::ResponseType::CANCEL)
		@optDialog.set_default_response(Gtk::ResponseType::CANCEL)
	
		result = @optDialog.run
		case result
		when Gtk::ResponseType::OK
			p "OK"
			#Do something
			@optDialog.destroy
		when Gtk::ResponseType::CANCEL
			p "CANCEL"
			@optDialog.destroy
		when Gtk::ResponseType::CLOSE
			@optDialog.destroy
		end
				
	end

	#== BOXES

	def init_elemts
		mainBox = Gtk::Box.new(:vertical,6) 		#Boite principale / Container Principal
		vbox = Gtk::Box.new(:vertical,0) 			#Boite verticale contenant les éléments
		colorBox = Gtk::Box.new(:horizontal,10)		#Boite de gestion des couleurs
		profilBox = Gtk::Box.new(:vertical,2)	

		#==UTILS

		#===========================Game======================================#
	
		vgBox = Gtk::Box.new(:horizontal, 2)
		sLab = Gtk::Label.new("Sauvegarder")
		lLab = Gtk::Label.new("Charger")

		vgBox.pack_start(sLab, :expand=>false, :fill=>true, :padding=>20)
		vgBox.pack_start(lLab, :expand=>true, :fill=>true, :padding=>2)

		#===========================Profil======================================#

		prLab = Gtk::Label.new
		prLab.set_markup("<span foreground='black'><big> <b> Profil  </b></big></span>")

		bBox = Gtk::Box.new(:horizontal, 2)
		
		#==// Button
		newBtn = Gtk::Button.new(:label=>"Nouv. Profil")
		changeBtn = Gtk::Button.new(:label=>"Gest. Profils")

		#==// Button

		bBox.pack_start(newBtn,:expand=>true,:fill=>true,:padding=>2)
		bBox.pack_start(changeBtn,:expand=>true,:fill=>true,:padding=>2)
		
		profilBox.add(bBox)

		#===========================COLOR======================================#
		
		#==error
		errBox = Gtk::Box.new(:vertical,2)
		errLab = Gtk::Label.new("Erreur")
		@errorColBtn = Gtk::ColorButton.new
		@errorColBtn.set_rgba(Gdk::RGBA.new(0.9,0,0,1))
		errBox.add(@errorColBtn)
		errBox.add(errLab)
		
		#==Good
		goodBox = Gtk::Box.new(:vertical,2)
		goodLab = Gtk::Label.new("Correct")
		@goodColBtn = Gtk::ColorButton.new
		@goodColBtn.set_rgba(Gdk::RGBA.new(0,0.9,0,1))
		goodBox.add(@goodColBtn)
		goodBox.add(goodLab)
		
		#==Indication
		indBox = Gtk::Box.new(:vertical,2)
		indLab = Gtk::Label.new("Indic.1")
		@indColBtn = Gtk::ColorButton.new
		@indColBtn.set_rgba(Gdk::RGBA.new(0.6,0.6,0.6,1))
		indBox.add(@indColBtn)
		indBox.add(indLab)

		ind2Box = Gtk::Box.new(:vertical,2)
		ind2Lab = Gtk::Label.new("Indic.2")
		@ind2ColBtn = Gtk::ColorButton.new
		@ind2ColBtn.set_rgba(Gdk::RGBA.new(0.9,0.9,0.3,1))
		ind2Box.add(@ind2ColBtn)
		ind2Box.add(ind2Lab)
		#==

		colorBox.pack_start(errBox,:expand=>true, :fill=>true,:padding=>3)

		colorBox.pack_start(goodBox,:expand=>true, :fill=>true,:padding=>3)

		colorBox.pack_start(indBox,:expand=>true, :fill=>true,:padding=>3)

		colorBox.pack_start(ind2Box,:expand=>true, :fill=>true,:padding=>3)	

		colorLab = Gtk::Label.new
		colorLab.set_markup("<span foreground='black'><big> <b> Colorisation  </b></big></span>")

		#===========================COLOR======================================#

		mainBox.pack_start(colorLab, :expand=>false, :fill=>true, :padding=>5)
		mainBox.pack_start(colorBox, :expand=>false, :fill=>true, :padding=>10)
		mainBox.pack_start(prLab, :expand=>false, :fill=>true, :padding=>5)
		mainBox.pack_start(profilBox, :expand=>false, :fill=>true, :padding=>10)

		@optDialog.child.add(mainBox)
		@optDialog.child.show_all
	end

end