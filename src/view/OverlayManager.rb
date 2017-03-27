class OverlayManager
    private_class_method :new

    @@overlayPanel = nil;
    @@buttons = nil;
    @@open = false;

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
            buttonLabel = Gtk::Label.new((i + 1).to_s);
            buttonBox = Gtk::Box.new(:horizontal, 0);
            buttonBox.add(buttonLabel);

            buttonChoice.set_border_width(2);
            buttonChoice.set_size_request(32, 32);
            buttonChoice.add(buttonBox);
            buttonChoice.signal_connect("clicked") { |widget|
                onClick(widget);
            }
            if(x == 0)
                buttonChoice.set_margin_left(4);
            elsif(x == 2)
                buttonChoice.set_margin_right(4);
            end

            if(y == 0)
                buttonChoice.set_margin_top(4);
            elsif(y == 2)
                buttonChoice.set_margin_bottom(4);
            end


            sudokuChoiceGrid.attach(buttonChoice, x, y, 1, 1);
            @@buttons.push(buttonChoice);
        end

        @@overlayPanel.put(sudokuChoiceGrid, 0, 0);

        overlay.add_overlay(@@overlayPanel);
        overlay.set_overlay_pass_through(@@overlayPanel, true);
    end

    def onClick(widget)
        if(widget.name == "overlayButtonHide")
            OverlayManager.hide();
            return;
        end

        square = SquareView.selectedSquareView();
        isEraser = !widget.children[0].class.instance_methods(false).include?(:label);
        if(isEraser)
            SquareView.selectedSquareView().caze.insertValue(square.caze.value);
        else
            SquareView.selectedSquareView().caze.insertValue(widget.children[0].label.to_i);
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
        @@open = false;
        @@overlayPanel.hide();
        OverlayManager.clear();
    end

    def OverlayManager.show()
        @@open = true;
        square = SquareView.selectedSquareView();
        caze = SquareView.selectedSquareView().caze;
        OverlayManager.clear();

        possibleValues = SudokuAPI.API.candidateCaze(caze.x, caze.y);

        if(caze.value != 0)
            possibleValues.push(caze.value);
        end

        for i in 0...9
            if(possibleValues.include?(i + 1))
                if(caze.value == i + 1)
                    @@buttons[i].add(Gtk::Image.new(:file => AssetManager.assetsResource("eraser.png")));
                else
                    @@buttons[i].add(Gtk::Label.new((i + 1).to_s));
                end
            end
        end

        @@overlayPanel.show_all();

        for i in 0...9
            if(!possibleValues.include?(i + 1))
                @@buttons[i].name = "overlayButtonHide";
            else
                @@buttons[i].name = "overlayButtonShow";
            end
        end
    end

    def OverlayManager.move(x, y)
        @@overlayPanel.move(@@overlayPanel.children[0], x, y);
    end

    def OverlayManager.overlayPanel()
        @@overlayPanel;
    end

    def OverlayManager.open?()
        return @@open;
    end
end
