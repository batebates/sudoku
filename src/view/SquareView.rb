require "gtk3"

class SquareView
    private_class_method :new

    @@size = 32;
    @@selectedSquareView = nil;

    @value;
    @color;
    @lastColor;

    def SquareView.init(parent, x, y)
        new(parent, x, y);
    end

    def initialize(parent, x, y)
        @value = 0;
        @color = Colors::CL_BLANK;
        @lastColor = @color;

        @squareDraw = Gtk::DrawingArea.new();

        @squareDraw.signal_connect("draw") { |widget, ctx|
            render(self, widget, ctx, x, y);
        }

        @squareDraw.add_events(Gdk::EventMask::BUTTON_PRESS_MASK);
        @squareDraw.add_events(Gdk::EventMask::ENTER_NOTIFY_MASK);
        @squareDraw.add_events(Gdk::EventMask::LEAVE_NOTIFY_MASK);
        @squareDraw.signal_connect("button_press_event") {|widget, event|
            handleClick(event.button, widget);
        }
        @squareDraw.signal_connect("enter_notify_event") {|widget, event|
            onHover(event, widget);
        }
        @squareDraw.signal_connect("leave_notify_event") {|widget, event|
            onLeave(event, widget);
        }
        @squareDraw.set_size_request(@@size, @@size);

        parent.attach(@squareDraw, x, y, 1, 1);
    end

    def render(squareView, idget, ctx, x, y)

        #White background
        ctx.set_source_rgb(@color.red, @color.green, @color.blue);
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

        textSize = ctx.text_extents(displayValue());
        ctx.move_to((@@size / 2) - (textSize.width / 2),  (@@size / 2) + (textSize.height / 2));
        ctx.show_text(displayValue());

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
        overlay = OverlayManager.overlayPanel();
        choiceGrid = overlay.children[0];

        #Set pos of overlay
        pos = widget.translate_coordinates(Window.window, 0, 0);
        pos[0] -= @@size - 2;
        pos[1] -= @@size - 2;

        #Center x
        center = choiceGrid.allocation.width / 2;
        pos[0] -= center - @@size / 2;

        #Clamp X
        pos[0] = [[6, pos[0]].max(), @@size * 9 - choiceGrid.allocation.width - 8].min();

        #Clamp Y
        pos[1] = pos[1] > @@size * 4.5 ? pos[1] - choiceGrid.allocation.height - @@size : pos[1];

        OverlayManager.move(pos[0], pos[1]);
        OverlayManager.show();

        @@selectedSquareView = self;
    end

    def onHover(event, widget)
        @lastColor = @color;
        @color = Colors::CL_HIGHLIGHT;
        redraw();
    end

    def onLeave(event, widget)
        @color = @lastColor;
        redraw();
    end

    def color=(color)
        @color = color;
        redraw();
    end

    def redraw()
        @squareDraw.queue_draw_area(0, 0,  @@size, @@size);
    end

    def displayValue()
        return @value == 0 ? "" : @value.to_s;
    end

    def insertValue(value)
        @value = value == @value ? 0 : value;
        @@selectedSquareView = nil;
        redraw();
    end

    def value=(value)
        @value = value;
        redraw();
    end

    def SquareView.size()
        @@size;
    end

    def SquareView.selectedSquareView()
        @@selectedSquareView;
    end
end
