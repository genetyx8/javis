using Javis

cd("F:/Dev/javis")

function ground(args...) 
    background("white") # canvas background
    sethue("black") # pen color
end


function object(p=O, color="black")
    sethue(color)
    circle(p, 25, :fill)
    return p
end

begin
    myvideo = Video(500, 500)
	Background(1:70, ground)
	red_ball = Object(1:70, (args...) -> object(O, "red"), Point(100, 0))
    blue_ball = Object(1:70, (args...) -> object(O, "blue"), Point(200,80))

	render(
    	myvideo;
    	pathname="renders/circles.gif"
	)
end


begin
    myvideo = Video(500, 500)
	Background(1:70, ground)
	red_ball = Object(1:70, (args...) -> object(O, "red"), Point(100, 0))
    act!(red_ball, Action(anim_rotate_around(2π, O)))

	render(
    	myvideo;
    	pathname="renders/rotating_circle.gif"
	)
end

begin
    myvideo = Video(500, 500)
	Background(1:70, ground)
	red_ball = Object(1:70, (args...) -> object(O, "red"), Point(100, 0))
    act!(red_ball, Action(anim_rotate_around(2π, O)))
    blue_ball = Object(1:70, (args...) -> object(O, "blue"), Point(200,80))
    act!(blue_ball, Action(anim_rotate_around(2π, 0.0, red_ball)))

	render(
    	myvideo;
    	pathname="renders/rotating_circles.gif"
	)
end

function path!(points, pos, color)
    sethue(color)
    push!(points, pos)
    circle.(points, 2, :fill)
end

begin
    myvideo = Video(500, 500)

    path_of_red = Point[]
    Background(1:70, ground)
    red_ball = Object(1:70, (args...)->object(O, "red"), Point(100,0))
    act!(red_ball, Action(anim_rotate_around(2π, O)))
    Object(1:70, (args...)->path!(path_of_red, pos(red_ball), "red"))

    render(
        myvideo;
        pathname="renders/orbit.gif"
    )
end

function connector(p1, p2, color)
    sethue(color)
    line(p1,p2, :stroke)
end

begin
    myvideo = Video(500, 500)

    Background(1:70, ground)
    red_ball = Object(1:70, (args...)->object(O, "red"), Point(100,0))
    act!(red_ball, Action(anim_rotate_around(2π, O)))
    blue_ball = Object(1:70, (args...)->object(O, "blue"), Point(200,80))
    act!(blue_ball, Action(anim_rotate_around(2π, 0.0, red_ball)))
    Object(1:70, (args...)->connector(pos(red_ball), pos(blue_ball), "black"))

    render(
        myvideo;
        pathname="renders/linkage.gif"
    )
end

begin
    myvideo = Video(500, 500)

    path_of_red = Point[]
    path_of_blue = Point[]

    Background(1:70, ground)
    red_ball = Object(1:70, (args...)->object(O, "red"), Point(100,0))
    act!(red_ball, Action(anim_rotate_around(2π, O)))
    blue_ball = Object(1:70, (args...)->object(O, "blue"), Point(200,80))
    act!(blue_ball, Action(anim_rotate_around(2π, 0.0, red_ball)))
    Object(1:70, (args...)->connector(pos(red_ball), pos(blue_ball), "black"))
    Object(1:70, (args...)->path!(path_of_red, pos(red_ball), "red"))
    Object(1:70, (args...)->path!(path_of_blue, pos(blue_ball), "blue"))

    render(myvideo; pathname="renders/tutorial_1.gif")
end