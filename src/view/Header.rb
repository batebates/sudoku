require "gtk3"

class Header
    private_class_method :new

    @time;

    def Header.init()
        new();
    end

    def initialize()
        @time = 0;
        header = Gtk::HeaderBar.new();
        header.set_show_close_button(true);

        titleLabel = Gtk::Label.new(Window.window.title);
        titleLabel.name = "titleLabel";
        titleLabel.set_margin_left(15);
        header.pack_start(titleLabel);

        timeIcon = Gtk::Image.new(:file => AssetManager.assetsResource("clock.png"));

        @timeLabel = Gtk::Label.new("00:00");
        @timeLabel.name = "timeLabel";

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
