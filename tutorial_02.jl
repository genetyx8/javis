using Javis
using Random

cd("F:/Dev/javis")

function ground(args...)
    background("white")
    sethue("black")
end

function circ(p = O; 
    color = "black", 
    action = :fill, 
    radius = 25, 
    edge="solid"
    )
    sethue(color)
    setdash(edge)
    circle(p, radius, action)    
end

function draw_line(p1 = O, p2 = O; 
    color="black", 
    action=:stroke, 
    edge="solid"
    )
    sethue(color)
    setdash(edge)
    line(p1, p2, action)
end

function electrode(p = O;
    fill_color = "white",
    outline_color = "black",
    action = :fill,
    radius = 25,
    circ_text = ""
    )
    sethue(fill_color)
    circle(p, radius, :fill)
    sethue(outline_color)
    circle(p, radius, :stroke)
    text(circ_text, p, valign=:middle, halign=:center)
end

electrodes = [
    (name = "Cz", position = O),
    (name = "C3", position = Point(-70, 0)),
    (name = "C4", position = Point(70, 0)),
    (name = "T3", position = Point(-140, 0)),
    (name = "T4", position = Point(140, 0)),
    (name = "Pz", position = Point(0, 70)),
    (name = "P3", position = Point(-50, 70)),
    (name = "P4", position = Point(50, 70)),
    (name = "Fz", position = Point(0, -70)),
    (name = "F3", position = Point(-50, -70)),
    (name = "F4", position = Point(50, -70)),
    (name = "F8", position = Point(115, -80)),
    (name = "F7", position = Point(-115, -80)),
    (name = "T6", position = Point(115, 80)),
    (name = "T5", position = Point(-115, 80)),
    (name = "Fp2", position = Point(40, -135)),
    (name = "Fp1", position = Point(-40, -135)),
    (name = "A1", position = Point(-190, -10)),
    (name = "A2", position = Point(190, -10)),
    (name = "O1", position = Point(-40, 135)),
    (name = "O2", position = Point(40, 135)),
]

indicators = ["white", "gold1", "darkolivegreen1", "tomato"]

function info_box(video, object, frame)
    fontsize(12)
    box(140, -210, 170, 40, :stroke)
    text("10-20 EEG Array Readings", 140, -220, valign = :middle, halign = :center)
    text("t = $(frame)s", 140, -200, valign = :middle, halign = :center)
end

begin
    vid = Video(500, 500)
    Background(1:10, ground)
    head = Object((args...) -> circ(O, action=:stroke, radius=170))
    in_circle = Object(
        (args...) -> circ(O, action=:stroke, radius=140, edge="longdashed")
    )
    vline = Object(
        (args...) -> draw_line(Point(0,-170), Point(0,170), edge="longdashed")
    )
    hline = Object(
        (args...) -> draw_line(Point(-170,0), Point(170,0), edge="longdashed")
    )
    info = Object(info_box)
    radius = 15
    # NB. Dunno why the tut does it in a retarded way. This works fine
    for e in electrodes
        Object(
            (args...) -> electrode(e.position,
                fill_color = rand(indicators),
                radius=radius, 
                circ_text = e.name
                )
        )
    end

    render(vid; pathname="renders/tutorial_02.gif", framerate=1)
end