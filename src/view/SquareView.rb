require "gtk3"

class SquareView
    private_class_method :new

    def SquareView.init(parent, x, y)
        new(parent, x, y);
    end

    def initialize(parent, x, y)

        btn = Gtk::Button.new(:label => "0");
        btn.signal_connect("clicked") { |widget|
            puts("OK");
        }

        parent.attach(btn, x, y, 1, 1);
    end
end
