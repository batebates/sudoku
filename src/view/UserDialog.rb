class UserDialog
    private_class_method :new

    def UserDialog.display()
        new();
    end

    def initialize()
        dialog = Gtk::Dialog.new(:parent => Window.window(), :title => "Utilisateurs", :flags => [:modal, :destroy_with_parent], :buttons => [["_OK", :ok], ["_Cancel", :cancel]]);
        dialogArea = dialog.content_area;

        box = Gtk::Grid.new();
        title = Gtk::Label.new("Choisissez un profil :");
        hbox = Gtk::Box.new(:horizontal, 4);

        userComboBox = Gtk::ComboBoxText.new();
        users = ["Nouveau profil..."] + ["Michel", "Patrick", "Luc"];
        users.reverse_each { |value|
            userComboBox.prepend_text(value);
        }
        userComboBox.set_active(0);

        editIcon = Gtk::Image.new(:file => AssetManager.assetsResource("edit.png"));
        removeIcon = Gtk::Image.new(:file => AssetManager.assetsResource("cross.png"));

        editButton = Gtk::Button.new();
        removeButton = Gtk::Button.new();
        editButton.add(editIcon);
        removeButton.add(removeIcon);

        hbox.pack_start(userComboBox, :expand => true, :fill => true, :padding => 0);
        hbox.add(editButton);
        hbox.add(removeButton);

        box.attach(title, 0, 0, 1, 1);
        box.attach(hbox, 0, 1, 1, 1);
        box.set_border_width(5);

        box.show_all();
        dialogArea.pack_start(box);
        response = dialog.run();

        if response == :ok

        end

        dialog.destroy();
    end
end
