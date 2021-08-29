using Javis

function ground(args...)
    background("white")
    sethue("black")
end

function title(args...)
    fontsize(20)
    text("Javis' Mascot", Point(0,-200), valign=:middle, halign=:center)
end

hair_angle = rand(-0.9:0.1:0.9, 20)

function hair_blob(angle)
    sethue("brown")
    rotate(angle)
    circle(Point(0,-100), 20, :fill)
end

function draw_eyes(centers, radius, color)
    sethue(color)
    circle.(centers, radius, :fill)
    setcolor("white")
    circle.(centers, radius/5, :fill)
end

function draw_lip(p1, p2)
    setline(2)
    move(p1)
    c1 = p1 + Point(10, 10)
    c2 = p2 + Point(-10, 10)
    curve(c1, c2, p2)
    do_action(:stroke)
end

function speak(str)
    fontsize(15)
    text(str, Point(100,50))
end

eye_centers = [Point(-40,-30), Point(40,-30)]
nose_verts = [O, Point(-10,20), Point(10, 20), O]
ulip = [Point(-40, 45), Point(40, 45)]
llip = [Point(-40, 55), Point(40, 55)]

begin
    vid = Video(500,500)
    Background(1:150, ground)
    title_ = Object(title)
    act!(title_, Action(1:5, appear(:fade)))
    head = Object(
        (args...) -> circle(O, 100, :stroke)
    )
    act!(head, Action(1:15, appear(:fade)))
    hair = [Object(26:150, (args...) -> hair_blob(angle)) for angle in hair_angle]
    act!(hair, Action(1:25, appear(:fade)))
    eyes = Object(
        30:150,
        (args...) -> draw_eyes(eye_centers, 10, "darkblue")
    )
    act!(eyes, Action(1:15, appear(:fade)))
    nose = Object(
        45:150,
        (args...) -> poly(nose_verts, :fill)
    )
    act!(nose, Action(1:15, appear(:fade)))

    lip_fade_in = Action(1:15, appear(:fade))
    upper_lip = Object(60:150, (args...)->draw_lip(ulip...))
    act!(upper_lip, lip_fade_in)
    act!(upper_lip, [Action(20i:20i+10, anim_translate(0, -5)) for i in 1:5])
    act!(upper_lip, [Action(20i+10:20i+20, anim_translate(0, 5)) for i in 1:5])

    lower_lip = Object(60:150, (args...)->draw_lip(llip...))
    act!(lower_lip, lip_fade_in)
    act!(lower_lip, [Action(20i:20i+10, anim_translate(0, 5)) for i in 1:5])
    act!(lower_lip, [Action(20i+10:20i+20, anim_translate(0, -5)) for i in 1:5])

    speak1 = Object(80:120, (args...) -> speak("Eat flaming death!"))
    act!(speak1, Action(1:5, appear(:draw_text)))
    act!(speak1, Action(36:40, disappear(:draw_text)))

    speak2 = Object(120:150, (args...) -> speak("JS users!"))
    act!(speak2, Action(1:5, appear(:draw_text)))
    act!(speak2, Action(36:40, disappear(:draw_text)))

    render(vid, pathname="renders/tutorial_04.gif", framerate=15)
end