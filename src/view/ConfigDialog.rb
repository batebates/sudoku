class ConfigDialog

	@configDialog #this
	@conf #config que l'on récupère

	@mainVB #main vbox
	@entryNewList

	def ConfigDialog.init()
		new()
	end

	def initialize()
		@confEntry = Config.entries
		@entryNewList = Array.new

		@mainVB = Gtk::Box.new(:vertical,1)
		@mainVB.name = "mainVB"

		#@confEntry = confEntry
		@configDialog = Gtk::Dialog.new(:parent => Window.window(), :title => "Configuration", :flags => [:modal, :destroy_with_parent])
		@configDialog.set_default_size(300,500)

		@configDialog.add_button("Appliquer",Gtk::ResponseType::OK)
		@configDialog.add_button(Gtk::Stock::CANCEL, Gtk::ResponseType::CANCEL)
		@configDialog.set_default_response(Gtk::ResponseType::CANCEL)

		#HBT

    	initConf(@confEntry)

    	@configDialog.child.add(@mainVB)
    	@configDialog.child.show_all

    	CSSStyle.apply_style(@configDialog)
    	#res

    	result = @configDialog.run


		case result
		when Gtk::ResponseType::OK
				p "OK"
				configApply(); #applique la config
				@configDialog.destroy
		when Gtk::ResponseType::CANCEL
				p "Cancel"
				@configDialog.destroy
		when Gtk::ResponseType::CLOSE
				@configDialog.destroy
		end


	end

	def initConf(conf)
		for nConf in conf.entries
			@entryNewList.push(nConf.clone)
		end

		for modConf in @entryNewList
			@mainVB.pack_start(createEntry(modConf))
		end
	end

	def createEntry(modConf)
		hBox = Gtk::Box.new(:horizontal, 2)
		#css
		hBox.name = "configEntry"
		#css
		nameLab = Gtk::Label.new(modConf.displayName)
		hBox.pack_start(nameLab,:expand=>false,:fill=>true,:padding=>2)
		if(modConf.type == "bool")
			boolT = Gtk::Switch.new
			boolT.set_active(modConf.value)
			hBox.pack_end(boolT,:expand=>false,:fill=>false,:padding=>2)
			boolT.signal_connect("notify") {
				modConf.value = boolT.active?();
			}
		elsif (modConf.type == "color")
			colorB = Gtk::ColorButton.new
			colorB.set_color(modConf.value)
			hBox.pack_end(colorB,:expand=>false,:fill=>false,:padding=>2)
			colorB.signal_connect("color-set") {
				modConf.value.red = colorB.color.red
				modConf.value.green = colorB.color.green
				modConf.value.blue = colorB.color.blue
			}
		end
		return hBox
	end

	def configApply()
		Config.set(@entryNewList);
		Config.save();
	end

end