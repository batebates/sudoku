class Window
    private_class_method :new

    # Constants
    @@WIDTH = 200;
    @@HEIGHT = 200;

    def Window.init()
        new();
    end

    def initialize()
        puts("Creating window...");

        @@window = Gtk::Window.new("Sudoku");
        @@window.set_size_request(@@WIDTH, @@HEIGHT);
        @@window.set_resizable(false);

        # On window close event
        @@window.signal_connect("delete-event") { |widget|
            Gtk.main_quit;
        }
        Header.init();

        # Split window into 2 parts : Left (Grid + Assistant) & Right (Menu)
        @@rootContainer = Gtk::Box.new(:horizontal);
        mainContainer = Gtk::Grid.new();
        mainContainer.name = "background";

        mainContainer.attach(buildLeftContainer(), 0, 0, 1, 1);
        ## Right
        Menu.init(mainContainer);

        @@rootContainer.add(mainContainer);
        gridOverlay = Gtk::Overlay.new();
        gridOverlay.add(@@rootContainer);
        OverlayManager.init(gridOverlay);

        #gridOverlay.show_all();
        @@window.add(gridOverlay);
        gridOverlay.show_all();
        @@window.show_all();

        CSSStyle.init();
        OverlayManager.hide();

        noUserFound = false;
        if(noUserFound)#Debug
            RegisterView.display(false);
        end

        Gtk.main();
    end

    def buildLeftContainer()
        # Split container into 2 parts : Top (Grid) & Bottom (Assistant)
        leftContainer = Gtk::Grid.new();
        GridView.init(leftContainer);
        AssistantView.init(leftContainer);

        leftContainer.set_margin_right(4);

        return leftContainer;
    end

    def Window.window()
        @@window;
    end

    def Window.root()
        @@rootContainer;
    end
end
