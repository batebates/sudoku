class OverlayManager
    private_class_method :new

    @@overlayPanel = nil;
    @@buttons = nil;

    def OverlayManager.init(overlay)
        new(overlay);
    end

    def initialize(overlay)
        @@buttons = Array.new();
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
            @@buttons.push(buttonChoice);
        end

        @@overlayPanel.put(sudokuChoiceGrid, 0, 0);

        overlay.add_overlay(@@overlayPanel);
        overlay.set_overlay_pass_through(@@overlayPanel, true);
    end

    def onClick(widget)
        square = SquareView.selectedSquareView();
        isEraser = !widget.children[0].class.instance_methods(false).include?(:label);
        if(isEraser)
            SquareView.selectedSquareView().insertValue(square.value);
        else
            SquareView.selectedSquareView().insertValue(widget.children[0].label.to_i);
        end
        OverlayManager.hide();
    end

    def OverlayManager.clear()
        for i in 0...9
            if(@@buttons[i].children.length > 0)
                @@buttons[i].remove(@@buttons[i].children[0]);
            end
        end
    end

    def OverlayManager.hide()
        @@overlayPanel.hide();
        OverlayManager.clear();
    end

    def OverlayManager.show()
        square = SquareView.selectedSquareView();
        OverlayManager.clear();

        possibleValues = [5,9,8,7,2];#TODO

        if(square.value != 0)
            possibleValues.push(square.value);
        end

        for i in 0...9
            if(possibleValues.include?(i + 1))
                if(square.value == i + 1)
                    @@buttons[i].add(Gtk::Image.new(:file => AssetManager.assetsResource("eraser.png")));
                else
                    @@buttons[i].add(Gtk::Label.new((i + 1).to_s));
                end
            end
        end

        @@overlayPanel.show_all();

        for i in 0...9
            if(!possibleValues.include?(i + 1))
                @@buttons[i].hide();
            end
        end
    end

    def OverlayManager.move(x, y)
        @@overlayPanel.move(@@overlayPanel.children[0], x, y);
    end

    def OverlayManager.overlayPanel()
        @@overlayPanel;
    end
end
