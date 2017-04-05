class UserDialog
    private_class_method :new

    @avatarList;

    def UserDialog.display()
        new();
    end

    def initialize()
        SudokuAPI.API.timerPaused = true;
        dialog = Gtk::Dialog.new(:parent => Window.window(), :title => "Utilisateurs", :flags => [:modal, :destroy_with_parent], :buttons => [["_OK", :ok]]);
        dialog.resizable = false;
        dialog.decorated = false;
        dialog.name = "userDialog"
        dialogArea = dialog.content_area;

        vbox = Gtk::Box.new(:vertical, 0);
        title = Gtk::Label.new("Choisissez un profil");
        title.name = "dialogTitle";
        hbox = Gtk::Box.new(:horizontal, 4);

        userComboBox = Gtk::ComboBoxText.new();
        users = ["Nouveau profil..."] + ProfilManager.listeProfile();
        users.reverse_each { |value|
            userComboBox.prepend_text(value);
        }
        userComboBox.set_active(0);

        nameEntry = Gtk::Entry.new();

        editIcon = Gtk::Image.new(:file => AssetManager.assetsResource("edit.png"));
        removeIcon = Gtk::Image.new(:file => AssetManager.assetsResource("eraser_big.png"));
        validateIcon = Gtk::Image.new(:file => AssetManager.assetsResource("checked.png"));
        cancelIcon = Gtk::Image.new(:file => AssetManager.assetsResource("cancel.png"));

        editButton = Gtk::Button.new();
        removeButton = Gtk::Button.new();
        validateButton = Gtk::Button.new();
        cancelButton = Gtk::Button.new();
        editButton.image = editIcon;
        removeButton.image = removeIcon;
        validateButton.image = validateIcon;
        cancelButton.image = cancelIcon;
        editButton.sensitive  = false;
        removeButton.sensitive  = false;

        userComboBox.signal_connect("changed") { |widget|
            editButton.sensitive = userComboBox.active != 0;
            removeButton.sensitive = userComboBox.active != 0;
        }

        hbox.pack_start(userComboBox, :expand => true, :fill => true, :padding => 0);
        hbox.add(editButton);
        hbox.add(removeButton);
        hbox.set_margin_top(6);
        hbox.set_margin_bottom(2);

        editButton.signal_connect("clicked") {
            hbox.remove(userComboBox);
            hbox.remove(editButton);
            hbox.remove(removeButton);

            nameEntry.text = userComboBox.active_text;
            hbox.pack_start(nameEntry, :expand => true, :fill => true, :padding => 0);
            hbox.add(validateButton);
            hbox.add(cancelButton);

            hbox.show_all();
        };

        validateButton.signal_connect("clicked") {
            idActive = userComboBox.active;
            result = ProfilManager.rename(userComboBox.active_text, nameEntry.text);
            if(result)
                userComboBox.remove(idActive);
                userComboBox.insert_text(idActive, nameEntry.text);
                userComboBox.set_active(idActive);

                hbox.remove(nameEntry);
                hbox.remove(validateButton);
                hbox.remove(cancelButton);

                hbox.pack_start(userComboBox, :expand => true, :fill => true, :padding => 0);
                hbox.add(editButton);
                hbox.add(removeButton);
            else
                puts "Failed"
            end
        }

        cancelButton.signal_connect("clicked") {
            hbox.remove(nameEntry);
            hbox.remove(validateButton);
            hbox.remove(cancelButton);

            hbox.pack_start(userComboBox, :expand => true, :fill => true, :padding => 0);
            hbox.add(editButton);
            hbox.add(removeButton);
        }

        removeButton.signal_connect("clicked") {

            confirmDialog = Gtk::MessageDialog.new(:parent => Window.window(), :flags => [:modal, :destroy_with_parent], :type => :question, :buttons => :yes_no, :message => "Supprimer le profil #{userComboBox.active_text} ?");
            confirmDialog.secondary_text = "Le profil ne poura pas être récupéré. Ses scores et configurations seront effacés";
            confirmResponse = confirmDialog.run();

            if(confirmResponse == :yes)
                ProfilManager.supprimer(userComboBox.active_text);
                userComboBox.remove(userComboBox.active);
                userComboBox.set_active(0);
            end

            confirmDialog.destroy();
        };

        vbox.pack_start(title, :expand => true, :fill => true, :padding => 0);
        vbox.add(hbox);
        vbox.set_border_width(1);

        vbox.show_all();
        dialogArea.pack_start(vbox);
        dialogArea.set_border_width(8);

        CSSStyle.apply_style(dialog);
        response = dialog.run();

        if(response == :ok)
            user = userComboBox.active_text;
            userIndex = userComboBox.active;

            #Log user
            if(userIndex != 0)
                SudokuAPI.API.timerPaused = false;
                Config.load()
                ProfilManager.connecter(userComboBox.active_text);
            else #New user
                RegisterView.display(false);
            end
        end

        dialog.destroy();
    end
end
