class GridView
    private_class_method :new

    @@squareViewList;
    @@isHintMode = false;

    def GridView.init(parent)
        new(parent);
    end

    def initialize(parent)
        puts("Creating sudoku grid...");

        @@squareViewList = Array.new();

        sudokuGrid = Gtk::Grid.new();
        sudokuGrid.set_size_request(SquareView.size() * 9, SquareView.size() * 9);
        for i in 0...81
            x = i % 9;
            y = i / 9;

            @@squareViewList.push(SquareView.init(sudokuGrid, x, y));
        end


        parent.attach(sudokuGrid, 0, 0, 1, 1);
    end

    def GridView.isHintMode()
        @@isHintMode;
    end

    def GridView.setHintMode(enabled)
        @@isHintMode = enabled;
        @@squareViewList.each { |value|
            value.redraw();
        }
    end
end
