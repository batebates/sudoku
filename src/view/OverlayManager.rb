require "gtk3"

class OverlayManager
    private_class_method :new

    @@overlayPanel = nil;
    @buttons;

    def OverlayManager.init(overlay)
        new(overlay);
    end

    def initialize(overlay)
        @buttons
        @@overlayPanel = Gtk::Fixed.new();
        sudokuChoiceGrid = Gtk::Grid.new();
        sudokuChoiceGrid.name = "overlay-grid";

        for i in 0...9
            x = i % 3;
            y = i / 3;

            buttonChoice = Gtk::Button.new();

            buttonChoice.set_border_width(2);
            buttonChoice.set_size_request(20, 20);
            buttonChoice.add(Gtk::Label.new((i + 1).to_s));
            buttonChoice.signal_connect("clicked") { |widget|
                onClick(widget);
            }
            sudokuChoiceGrid.attach(buttonChoice, x, y, 1, 1);
            @buttons.push(buttonChoice);
        end

        @@overlayPanel.put(sudokuChoiceGrid, 0, 0);

        overlay.add_overlay(@@overlayPanel);
        overlay.set_overlay_pass_through(@@overlayPanel, true);
    end

    def onClick(widget)
        OverlayManager.hide();
        SquareView.selectedSquareView().insertValue(widget.children[0].label.to_i);
    end

    def OverlayManager.hide()
        @@overlayPanel.hide();
    end

    def OverlayManager.show()
        @@overlayPanel.show();
    end

    def OverlayManager.move(x, y)
        @@overlayPanel.move(@@overlayPanel.children[0], x, y);
    end

    def OverlayManager.overlayPanel()
        @@overlayPanel;
    end
end
