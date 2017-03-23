class Header
    private_class_method :new

    attr_reader :userLabel;
    @timeLabel;

    def Header.init()
        new();
    end

    def initialize()
        header = Gtk::HeaderBar.new();
        header.set_title(Window.window.title);
        header.set_subtitle("Groupe A");
        header.set_show_close_button(true);

        timeIcon = Gtk::Image.new(:file => AssetManager.assetsResource("clock.png"));
        userIcon = Gtk::Image.new(:file => AssetManager.assetsResource("user.png"));
        userButton = Gtk::Button.new();
        userButton.add(userIcon);
        userButton.signal_connect("clicked") { |widget|
            UserDialog.display();
        };

        @timeLabel = Gtk::Label.new("00:00");
        @timeLabel.name = "headerLabel";

        @userLabel = Gtk::Label.new("Michel");
        @userLabel.name = "headerLabel";

        header.pack_start(userButton);
        header.pack_start(@userLabel);
        header.pack_end(@timeLabel);
        header.pack_end(timeIcon);

        GLib::Timeout.add_seconds(1) {
            tickSeconds();
        }

        Window.window().set_titlebar(header);
    end

    def tickSeconds()
        if(!SudokuAPI.API.timerPaused)
            SudokuAPI.API.timer += 1;
            @timeLabel.label = timeDisplay(SudokuAPI.API.timer / 60) + ":" + timeDisplay(SudokuAPI.API.timer % 60);
        end

        return true;
    end

    def timeDisplay(time)
        return time = time <= 9 ? "0" + time.to_s : time.to_s;
    end
end
