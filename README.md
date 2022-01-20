# CG-Scripts - Community
Lua Scripts for the free 1hAck Crab Game Mod Menu and a guide on how to make your own!

## How to Load Scripts
1. Dwnload the script you want to use
2. Put it in a folder that you will remember for the next 5 minutes
3. Open up Crab Game and inject the [1hAck Mod Menu](https://discord.gg/Wua44KTJvd) (v3.2 or higher only)
4. Click on *Scripts* in the bottom right corner of the Menu, a window should appear
5. Click on *Open Folder* and select the folder that you put the script in
6. You should see the name of the file on the right, to enable the script click on the checkbox near the name
7. To add more scripts simply paste them in the folder where your first script is
(8. I don't recommend running unverified scripts unless you can check the code yourself because they could be malicious!)

## Create Your OWN Scripts! (Part 1 - Introduction)
**First of all, learn the basics of LUA, it is one of the simplest programming language so it shouldn't be hard! Also make sure to read the ENTIRE TUTORIAL if you want to make an actually useful script!! The documentation is more than enough, you just have to read!!**

**Btw, anyone who makes at least 1 useful script and shares it on the [discord server](https://discord.gg/Wua44KTJvd) will get the *Script Maker* role ;)**

*Time to read this part **carefully**: ~30 minutes+*

To get started, open up the Menu in Crab Game, click on the *Scripts* button in the bottom right. The *Scripts* window should appear, now click on *+ New Script* and choose a template for the script. A *Loop* script will run every tick the script is turned on. A *Toggle* script will only do something when it gets toggled. If you want a combination of these, you can of course do it, but you will learn how to do that later on in this tutorial.

###### Loop scripts
If you chose to make *Loop* script, you should see an *Update* function. Whatever code you put in that function, it will get executed every game tick on **the main game thread** when the user is **in-game**, simple enough.

###### Toggle scripts
If you chose the *Toggle* script, you will *OnEnable* and *OnDisable* functions, as you could guess, whatever code you put in the *OnEnable* function, it will get executed once the script is turned on. *OnDisable* will get executed once the script is turned off, simple. Those two functions will get executed on the **main game thread**. **Remember that they will get called only if the user is in-game**. If the user is not in-game, yet he decides to toggle the script and the state changed since last time the script was executed in-game, *OnEnable* or *OnDisable* will still get called accordingly when the user joins back in a game.

###### Overwrting functions
You can overwrite a few different functions which will get executed in different threads and will have different purposes. You already learned about three of those which are *Update*, *OnEnable* and *OnDisable*. In order for your script to work in the first place, you will **need to overwrite *Update* or/and *OnEnable***. You will learn about the rest of the functions you can overwrite down below!

###### Threads
If you don't know what a thread is, you can google it, but basically a thread is an individual independent task on your CPU. In order to run different programs/tasks on your PC, your CPU needs to run different threads, it's that simple to understand. Programs can have a few threads themselves so that they can run two different pieces of code at the same time, that's important to remeber if you want to understand threads for our case, scripts.
Your script will run on different threads and understanding that is essential in order to make a useful working script! As you already should know, for example *Update* gets called on the **main game thread**, this means that the function calls inside of the game and therefore you are free to do anything with memory, pointers, calling game functions and others (don't worry if you don't know what I mean by memory or pointers, that's quite complicated stuff for beginners but you can google it). This is the **only thread** where you can read/access the game data such as the players' position e.g. and so on, if you try to do this in a different thread, the **entire game will crash**! The second thread is the **render thread** if I can say so, this is where the menu gets rendered and where you can render your own GUI for the script! This thread is obviously only for rendering GUI or other elements, don't access game data here!

So in conclusion:
- There are 2 different threads, **main game thread** and **render thread**.
- You can only access game data inside of the main game thread.
- You can only render stuff inside of the render thread.
- Breaking any of the two above stated rules will be followed by a guaranteed game crash.

###### OnGUI
*OnGUI* will get executed whenever the user chooses to open the script settings which you can btw access by turning the script on and then pressing on the button near the script that just appered. You can call GUI functions in the *OnGUI* function to add settings and *User Interface* for the script. Something important to remember is that you can ONLY call GUI functions inside of *OnGUI* because it runs on the **render thread**! You may be wondering now: "Well how am I supposed to know what GUI functions theren are!?", you will learn about all the options and functions you have in the second part of this tutorial.

###### OnRender
*OnRender* will get executed every frame in the **render thread** and unlike *OnGUI*, no matter whether the user chose to open script settings, or even hid the menu, you can still render stuff but not GUI elements. You can render lines, boxes, rectangles, text and circles for example for your own ESP! You will learn about the render functions you have available in the 2nd part of this large tutorial.

###### OnGUIEnable
Similarally to *OnEnable*, this function will get called once when the script is turned on. The only difference is that it will run on the **render thread** and it will get executed instantly even if the user is in the main menu.

###### OnGUIDisbale
Similarally to *OnDisable*, this function will get called once when the script is turned off. The only difference is that it will run on the **render thread** and it will get executed instantly even if the user is in the main menu.

Greate, now we covered **threads**, **how the scripts work** and how to **overwrite functions**, time to move on to the **2nd Part** of this tutorial!

## Create Your OWN Scripts! (Part 2 - Functions and Variables)
*Time to read this part **carefully**: ~50 minutes+*

###### Native Functions
Without **native functions**, the scripts would be basically useless because you would be left with just the standart LUA librarys, but that's definitely not enough to make an exploit script especially considering LUA is a very high level language. This is where **native functions** come in clutch, those functions are written by me in C/C++ which are very low level languages and therefore by calling them, you can have a large control over the game with the scripts! You don't need to fully understand what I mean by **native**, all you need to know is that those functions are not LUA functions, but you can still call them. You will use those functions all the time in your scripts. Remember that *OnGUI* is for rendering GUI elements? Well to do so you need to call **native functions** because lua doesn't have any standart GUI library. Here is an example for a **button**: `gui.Button("Your Text here")`. In this example we are calling *gui.Button* which takes 1 argument - a string and returnes 1 argument - a boolean. If it returns true, this means the button was pressed.

This was just an example for a native function but there are many many others! You don't need to know all of them, just remember this repository so you can find a function for your purposes later on when you get into the coding. I will show you all the native functions at the end of this part and an example on how to use them.

###### Variables
There are some global variables that you didn't define yourself. For example: `__GAME_VERSION`, this variable is of type string and as you could guess it tells you the game version. This variable particurally might not be very useful but there many others that are very useful! Here is the list of all pre-defined variables...

| Name | Type | Value | Description |
| :---: | :---: | :---: | :--- |
| `_IN_GAME` | boolean | non-const | is the user in-game |
| `_WIN_SIZE_X` | number | non-const | game window width |
| `_WIN_SIZE_Y` | number | non-const | game window height |
| `_WIN_CENTER_X` | number | non-const | game window center x |
| `_WIN_CENTER_Y` | number | non-const | game window center y |
| `_GAME_ASSEMBLY` | number | non-const | image base address of `GameAssembly.dll` |
| `__MENU_VERSION` | string | non-const | the mod menu version |
| `__GAME_VERSION` | string | non-const | the crab game version the mod menu was made for |

These are not all of the variables that are pre-defined in your script but those are the main ones, you will learn about the rest as you go through the different native functions.

Now finally, here is the list of all native functions!

| Name | Return | Parameters | Description | Usage |
| :---: | :---: | :---: | :--- | :---: |
| `Enable` | none | none | forces to enable the current script | could be useful in `OnGUIDisable` |
| `Disable` | none | none | forces to disable the current script | could be useful in `OnGUIEnable` |
| `Color` | web_color: number | r: number, g: number = 255, b: number = 255, a: number = 255 | returns a web_color | `draw.AddText(100, 100, "Text", Color(255, 0, 0))` |
| `gui.MessageBoxA` | pressed button id: number | message: string, title: string, type: number | N/A | `if IDYES == gui.MessageBoxA("This box will have YES and NO buttons.", "Example Message Box", MB_YESNO) then ...` |
| `gui.MessageBoxW` | same as MessageBoxA | same as MessageBoxA | the difference to MessageBoxA is that you can use wide characters in the message/title | same as MessageBoxA |
| `gui.MessageBoxExA` | none | same as MessageBoxA | the difference to MessageBoxA is that this won't pause the entire game<br>but won't return anything | same as MessageBoxA |
| `gui.Checkbox` | checked: boolean | label: string, checked: boolean | N/A |  `checkBox1 = gui.Checkbox("Label here", checkBox1)` |
| `gui.Button` | clicked: boolean | label: string | N/A |  `if gui.Button("Label here") then ... end` |
| `gui.Hotkey` | key: number, getKey: boolean | key: number, label: string, random_id: string, bGetKey: boolean | N/A |  `key1, bGetKey1 = gui.Hotkey(key1, "Text here", "##thisisrandomid", bGetKey1)` |
| `gui.Text` | none | label: string | N/A | `gui.Text("Example Text")` |
| `gui.FloatSlider` | value: float | label: string, value: float, min: float, max: float, format: string = "%.3f" | N/A | `float1 = gui.FloatSlider("Label", float1, 0.0, 10.0, "%.2f")` |
| `gui.IntSlider` | value: number | label: string, value: number, min: number, max: number, format: string = "%d" | N/A | `int1 = gui.IntSlider("Label", int1, 0, 10)` |
| `gui.InputFloat` | value: float | label: string, value: float, step: float, step_fast: float = 10.0 | N/A | `float1 = gui.InputFloat("Label", float1, 1.0)` |
| `gui.InputInt` | value: number | label: string, value: number, step: number, step_fast: number = 10 | N/A | `int1 = gui.InputInt("Label", int1, 1)` |
| `gui.InputText` | value: string | label: string, value: string, string_max_size: number = 50 | N/A | `string1 = gui.InputText("Label", string1)` |
| `gui.Combo` | value: number | selected_item: string, selected_item: number, items: list[string] | N/A | `selected_item1 = gui.Combo("Label", selected_item1, { "Item1", "Item2", "Item3" })` |
| `gui.Spacing` | none | none | Adds spacing | `gui.Spacing()` |
| `gui.Separator` | none | none | Adds a seperator | `gui.Separator()` |
| `gui.SameLine` | none | a little complicated.. | set the next item on the same line as the previous item | `gui.SameLine()` or `gui.SameLine(100)` or `gui.SameLine(0, 10)` |
| `gui.SetNextItemWidth` | none | width: number | sets the next item's width | `gui.SetNextItemWidth(100)` |
| `input.IsKeyDown` | state: boolean | key: number | returns true if the key is down | `if input.IsKeyDown(string.byte('J')) then ... end`, this will return true if `J` is down |
| `input.IsKeyPressed` | state: boolean | key: number | returns true if the key is pressed | `if input.IsKeyPressed(string.byte('J')) then ... end` |
| `input.GetMouse` | x: number, y: number | none | returns the current mouse position on the screen | `xMouse, yMouse = input.GetMouse()` |
| `input.SetMouse` | none | x: number, y: number | sets the mouse position (anti-viruses might block it) | `input.SetMouse(0, 0)` |
| `input.MouseEvent` | none | event: number, x: number, y: number | [documentation](https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-mouse_event) | `input.MouseEvent(MOUSEEVENTF_MOVE, 10, 10)` |
| `draw.AddLine` | none | x1: number, y1: number, x2: number, y2: number, color: Color = white, width: float = 1.0 | draws a line on the screen | `draw.AddLine(100, 100, 200, 200, Color(255, 0, 0), 2.0)` |
| `draw.AddRect` | none | trX: number, trY: number, brX: number, brY: number, color: Color = white, width: float = 1.0 | draws a rectangle on the screen | `draw.AddRect(100, 100, 200, 200, Color(255, 0, 255), 2.0)` |
| `draw.AddFilledRect` | none | trX: number, trY: number, brX: number, brY: number, color: Color = white | draws a filled rectangle on the screen | `draw.AddFilledRect(100, 100, 200, 200, Color(0, 0, 255))` |
| `draw.AddCircle` | none | centerX: number, centerY: number, radius: number, segments: number, width: number, color: Color = white | draws a circle on the screen | `draw.AddCircle(_WIN_CENTER_X, _WIN_CENTER_Y, 30, 50, 2, Color(255, 0, 0))` |
| `draw.AddFilledCircle` | none | centerX: number, centerY: number, radius: number, segments: number, color: Color = white | draws a filled circle on the screen | `draw.AddFilledCircle(100, 100, 100, 20, Color(100, 100, 100, 50)` |
| `draw.AddText` | none | posX: number, posY: number, text: string, color: Color = white | draws text on the screen | `draw.AddText(100, 100, "Text", Color(255, 0, 0))` |
| `LP.AimAtPos` | none | worldPosX: float, worldPosY: float, worldPosZ: float, smoothness: float = 1.0 | aim at a world location | `LP.AimAtPos(enemyPosX, enemyPosY, enemyPosZ)` |
| `LP.setSpeed` | none | speed: float | sets the local player's movement speed | `LP.setSpeed(100.0)` |
| `LP.isAlive` | isAlive: boolean | none | returns true if the local player is alive | `amIalive = LP.isAlive()` |
| `LP.getMB` | mb: MonoBehaviour | none | returns the local player pointer as MonoBehaviour class | `mb = LP.getMB(); mb:getTrm():setPos(0, 0, 0)` |
| `LP.getRigidbody` | rigidbody: Rigidbody | none | returns the local player's rigidbody | `rb = LP.getRigidbody(); myVelX, myVelY, myVelZ = rb:getVelocity()` |
| `game.WorldToScreen` | x: float, y: float, isOnScreen: boolean | worldX: float, worldY: float, wordlZ: float | converts a game world position to screen position | `x, y, bShouldDraw = game.WorldToScreen(enemyX, enemyY, enemyZ)` |
| `game.GetPlayers` | players: list[Player] | none | returns a lua list of all alive players in the lobby (local player not included) | `players = game.GetPlayers(); numPlayers = #players` |
| `game.GetObjectsOfType` | objects: list[MonoBehaviour] | className: string, assemblyName: string | returns a list of Unity Objects in the game, you specify the type | `glassPieces = game.GetObjectsOfType("GlassBreak", "Assembly-CSharp")` |
| `game.GetMethod` | address: number | assemblyName: string, returnType: string, namespace: string, className: string, methodName: string, parameters: string | returns the full address to a function in the game, you can then call that function from lua in a few ways | `pGameMode_GetFreezeTime = game.GetMethod("Assembly-CSharp", "System.Single", "", "GameMode", "GetFreezeTime", "")` |


**The documentation is not done, I just have been writing for 3 hours. I will continue tomorrow because there is much left!**







