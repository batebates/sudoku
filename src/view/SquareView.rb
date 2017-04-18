#===Représente une case de la grille du sudoku en gtk
class SquareView
    private_class_method :new

    @@size = 52;
    @@selectedSquareView = nil;

    attr_reader :caze;

    def SquareView.init(parent, x, y)
        new(parent, x, y);
    end

    def initialize(parent, x, y)
        @caze = SudokuAPI.API.cazeAt(x, y);
        @caze.add_observer(self);

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
        setColor(ctx, @caze.color);
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
        if(@caze.invisible)
            return;
        end

        if(@caze.value == 0)
            hintEnabled = (@caze.hint || Config.getValue("show_hint"));
            possibilities = SudokuAPI.API.candidateCaze(caze.x, caze.y);
            excludedValues = SudokuAPI.API.getExclude(caze.x, caze.y);

            ctx.set_font_size(12);

            for i in 0...9
                x = (i % 3) - 1;
                y = (i / 3) - 1;

                excluded = excludedValues.include?(i + 1);
                if((possibilities.include?(i + 1) && hintEnabled) || excluded)
                    setColor(ctx, Colors::CL_NUMBER);
                    ctx.select_font_face("Arial", Cairo::FONT_SLANT_NORMAL, Cairo::FONT_WEIGHT_NORMAL);
                    textSize = ctx.text_extents((i + 1).to_s);
                    ctx.move_to((@@size / 2) - (textSize.width / 2) + (x * 12), (@@size / 2) + (textSize.height / 2) + (y * 12));
                    ctx.show_text((i + 1).to_s);

                    if(excluded)
                        setColor(ctx, Colors::CL_NUMBER_LOCKED);
                        ctx.select_font_face("Arial", Cairo::FONT_SLANT_NORMAL, Cairo::FONT_WEIGHT_BOLD);
                        textSize = ctx.text_extents("X");
                        ctx.move_to((@@size / 2) - (textSize.width / 2) + (x * 12), (@@size / 2) + (textSize.height / 2) + (y * 12));
                        ctx.show_text("X");
                    end
                end
            end
        else
            if(!@caze.locked)
                setColor(ctx, Colors::CL_NUMBER);
                ctx.select_font_face("Comic sans MS", Cairo::FONT_SLANT_NORMAL, Cairo::FONT_WEIGHT_BOLD);
            else
                setColor(ctx, Colors::CL_NUMBER_LOCKED);
                ctx.select_font_face("Arial", Cairo::FONT_SLANT_NORMAL, Cairo::FONT_WEIGHT_BOLD);
            end
            ctx.set_font_size(13);
            textSize = ctx.text_extents(displayValue());
            ctx.move_to((@@size / 2) - (textSize.width / 2),  (@@size / 2) + (textSize.height / 2));
            ctx.show_text(displayValue());
        end

        return self;
    end

    def setLineStyle(ctx, x, y, vertical)
        isBigLine = vertical ? (x % 3 == 0) : (y % 3 == 0);
        isExternalLine = vertical ? (x == 0 || x == 9) : (y == 0 || y == 9);
        color = 0.0;
        ctx.set_line_width(isBigLine ? (isExternalLine ? 4 : 2) : 0.5);
        ctx.set_source_rgb(color, color, color);
    end

    def handleClick(button, widget)
        if(@caze.locked)
            return;
        end

        overlay = OverlayManager.overlayPanel();
        choiceGrid = overlay.children[0];

        #Set pos of overlay
        pos = widget.translate_coordinates(widget.parent, 0, 0);

        #Border
        pos[0] += 2;
        pos[1] += 2;

        #Center x
        width = choiceGrid.allocation.width;
        height = choiceGrid.allocation.height;
        center = width / 2;
        pos[0] -= center;
        pos[0] += @@size / 2;

        #Clamp X
        pos[0] = [[0, pos[0]].max(), @@size * 9 - width].min();

        #Clamp Y
        pos[1] = pos[1] > @@size * 4.5 ? pos[1] - height : pos[1] + @@size;

        @@selectedSquareView = self;
        OverlayManager.move(pos[0], pos[1]);
        OverlayManager.show();
    end

    def onHover(event, widget)

        lastColor = @caze.color;
        hoverList = [];

        hoverList += (SudokuAPI.API.row(@caze.y) + SudokuAPI.API.column(@caze.x)) unless !Config.getValue("show_line_highlight");
        hoverList += (SudokuAPI.API.square(@caze.x, @caze.y)) unless !Config.getValue("show_square_highlight");

        hoverList.uniq.each{|value|
            value.lastColor = value.color;
            value.color = (value.x == @caze.x || value.y == @caze.y) && Config.getValue("show_line_highlight") ? Colors::CL_HIGHLIGHT_LINE : Colors::CL_HIGHLIGHT_SQUARE;
        };

        @caze.lastColor = lastColor;
        @caze.color = Colors::CL_HIGHLIGHT;
    end

    def onLeave(event, widget)
        hoverList = [];

        hoverList += (SudokuAPI.API.row(@caze.y) + SudokuAPI.API.column(@caze.x)) unless !Config.getValue("show_line_highlight");
        hoverList += (SudokuAPI.API.square(@caze.x, @caze.y)) unless !Config.getValue("show_square_highlight");

        hoverList.uniq.each{|value|
            value.color = value.lastColor;
        };

        @caze.color = @caze.lastColor;
    end

    def redraw()
        @squareDraw.queue_draw_area(0, 0,  @@size, @@size);
    end

    def displayValue()
        return @caze.value == 0 ? "" : @caze.value.to_s;
    end

    def update(type, value)
        redraw();
    end

    def updateCazeReference()
        @caze = SudokuAPI.API.cazeAt(@caze.x, @caze.y);
        @caze.add_observer(self);
        redraw();
    end

    def SquareView.size()
        @@size;
    end

    def SquareView.selectedSquareView()
        @@selectedSquareView;
    end

    def setColor(ctx, color)
        ctx.set_source_rgb(color.red / 65355.0, color.green / 65355.0, color.blue / 65355.0);
    end
end
