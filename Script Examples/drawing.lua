
--[[
	This script will show you how to use the draw functions and how to overwrite the OnRender function :)
	
	Just download or copy paste it into the built-in text editor in the menu and run it,
	you should see some stuff being drawn
]]--

function Update()
end

local CL_RED = Color(255, 0, 0)
local CL_GREEN = Color(0, 255, 0)
local CL_BLUE = Color(0, 0, 255)

function OnRender()

	-- draw.AddLine
	draw.AddLine(100, 100, 200, 200, CL_RED, 1.0) -- this will draw a red line from the screen coordinates [100, 100] to the screen coordinates [200, 200] with the width of 1.0
	-- another example just to cover _WIN_SIZE_X and _WIN_SIZE_Y
	draw.AddLine(_WIN_SIZE_X - 5, 5, 5, _WIN_SIZE_Y - 5, 1.0) -- draw a line 5 pixels away from the top right corner of the screen to 5 pixels away from the bottom left corner
	
	-- if you don't understand how the screen coordiante system works
	-- check this it out: https://www2.cs.sfu.ca/CourseCentral/166/tjd/_images/screenCoord.png
	-- it's not hard but you must understand it in order to draw stuff the way you want to draw it
	
	-- draw.AddRect
	draw.AddRect(400, 100, 500, 200, CL_BLUE, 2.0) -- draw a blue rectangle with the width of 2.0 from [400, 100] to [500, 200]
	
	-- draw.AddFilledRect
	draw.AddFilledRect(100, 300, 200, 400, CL_GREEN) -- draw a filled green rectangle from [100, 300] to [200, 400]
	
	-- draw.AddCircle
	mouseX, mouseY = input.GetMouse()
	draw.AddCircle(mouseX, mouseY, 20, 30, 2.0, CL_BLUE) -- draw a blue circle around our mouse with the radius of 20 pixels, 30 segments and a width of 2.0
	
	-- draw.AddFilledCircle
	draw.AddFilledCircle(_WIN_CENTER_X, _WIN_CENTER_Y, 50, 50, CL_RED) -- draw a filled red circle in the middle of the screen with a radius of 50 pixels and 50 segments
	
	-- draw.AddText
	draw.AddText(_WIN_SIZE_X - 100, _WIN_SIZE_Y - 100, "Text", Color(255, 0, 255)) -- draw magenta text in the bottom right corner with content "Text"
	
end
