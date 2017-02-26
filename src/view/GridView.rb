require "gtk3"
require "./SquareView.rb"

class GridView
    private_class_method :new

    def GridView.init(parent)
        new(parent);
    end

    def initialize(parent)
        puts("Creating sudoku grid...");

        gridOverlay = Gtk::Overlay.new();

        sudokuGrid = Gtk::Grid.new();
        sudokuGrid.set_size_request(SquareView.size() * 9, SquareView.size() * 9);
        for i in 0...81
            x = i % 9;
            y = i / 9;

            SquareView.init(sudokuGrid, x, y);
        end


        parent.attach(sudokuGrid, 0, 0, 1, 1);
    end
end
