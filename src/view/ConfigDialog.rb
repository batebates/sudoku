#===Permet la génération de l'interface de configuration
class ConfigDialog

	@configDialog #this
	@conf #config que l'on récupère

	@mainVB #main vbox
	@entryNewList
	@avatarList
	@currentAvatar

	def ConfigDialog.init()
		new()
	end

	def initialize()
		@confEntry = Config.entries
		@entryNewList = Array.new

		@avatarList = Dir[AssetManager.assetsDir() + "/avatar_small/*.png"]
		@avatarIndex = Config.getValue("avatar");

		@mainVB = Gtk::Box.new(:vertical,1)
		@mainVB.name = "mainVB"

		#@confEntry = confEntry
		@configDialog = Gtk::Dialog.new(:parent => Window.window(), :title => "Configuration", :flags => [:modal, :destroy_with_parent])
		@configDialog.set_default_size(300,600)

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
				p "Config OK"
				configApply(); #applique la config
				@configDialog.destroy
		when Gtk::ResponseType::CANCEL
				p "Config Cancel"
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

		hBox = Gtk::Box.new(:horizontal, 2)
		hBox.name = "configEntry"
		@mainVB.pack_start(hBox)

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
			modConf.newValue = Colors.clone(modConf.value)

			hBox.pack_end(colorB,:expand=>false,:fill=>false,:padding=>2)
			colorB.signal_connect("color-set") {
				modConf.newValue.red = colorB.color.red
				modConf.newValue.green = colorB.color.green
				modConf.newValue.blue = colorB.color.blue
			}
		elsif (modConf.type == "avatar")
			bBox = Gtk::Box.new(:horizontal,0)
			leftBtn = Gtk::Button.new
			leftBtn.add(Gtk::Image.new(:file=>AssetManager.assetsResource("./back-small.png")))
			rightBtn = Gtk::Button.new
			rightBtn.add(Gtk::Image.new(:file=>AssetManager.assetsResource("./next-small.png")))
			leftBtn.name = "createUserChooser"
			rightBtn.name= "createUserChooser"

			@currentAvatar = Gtk::Image.new(:file=>@avatarList[modConf.value])


			@avatarIndex = modConf.value
			modConf.newValue = @avatarIndex
			leftBtn.signal_connect("clicked"){
				index = ((@avatarIndex - 1) % @avatarList.length)
				@currentAvatar.file = @avatarList[index]
				@avatarIndex = index
				modConf.newValue = @avatarIndex
			}

			rightBtn.signal_connect("clicked"){
				index = ((@avatarIndex + 1) % @avatarList.length)
				@currentAvatar.file = @avatarList[index]
				@avatarIndex = index
				modConf.newValue = @avatarIndex
			}

			bBox.add(leftBtn)
			bBox.add(@currentAvatar)
			bBox.add(rightBtn)

			hBox.pack_end(bBox)
		end

		return hBox
	end

	def configApply()
		@entryNewList.each{ |cl|
			if cl.type == "color"
				cl.value.red = cl.newValue.red
				cl.value.green = cl.newValue.green
				cl.value.blue = cl.newValue.blue
			elsif cl.type == "avatar"
				cl.value = cl.newValue
			end
		}
		Config.set(@entryNewList);
		Config.save();
	end

end
