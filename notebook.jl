### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 422b14e0-ddb9-11eb-3819-87c692b7aef6
begin
	using Javis
end

# ╔═╡ 194e2b04-70cf-43f1-9d24-ee732759a9d5
function ground(args...) 
    background("white") # canvas background
    sethue("black") # pen color
end

# ╔═╡ f70edb43-2d1b-49f8-bd68-26b683c48b89
function object(p=O, color="black")
    sethue(color)
    circle(p, 25, :fill)
    return p
end

# ╔═╡ 345d1492-05f9-459f-8810-2a3d652bb5a9
begin
    myvideo = Video(500, 500)
	Background(1:70, ground)
	red_ball = Object(1:70, (args...) -> object(O, "red"), Point(100, 0))

	render(
    	myvideo;
    	pathname="circle.gif"
	)
end

# ╔═╡ Cell order:
# ╠═422b14e0-ddb9-11eb-3819-87c692b7aef6
# ╠═194e2b04-70cf-43f1-9d24-ee732759a9d5
# ╠═f70edb43-2d1b-49f8-bd68-26b683c48b89
# ╠═345d1492-05f9-459f-8810-2a3d652bb5a9
