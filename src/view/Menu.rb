class Menu
	private_class_method :new

	def Menu.init(parent)
		new(parent);
	end

	def initialize(parent)
		myGenerator = nil

		bNewGrid = createButton("grid.png", "Nouvelle partie");
		bSaveGrid = createButton("save.png", "Sauvegarder partie");
		bLoadGrid = createButton("load.png", "Charger partie");

		bMethod1 = createButton("info.png", "Méthode 1");
		bMethod2 = createButton("info.png", "Méthode 2");
		bMethod3 = createButton("info.png", "Méthode 3");
		bMethod4 = createButton("info.png", "Méthode 4");
		bMethod5 = createButton("info.png", "Méthode 5");

		bOptions = createButton("gears.png", "Options");
		bQuit = createButton("exit.png", "Quitter");

		vBox = Gtk::Box.new(:vertical,0);
		vBox.pack_start(createTitle("Menu Principal"));
		vBox.pack_start(bNewGrid);
		vBox.pack_start(bSaveGrid);
		vBox.pack_start(bLoadGrid);
		vBox.pack_start(createTitle("Méthodes"));
		vBox.pack_start(bMethod1);
		vBox.pack_start(bMethod2);
		vBox.pack_start(bMethod3);
		vBox.pack_start(bMethod4);
		vBox.pack_start(bMethod5);
		vBox.pack_start(createTitle("Autres"));
		vBox.pack_start(bOptions);
		vBox.pack_start(bQuit);
		vBox.set_margin_left(4);
		vBox.name = "rightMenu";

		#End Define

		#Quitter
		bQuit.signal_connect("clicked"){
			#Pop up de validation
			Gtk.main_quit();
		}

		bOptions.signal_connect("clicked"){
			ConfigDialog.init()
		}

		bNewGrid.signal_connect("clicked"){
			myGenerator = Generator.new(0)
			SudokuAPI.API.setSudoku(Sudoku.create(myGenerator.to_s), Sudoku.create(myGenerator.to_sPlayer), Sudoku.create(myGenerator.to_sCorrect));
		}
		
		bSaveGrid.signal_connect("clicked"){
			SudokuAPI.API.saveSudoku("Michel")
		}
		
		bLoadGrid.signal_connect("clicked"){
			SudokuAPI.API.loadSudoku("Michel")
		}


		parent.attach(vBox, 1, 0, 1, 1);
	end

	def createButton(icon, text)
		icon = Gtk::Image.new(:file => AssetManager.assetsResource(icon));
		icon.set_margin_right(10);
		label = Gtk::Label.new(text);
		box = Gtk::Box.new(:horizontal, 0);
		box.add(icon);
		box.add(label);

		button = Gtk::Button.new();
		button.name = "menuButton"
		button.add(box);

		return button;
	end

	def createTitle(text)

		box = Gtk::Box.new(:horizontal, 0);
		box.name = "rightMenuTitlePanel";
		label = Gtk::Label.new();
		label.set_selectable(false);
		label.set_markup(text);
		label.name = "rightMenuTitle";
		box.pack_start(label, :expand => true, :fill => true, :padding => 0);

		return box;
	end
end
