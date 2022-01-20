
--[[
	This script will show you how to use the GUI functions and how to overwrite the OnGUI function :)
	
	Just download or copy paste it into the built-in text editor in the menu and run it,
	then click on the script settings near the script checkbox in the scripts list to
	open the settings for the script so you can see what this code actually does
--]]

function Update()
end

local myCheckbox1 = false

local myHotkey1 = string.byte('F')
local myHotkey1GetKey = false

local myFloat1 = 2.0
local myInt1 = 10

local inputFloat1 = 10.0
local inputInt1 = 100

local myString1 = "Your Text here"

local myCurrentItem1 = 0

function OnGUI()
	
	-- gui.Button and gui.MessageBoxA
	if gui.Button("Button") then
		if IDYES == gui.MessageBoxA("This is an example MessageBox with YES or NO buttons!", "Example Msg Box", MB_YESNO | MB_ICONINFORMATION) then
			gui.MessageBoxA("You just pressed YES!", "You pressed YES", MB_ICONINFORMATION)
		end
	end
	
	-- gui.SameLine
	gui.SameLine() -- using SameLine() to put the next item (the checkbox) on the same line as the previous item (the button)

	-- gui.Checkbox
	myCheckbox1 = gui.Checkbox("Checkbox", myCheckbox1)
	
	-- gui.Hotkey
	myHotkey1, myHotkey1GetKey = gui.Hotkey(myHotkey1, "Hotkey", "##put_random_numbers_here_like_this:1921848191020", myHotkey1GetKey)
	
	-- gui.Text
	gui.Text("Example Text")
	
	-- gui.SetNextItemWidth
	gui.SetNextItemWidth(150) -- sets the next item's (the FloatSlider) width to 150 pixels
	
	-- gui.FloatSlider/IntSlider
	myFloat1 = gui.FloatSlider("Float Slider", myFloat1, 0.0, 10.0, "%.2f")
	gui.SetNextItemWidth(150)
	myInt1 = gui.IntSlider("Int Slider", myInt1, -5, 10, "%d example")
	
	-- gui.Separator
	gui.Separator() -- adds a gray line
	
	-- gui.Sapcing
	gui.Spacing() -- adds spacing between two lines
	gui.Spacing()
	gui.Spacing()
	
	-- gui.InputFloat/InputInt
	gui.SetNextItemWidth(150)
	inputFloat1 = gui.InputFloat("Input Float", inputFloat1, 1.0, 10.0)
	gui.SetNextItemWidth(150)
	inputInt1 = gui.InputInt("Input Int", inputInt1, 1, 10)
	
	-- gui.Combo
	gui.SetNextItemWidth(100)
	myCurrentItem1 = gui.Combo("Combo", myCurrentItem1, { "Item 1", "Item 2", "Item 3" })
	
	--- gui.InputText
	gui.SetNextItemWidth(140)
	myString1 = gui.InputText("Input Text", myString1, 30) -- maximum 30 characters but you can leave this last argument, it's 50 by default
	
end
