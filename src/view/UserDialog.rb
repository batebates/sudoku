class UserDialog
    private_class_method :new

    @selectedIndex

    def UserDialog.display()
        new();
    end

    def initialize()
        @selectedIndex = 0;
        dialog = Gtk::Dialog.new(:parent => Window.window(), :title => "Utilisateurs", :flags => [:modal, :destroy_with_parent], :buttons => [["_OK", :ok]]);
        dialog.resizable = false;
        dialog.decorated = false;
        dialogArea = dialog.content_area;

        vbox = Gtk::Box.new(:vertical, 0);
        title = Gtk::Label.new("Choisissez un profil");
        title.name = "userTitle";
        hbox = Gtk::Box.new(:horizontal, 4);

        userComboBox = Gtk::ComboBoxText.new();
        users = ["Nouveau profil..."] + ["Michel", "Patrick", "Luc"];
        users.reverse_each { |value|
            userComboBox.prepend_text(value);
        }
        userComboBox.set_active(0);

        editIcon = Gtk::Image.new(:file => AssetManager.assetsResource("edit.png"));
        removeIcon = Gtk::Image.new(:file => AssetManager.assetsResource("eraser_big.png"));

        editButton = Gtk::Button.new();
        removeButton = Gtk::Button.new();
        editButton.image=(editIcon);
        removeButton.image=(removeIcon);
        editButton.sensitive  = false;
        removeButton.sensitive  = false;

        userComboBox.signal_connect("changed") { |widget|
            @selectedIndex = userComboBox.active;
            editButton.sensitive = @selectedIndex != 0;
            removeButton.sensitive = @selectedIndex != 0;
        }

        hbox.pack_start(userComboBox, :expand => true, :fill => true, :padding => 0);
        hbox.add(editButton);
        hbox.add(removeButton);
        hbox.set_margin_top(6);
        hbox.set_margin_bottom(2);

        vbox.pack_start(title, :expand => true, :fill => true, :padding => 0);
        vbox.add(hbox);
        vbox.set_border_width(1);

        vbox.show_all();
        dialogArea.pack_start(vbox);
        dialogArea.set_border_width(8);
        response = dialog.run();

        if response == :ok

        end

        dialog.destroy();
    end
end
