require "gtk3"

class SquareView
    private_class_method :new

    @@size = 32;

    def SquareView.init(parent, x, y)
        new(parent, x, y);
    end

    def initialize(parent, x, y)

        squareDraw = Gtk::DrawingArea.new();

        squareDraw.signal_connect("draw") { |widget, ctx|
            render(widget, ctx, x, y);
        }

        squareDraw.add_events(Gdk::EventMask::BUTTON_PRESS_MASK);
        squareDraw.signal_connect("button_press_event") {|widget, event|
            handleClick(event.button, widget);
        }
        squareDraw.set_size_request(@@size, @@size);

        parent.attach(squareDraw, x, y, 1, 1);
    end

    def render(widget, ctx, x, y)

        #White background
        ctx.set_source_rgb(1.0, 1.0, 1.0);
        ctx.rectangle(0, 0, @@size, @@size);
        ctx.fill();

        #Top line
        ctx.move_to(0, 0);
        setLineStyle(ctx, x, y, false);
        ctx.rel_line_to(@@size, 0);
        ctx.stroke();

        #Left line
        ctx.move_to(0, 0);
        setLineStyle(ctx, x, y, true);
        ctx.rel_line_to(0, @@size);
        ctx.stroke();

        #Bottom line
        ctx.move_to(0, @@size);
        setLineStyle(ctx, x, y + 1, false);
        ctx.rel_line_to(@@size, 0);
        ctx.stroke();

        #Right line
        ctx.move_to(@@size, 0);
        setLineStyle(ctx, x + 1, y, true);
        ctx.rel_line_to(0, @@size);
        ctx.stroke();

        #Text
        ctx.set_source_rgb(0.0, 0.0, 0.0);

        ctx.select_font_face("Comic sans MS", Cairo::FONT_SLANT_NORMAL, Cairo::FONT_WEIGHT_BOLD);
        ctx.set_font_size(13);

        textSize = ctx.text_extents("4");
        ctx.move_to((@@size / 2) - (textSize.width / 2),  (@@size / 2) + (textSize.height / 2));
        ctx.show_text("4");

        return self;
    end

    def setLineStyle(ctx, x, y, vertical)
        isBigLine = vertical ? (x % 3 == 0) : (y % 3 == 0);
        isExternalLine = vertical ? (x == 0 || x == 9) : (y == 0 || y == 9);
        color = isBigLine ? 0.0 : 0.0;
        ctx.set_line_width(isBigLine ? (isExternalLine ? 4 : 2) : 0.5);
        ctx.set_source_rgb(color, color, color);
    end

    def handleClick(button, widget)

    end

    def SquareView.size()
        @@size;
    end
end
