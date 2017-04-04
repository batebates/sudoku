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
        SudokuAPI.API.add_observer(self);

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

        if(ProfilManager.dernierJoueur() == nil)
            RegisterView.display(true);
        end

        Gtk.main();
    end

    def buildLeftContainer()
        # Split container into 2 parts : Top (Grid) & Bottom (Assistant)
        leftContainer = Gtk::Grid.new();
        GridView.init(leftContainer);

        @hintPanel = Gtk::Box.new(:horizontal, 0);
        for i in 0...9
            hintButton = Gtk::Button.new();
            hintButton.name = "hintButton";
            insidePanel = Gtk::Box.new(:horizontal, 0);
            insidePanel.pack_start(Gtk::Label.new((i + 1).to_s), :expand => true, :fill => true, :padding => 0);

            hintButton.add(insidePanel);
            hintButton.set_size_request(SquareView.size, 16);
            @hintPanel.add(hintButton);

            hintButton.signal_connect("clicked") { |widget|
                if(widget.name == "hintButton")
                    @hintPanel.each { |widget|
                        widget.name = "hintButton";
                    }

                    widget.name = "hintButtonEnabled";
                    SudokuAPI.API.resetColors();
                    SudokuAPI.API.showNumber(widget.children[0].children[0].label.to_i);
                else
                    SudokuAPI.API.resetColors();
                    widget.name = "hintButton";
                end
            }
        end
        @hintPanel.set_margin_left(4);
        @hintPanel.set_margin_top(4);
        @hintPanel.name = "hintPanel"

        leftContainer.attach(@hintPanel, 0, 1, 1, 1);

        AssistantView.init(leftContainer);

        leftContainer.set_margin_right(4);

        return leftContainer;
    end

    def update(type, data)
        if(type == "hideMenu")
            @hintPanel.name = data ? "hintPanelHidden" : "hintPanel"
			@hintPanel.children.each { |widget|
				if(widget.instance_of?(Gtk::Button))
					widget.sensitive=!data
				end
			}
        end
    end

    def Window.window()
        @@window;
    end

    def Window.root()
        @@rootContainer;
    end
end
