class Header
    private_class_method :new

    attr_reader :time, :userLabel;
    @timeLabel;

    def Header.init()
        new();
    end

    def initialize()
        @time = 0;
        header = Gtk::HeaderBar.new();
        header.set_title(Window.window.title);
        header.set_subtitle("Groupe A");
        header.set_show_close_button(true);

        timeIcon = Gtk::Image.new(:file => AssetManager.assetsResource("clock.png"));
        userIcon = Gtk::Image.new(:file => AssetManager.assetsResource("user.png"));
        userButton = Gtk::Button.new();
        userButton.add(userIcon);

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
        @time += 1;
        @timeLabel.label = timeDisplay(@time / 60) + ":" + timeDisplay(@time % 60);

        return true;
    end

    def timeDisplay(time)
        return time = time <= 9 ? "0" + time.to_s : time.to_s;
    end
end
