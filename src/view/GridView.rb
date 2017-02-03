require "gtk3"

class GridView
    private_class_method :new

    def GridView.init(parent)
        new(parent);
    end

    def initialize(parent)
        puts("Creating sudoku grid...");

        sudokuGrid = Gtk::Grid.new();
        for i in 0...81
            x = i % 9;
            y = i / 9;

            sudokuGrid.attach(Gtk::Button.new(:label => x.to_s), x, y, 1, 1);
        end

        parent.attach(sudokuGrid, 0, 0, 1, 1);
    end
end
