class Menu
	private_class_method :new

	@menu

	def Menu.init(parent)
		new(parent);
	end

	def initialize(parent)
		SudokuAPI.API.add_observer(self);
		myGenerator = nil

		bNewGrid = createButton("grid.png", "Nouvelle partie");
		bEasy = Gtk::Button.new(:label => "Facile");
		bMedium = Gtk::Button.new(:label => "Moyen");
		bHard = Gtk::Button.new(:label => "Difficile");
		addPopHoverToButton(bNewGrid, :left, bEasy, bMedium, bHard);
		bEasy.signal_connect("clicked") {
			generateSudoku(0);
			hidePopover(bEasy);
		}
		bMedium.signal_connect("clicked") {
			generateSudoku(1);
			hidePopover(bMedium);
		}
		bHard.signal_connect("clicked") {
			generateSudoku(2);
			hidePopover(bHard);
		}

		bSaveGrid = createButton("save.png", "Sauvegarder partie");
		bLoadGrid = createButton("load.png", "Charger partie");
		bScoreTable = createButton("scoreboard.png", "Tableau des Scores");

		bMethod1 = createMethodButton("info.png", "Cross Reduce", "MethodCrossReduce");
		bMethod2 = createMethodButton("info.png", "Group Isolated", "MethodGroupIsolated");
		bMethod3 = createMethodButton("info.png", "Interactions Regions", "MethodInteractionsRegions");
		bMethod4 = createMethodButton("info.png", "Twins & Triplets", "MethodTwinsAndTriplets");
		bMethod5 = createMethodButton("info.png", "Unique candidate", "MethodUniqueCandidate");

		bOptions = createButton("gears.png", "Options");
		bQuit = createButton("exit.png", "Quitter");

		vBox = Gtk::Box.new(:vertical,0);
		vBox.pack_start(createTitle("Menu Principal"));
		vBox.pack_start(bNewGrid);
		vBox.pack_start(bSaveGrid);
		vBox.pack_start(bLoadGrid);
		vBox.pack_start(bScoreTable);
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

		bSaveGrid.signal_connect("clicked"){
			if(SudokuAPI.API.username == nil)
				print("Créez un profil avant de charger")
			else
				SudokuAPI.API.saveSudoku(SudokuAPI.API.username)
			end
		}

		bLoadGrid.signal_connect("clicked"){
			if(SudokuAPI.API.username == nil)
				print("Créez un profil avant de charger")
			else
				SudokuAPI.API.loadSudoku(SudokuAPI.API.username)
			end
		}

		@menu = vBox;

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

	def addPopHoverToButton(widget, pos, *childs)
		popover = Gtk::Popover.new(widget);
		popover.position = pos;
		container = Gtk::Box.new(:vertical, 0);
		childs.each{ |child|
			container.add(child);
			child.margin = 2;
			child.show();
		}

		container.show();
		popover.add(container);

		widget.signal_connect("clicked"){ |button|
			popover.visible = true;
		}
	end

	def hidePopover(widget)
		widget.parent.parent.visible = false;
	end

	def generateSudoku(difficulty)
		myGenerator = Generator.new(difficulty);
		SudokuAPI.API.setSudoku(Sudoku.create(myGenerator.to_s), Sudoku.create(myGenerator.to_sPlayer), Sudoku.create(myGenerator.to_sCorrect));
	end

	def createMethodButton(icon, text, className)
		button = createButton(icon, text);
		bText = Gtk::Button.new(:label => "Texte assistant");
		bDemo = Gtk::Button.new(:label => "Grille de démo");
		bSudoku = Gtk::Button.new(:label => "Grille actuelle");
		addPopHoverToButton(button, :left, bText, bDemo, bSudoku);

		bText.signal_connect("clicked") {
			methode = Object::const_get(className).new;
			SudokuAPI.API.methode = methode;
			hidePopover(bText);
			methode.textMethod();
		}

		bDemo.signal_connect("clicked") {
			methode = Object::const_get(className).new;
			SudokuAPI.API.methode = methode;
			hidePopover(bDemo);
			methode.demoMethod();
		}

		bSudoku.signal_connect("clicked") {
			methode = Object::const_get(className).new;
			SudokuAPI.API.methode = methode;
			hidePopover(bSudoku);
			methode.onSudokuMethod();
		}

		return button;
	end

	def update(type, data)
		if(type == "hideMenu")
			@menu.name = data ? "rightMenuHidden" : "rightMenu"
			@menu.children.each { |widget|
				if(widget.instance_of?(Gtk::Button))
					widget.sensitive=!data
				end
			}
		end
	end
end
