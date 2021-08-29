using Javis
using LaTeXStrings

cd("F:/Dev/javis/")

function ground(args...)
    background("white")
    sethue("black")
end

function draw_latex(video, action, frame)
    fontsize(50)
    latex(
        L"""\begin{equation}
        \left[\begin{array}{cc} 
        2 & 3 \\  4 & \sqrt{5} \\  
        \end{array} \right] 
        \end{equation}""",
        O
    )
end

begin
    vid = Video(500,500)
    Background(1:1, ground)
    Object(draw_latex)
    render(vid, pathname="renders/tutorial_03.gif")
end