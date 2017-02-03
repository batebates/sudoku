require "gtk3"
require "./GridView.rb"
require "./AssistantView.rb"
require "../model/AssetManager.rb"

class Window
    private_class_method :new

    # Constants
    @@WIDTH = 400;
    @@HEIGHT = 400;

    def Window.init()
        new();
    end

    def initialize()
        puts("Creating window...");

        window = Gtk::Window.new("Sudoku");
        window.set_size_request(@@WIDTH, @@HEIGHT);
        window.set_border_width(4);

        # On window close event
        window.signal_connect("delete-event") { |widget|
            Gtk.main_quit;
        }

        # Split window into 2 parts : Left (Grid + Assistant) & Right (Menu)
        mainContainer = Gtk::Grid.new();
        mainContainer.attach(buildLeftContainer(), 0, 0, 1, 1);
        ## Right - TODO (KIM)

        window.add(mainContainer);

        window.show_all();
        Gtk.main();
    end

    def buildLeftContainer()
        # Split container into 2 parts : Top (Grid) & Bottom (Assistant)
        leftContainer = Gtk::Grid.new();
        GridView.init(leftContainer);
        AssistantView.init(leftContainer);

        return leftContainer;
    end
end

Window.init();
