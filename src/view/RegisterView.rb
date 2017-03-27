class RegisterView
    private_class_method :new

    def RegisterView.display(newGame)
        new(newGame);
    end

    def initialize(newGame)
        window = Window.window();
        SudokuAPI.API.timerPaused = true;
        root = Window.root;
        sudokuPanel = root.children[0];
        sudokuPanel.hide();

        mainPanel = Gtk::Box.new(:horizontal, 0);
        columnPanel = Gtk::Box.new(:vertical, 4);

        title = Gtk::Label.new(newGame ? "Bienvenue, créez un profil" : "Création d'un nouveau profil");
        title.name = "createUserTitle";
        title.set_margin_bottom(20);
        title.set_margin_top(40);

        chooseAvatarBox = Gtk::Box.new(:horizontal, 4);
        leftButton = Gtk::Button.new();
        leftButton.add(Gtk::Image.new(:file => AssetManager.assetsResource("./back.png")));
        rightButton = Gtk::Button.new();
        rightButton.add(Gtk::Image.new(:file => AssetManager.assetsResource("./next.png")));
        rightButton.name = "createUserChooser";
        leftButton.name = "createUserChooser";
        currentAvatar = Gtk::Image.new(:file => AssetManager.assetsResource("./avatar_big/professor.png"));

        chooseAvatarBox.add(leftButton);
        chooseAvatarBox.add(currentAvatar);
        chooseAvatarBox.add(rightButton);

        nameInfo = Gtk::Label.new("Entrez votre nom d'utilisateur :");
        nameInfo.set_margin_bottom(0);
        nameInfo.set_margin_top(10);
        nameEntry = Gtk::Entry.new();
        nameError = Gtk::Label.new("Nom trop court !");
        nameError.set_margin_bottom(10);
        nameError.name = "createUserError";

        buttonBox = Gtk::Box.new(:horizontal, 4);
        buttonConfirm = Gtk::Button.new(:label => "Valider");
        buttonConfirm.sensitive = false;
        buttonConfirm.signal_connect("clicked") {
            #TODO save user
            root.remove(mainPanel);
            sudokuPanel.show_all();
        }

        nameEntry.signal_connect("changed"){ |d|
            onTextEdit(nameEntry, nameError, buttonConfirm);
        }

        buttonBack = Gtk::Button.new(:label => "Retour");
        buttonBack.signal_connect("clicked") {
            root.remove(mainPanel);
            sudokuPanel.show_all();
        }

        buttonBox.pack_start(buttonConfirm, :expand => true, :fill => true, :padding => 0);
        buttonBox.pack_start(buttonBack, :expand => true, :fill => true, :padding => 0) unless newGame;

        columnPanel.add(title);
        columnPanel.add(chooseAvatarBox);
        columnPanel.add(nameInfo);
        columnPanel.add(nameEntry);
        columnPanel.add(nameError);
        columnPanel.add(buttonBox);

        mainPanel.pack_start(columnPanel, :expand => true, :fill => false, :padding => 0);

        mainPanel.set_size_request(root.allocation.width, root.allocation.height);
        mainPanel.show_all();

        root.pack_start(mainPanel, :expand => true, :fill => true, :padding => 0);

        CSSStyle.apply_style(mainPanel);
    end

    def onTextEdit(nameEntry, nameError, buttonConfirm)
        result = true;
        if(nameEntry.text.length < 3)
            nameError.label = "Nom trop court !";
            result = false;
        elsif(nameEntry.text.length > 10)
            nameError.label = "Nom trop long !";
            result = false;
        end

        if(!nameEntry.text.count("^a-zA-Z0-9_").zero?)
            nameError.label = "Le nom doit être alpha numérique";
            result = false;
        end

        buttonConfirm.sensitive = result;

        if(result)
            nameError.label = "Nom valide";
            nameError.name = "createUserErrorValid";
        else
            nameError.name = "createUserError";
        end
    end
end
