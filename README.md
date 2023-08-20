# CG-Scripts - Community
Lua Scripts for the free 1hAck Crab Game Mod Menu and a guide on how to make your own!

## How to Load Scripts
1. Dwnload the script you want to use
2. Put it in a folder that you will remember for the next 5 minutes
3. Open up Crab Game and inject the [1hAck Mod Menu](https://discord.gg/1hack) (v3.2 or higher only)
4. Click on *Scripts* in the bottom right corner of the Menu, a window should appear
5. Click on *Open Folder* and select the folder that you put the script in
6. You should see the name of the file on the right, to enable the script click on the checkbox near the name
7. To add more scripts simply paste them in the folder where your first script is
(8. I don't recommend running unverified scripts unless you can check the code yourself because they could be malicious!)

## Create Your OWN Scripts! (Part 1 - Introduction)
**First of all, learn the basics of LUA, it is one of the simplest programming language so it shouldn't be hard! Also make sure to read the ENTIRE TUTORIAL if you want to make an actually useful script!! The documentation is more than enough, you just have to read!!**

**Btw, anyone who makes at least 1 useful script and shares it on the [discord server](https://discord.gg/1hack) will get the *Script Maker* role ;)**

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
| `LUDtoINT` | pAdress: number | LUD: lightuserdata | retunrs the light user data's address | `pMyLightUserData = LUDtoINT(myLightUserData)` |
| `menu.SetFeature` | none | tabOfTheFeature: string, featureGUIname: string, value: bool/float/number/string | sets a value of a feature/option in the menu | `menu.SetFeature("Main", "Invisibility", true)` |
| `menu.GetFeature` | value: bool/float/number/string | tabOfTheFeature: string, featureGUIname: string | gets the value of a feature/option in the menu | `bAimbot = menu.GetFeature("Combat", "Aim Assist")` |
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
| `input.SetKey` | none | key: number, event: number, time: number = 0 | allows you to simulate key pressing/holding/releasing | `input.SetKey(string.byte('W'), KEYEVENTF_KEYDOWN, 2) -- hold down W for 2 seconds` |
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
| `LP.getRigidbody` | rigidbody: URigidbody | none | returns the local player's rigidbody | `rb = LP.getRigidbody(); myVelX, myVelY, myVelZ = rb:getVelocity()` |
| `LP.getCamTransform` | camTrm: UTransform | none | returns the local player's camera transform | `camTrm = LP.getCamTransform(); camTrm.setRot(0.0, 0.0, 0.0)` |
| `LP.getId` | id: number | none | returns the local player's steam ID, which is used by many game functions | `myId = LP.getId()` |
| `game.WorldToScreen` | x: float, y: float, isOnScreen: boolean | worldX: float, worldY: float, wordlZ: float | converts a game world position to screen position | `x, y, bShouldDraw = game.WorldToScreen(enemyX, enemyY, enemyZ)` |
| `game.GetAlivePlayers` | players: list[Player] | none | returns a lua list of all alive players in the lobby (local player not included) | `players = game.GetAlivePlayers(); numPlayers = #players` |
| `game.GetAllPlayers` | players: list[UMonoBehaviour] | none | returns a lua list of all players in the lobby (local player included) | `players = game.GetAllPlayers(); numPlayers = #players` |
| `game.GetHostId` | id: number | none | returns the steam ID of the current lobby host | `hostId = game.GetHostId()` |
| `game.GetObjectsOfType` | objects: list[MonoBehaviour] | className: string, assemblyName: string | returns a list of Unity Objects in the game, you specify the type | `glassPieces = game.GetObjectsOfType("GlassBreak", "Assembly-CSharp")` |
| `game.GetObjectOfType` | object: MonoBehaviour | className: string, assemblyName: string | returns a Unity Object from the game, you specify the type | `myInventory = game.GetObjectOfType("PlayerInventory", "Assembly-CSharp")` |
| `game.GetMethod` | address: number | assemblyName: string, returnType: string, namespace: string, className: string, methodName: string, parameters: string | returns the full address to a function in the game, you can then call that function from lua in a few ways | `pGameMode_GetFreezeTime = game.GetMethod("Assembly-CSharp", "System.Single", "", "GameMode", "GetFreezeTime", "")` |
| `game.GetClass` | pKlass: number | assemblyName: string, namespace: string, className: string | returns a pointer to il2cpp game class | `pGameLoopClass = game.GetClass("Assembly-CSharp", "", "GameLoop")` |
| `game.Cast` | ptr: lightuserdata | objectToCast: lightuserdata/number, metaTableNameToConvertTo: string | allows you to convert a table object to a different table type in lua | `enemy = game.Cast(enemy, "UMonoBehaviour") -- this will cast the 'enemy' object to the MonoBehaviour table` |
| `game.CallFunc` | none | pFunc: number, returnType: string, params: string, args: ... | calls a game function, you can read about the different types that this function can take | `game.CalFunc(pGameMode_GetFreezeTime, "32", "64", pGameMode)` |
| `Player:ToMB` | monoBehaviour: UMonoBehaviour | none | this is a function inside the Player table, it casts the object to UMonoBehaviour | `players = game.GetPlayers(); playerMB = players[#players]:ToMB()` |
| `Player:getPos` | x: float, y: float, z: float | none | this is a function inside the Player table, it returns the position of the player | `players[#players]:GetPos()` |
| `Player:setPos` | none | x: float, y: float, z: float | this is a function inside the Player table, it sets the player's position on the server (host only) | `targetPlayer:setPos(0.0, 0.0, 0.0)` |
| `Player:getBonePos` | x: float, y: float, z: float | bone_index: number | this is a function inside the Player table, it returns the position of a bone of the player | `bonePosX, bonePosY, bonePosZ = players[#players]:getBonePos(1)` |
| `Player:getRot` | pitch: float, yaw: float | none | this is a function inside the Player table, it returns the rotation of the player | `pitch, yaw = players[#players]:getRot()` |
| `Player:getBoneMatrix` | bones: list[UTransform] | none | this is a function inside the Player table, it returns all the bones of the player as a list of UTransform | `bones = players[#players]:getBoneMatrix()` |
| `Player:getId` | id: number | this is a function inside the Player table, it returns the steam ID of the player, which used by many functions | `playerId = targetPlayer:getId()` |
| `Player:getNum` | num: number | this is a function inside the Player table, it returns the number/id of the player that's near his name | `playerNum = targetPlayer:getNum()` |
| `UTransform:getPos` | x: float, y: float, z: float | none | this is a function inside the UTransform table, it returns the position of the transform | `posX, posY, posZ = LP.getMB():getTrm():getPos()` |
| `UTransform:setPos` | none | x: float, y: float, z: float | this is a function inside the UTransform table, it sets transform's position | `LP.getMB():getTrm():setPos(0, 0, 0)` |
| `UTransform:getRot` | pitch: float, yaw: float, roll: float | none | this is a function inside the UTransform table, it returns transform's rotation | `pitch, yaw, roll = LP.getMB():getTrm():getRot()` |
| `UTransform:setRot` | none | x: float, y: float, z: float | this is a function inside the UTransform table, it sets transform's rotation | `LP.getMB():getTrm():setRot(0, 0, 0)` |
| `UTransform:getGameObject` | gameObject: lightuserdata | none | this is a function inside the UTransform table, it returns transform's GameObject | `gameObject = LP.getMB():getTrm():getGameObject()` |
| `URigidbody:getVel` | x: float, y: float, z: float | none | this function is inside the URigidbody table, it returns the velocity of the rb | `velX, velY, velZ = LP.getRigidbody():getVel()` |
| `URigidbody:setVel` | none | x: float, y: float, z: float | this function is inside the URigidbody table, it sets the velocity of the rb | `LP.getRigidbody():setVel(0, 0, 0)` |
| `URigidbody:getAngularVel` | x: float, y: float, z: float | none | this function is inside the URigidbody table, it returns the angular velocity of the rb | `velX, velY, velZ = LP.getRigidbody():getAngularVel()` |
| `URigidbody:setAngularVel` | none | x: float, y: float, z: float | this function is inside the URigidbody table, it sets the angular velocity of the rb | `LP.getRigidbody():setAngularVel(0, 0, 0)` |
| `URigidbody:getDrag` | drag: float | none | this function is inside the URigidbody table, it returns the drag of the rb | `myDrag = LP.getRigidbody():getDrag()` |
| `URigidbody:setDrag` | none | drag: float | this function is inside the URigidbody table, it sets the drag of the rb | `LP.getRigidbody():setDrag(0.0)` |
| `URigidbody:setAngularDrag` | none | drag: float | this function is inside the URigidbody table, it sets the angular drag of the rb | `LP.getRigidbody():setAngularDrag(0.0)` |
| `URigidbody:setMass` | none | mass: float | this function is inside the URigidbody table, it sets the mass of the rb | `LP.getRigidbody():setMass(0.0)` |
| `URigidbody:setUseGravity` | none | bUseGravity: boolean | this function is inside the URigidbody table, it sets the userGravity of the rb | `LP.getRigidbody():setUseGravity(false)` |
| `URigidbody:getIsKinematic` | isKinematic: boolean | none | this function is inside the URigidbody table, it returns the isKinematic of the rb | `myDrag = LP.getRigidbody():getIsKinematic()` |
| `URigidbody:setIsKinematic` | none | isKenamtic: boolean | this function is inside the URigidbody table, it sets the isKinematic of the rb | `LP.getRigidbody():setIsKinematic(false)` |
| `URigidbody:getPos` | x: float, y: float, z: float | none | this function is inside the URigidbody table, it returns the position of the rb | `posX, posY, posZ = LP.getRigidbody():getPos()` |
| `URigidbody:setPos` | none | x: float, y: float, z: float | this function is inside the URigidbody table, it sets the position of the rb | `LP.getRigidbody():setPos(0, 0, 0)` |
| `URigidbody:getRot` | pitch: float, yaw: float, roll: float | none | this function is inside the URigidbody table, it returns the rotation of the rb | `pitch, yaw, roll = LP.getRigidbody():getRot()` |
| `URigidbody:setRot` | none | pitch: float, yaw: float, roll: float | this function is inside the URigidbody table, it sets the rotation of the rb | `LP.getRigidbody():setRot(0, 0, 0)` |
| `URigidbody:addForce` | none | forceX: float, forceY: float, forceZ: float | this function is inside the URigidbody table, it adds force to the rb | `LP.getRigidbody(1.0, 1.0, 1.0)` |
| `UMonoBehaviour:getTrm` | transform: UTransform | none | this function is inside the UMonoBehaviour table, it returns its transform | `myTrm = LP.getMB():getTrm()` |
| `UMonoBehaviour:getGameObject` | gameObject: lightuserdata | none | this function is inside the UMonoBehaviour table, it returns its GameObject | `myGameObject = LP.getMB():getGameObject()` |
| `UMonoBehaviour:getPos` | x: float, y: float, z: float | none | this function is inside the UMonoBehaviour table, its a quick way to access the transform's position | `myPosX, myPosY, myPosZ = LP.getMB():getPos()` |
| `mem.readPtr` | ptr: lightuserdata | address: number | reads a pointer as a pointer and returns it | `somePtr = mem.readPtr(LP.getMB())` |
| `mem.readInt` | value: number | address: number | reads a pointer as a integer and returns it | `someInt = mem.readInt(LP.getMB() + 0x10)` |
| `mem.readFloat` | value: float | address: number | reads a pointer as a float and returns it | `someFloat = mem.readFloat(LP.getMB() + 0x20)` |
| `mem.readByte` | value: number | address: number | reads a pointer as a byte and returns it | `someByte = mem.readByte(LP.getMB() + 0x30)` |
| `mem.readString` | value: string | address: number | reads a pointer as a char pointer and returns it | `someString = mem.readString(LP.getMB() + 0x40)` |
| `mem.readVec2` | x: float, y: float | address: number | reads a pointer as a vector2 and returns it | `someVec2X, someVec2Y = mem.readVec2(LP.getMB() + 0x50)` |
| `mem.readVec3` | x: float, y: float, z: float | address: number | reads a pointer as a vector3 and returns it | `someVec3X, someVec3Y, someVec3Z = mem.readVec3(LP.getMB() + 0x60)` |
| `mem.readMBPtr` | ptr: UMonoBehaviour | address: number | reads a pointer as a UMonoBehaviour pointer and returns it | `myMB = mem.readMBPtr(LP.getMB() + 0x70)` |
| `mem.readTrmPtr` | ptr: UTransform | address: number | reads a pointer as a UTransform pointer and returns it | `myTrm = mem.readTrmPtr(LP.getMB() + 0x80)` |
| `mem.readStruct` | ptr: lightuserdata | address: number, size: number, tableName: string = "" | reads a pointer as a custom structure and returns it | `myStruct = mem.readStruct(LP.getMB() + 0x90, 0x10)` |
| `mem.writePtr` | none | address: number, ptr: number | writes to a pointer pointing to a pointer | `mem.writePtr(LP.getMB() + 0x100, 0xFFFFFFF)` |
| `mem.writeInt` | none | address: number, value: number | writes to an integer pointer | `mem.writeInt(LP.getMB() + 0x110, 100)` |
| `mem.writeFloat` | none | address: number, value: float | writes to a float pointer | `mem.writeFloat(LP.getMB() + 0x120, 100.0)` |
| `mem.writeByte` | none | address: number, value: number | writes to a byte pointer  | `mem.writeByte(LP.getMB() + 0x130, true)` |
| `mem.writeString` | none | address: number, value: string, length: number | copys a string to an address | `mem.writeStr(LP.getMB() + 0x140, "Bruh.", 5)` |
| `mem.writeVec2` | none | address: number, x: float, y: float | writes to a vector2 pointer | `mem.writeVec2(LP.getMB() + 0x150, 10.0, 10.0)` |
| `mem.writeVec3` | none | address: number, x: float, y: float, z: float | writes to a vector3 pointer | `mem.writeVec3(LP.getMB() + 0x160, 10.0, 10.0, 10.0)` |
| `mem.writeStruct` | none | address: number, size: number, source: number (pointer) | copys a structure to a pointer | `mem.writeStruct(LP.getMB() + 0x170, 0x100, randomStructPtr)` |
| `mem.isValidPtr` | isValid: boolean | address: number | checks if a pointer is a junk pointer and if it is safe to read/write to it | `mem.isValidPtr(LP.getMB() + 0x180)` |
| `mem.getStaticPtr` | address: number | base: number, offsets: list[number] | reads through a multi-level pointer and returns the end-point | `mem.getStaticPtr(LP.getMB() + 0x190, { 0x10, 0x0, 0x80 })` |

Those are all the functions that are pre-defined in your lua-scripts. By using the last 19 functions (from the *mem* table) you can do a lot of things in the game that aren't in the menu currently at all. I know I didn't explain well how to use those functions, so **feel free to ask for help in the discord server**!

###### game.CallFunc()
Finally here you can read how to call `game.CallFunc()` which I am pretty sure many of you won't understand at all. `game.CallFunc()` calls a game function that might not be made by me or you, it might be in the game, so just by passing in the pointer to the function and specifying it's *return type* and *params*, you can call any game function. To find a game function easily, use `game.GetMethod()`. It is very important that you understand what you should pass as the *return type* and *params*, otherwise it won't work. You only have two options for the *return type*: "Void" and "64". You can only pass in those values as the return type. *Void* means that the game function doesn't return anything and `game.CallFunc()` also won't return anything in that case. *64* means that the game function's return type is 64-bit in size total. So yes, you are limited to only calling game functions that return *Void* or *64-bit* values. As for the *params*, you can pass in *Void*, *64*, *6432*, *6464*. *Void* means that the game function doesn't take any arguments. *64* means the function takes in 64-bits as parameters. *6432* means the function takes in 96-bits as parameters. *6464* means the function takes in 128-bits as parameters. Unless you passed in "Void" as the *params*, you have to accordingly push the arguments that the game function takes, right after the *params*. I know this is more confusing then maths so here are some examples:
```lua
game.CallFunc(pFunc, "Void", "64", _64bitArgument) -- call a game function that returns void and takes a 64-bit argument

_64bitReturn = game.CallFunc(pFunc, "64", "64", _64bitArgument) -- call a game function that returns a 64-bit value and takes a 64-bit argument

game.CallFunc(pFunc, "Void", "6464", _64bitArgument1, _64bitArgument2) -- call a game function that returns Void and takes two 64-bit arguments
```

## Create Your OWN Scripts! (Part 3 - Brand New Features)
Although it won't be very easy, you can make brand new features for the menu through scripts. This means implementing stuff like a *Respawn* feature or some other kind of h@ck that is not in the mod menu yet at all. You will need a reversing tool called *dnSpy* if you want to make such stuff because you will have to reverse the game yourself a little bit. You can download it from [here](https://github.com/dnSpy/dnSpy/releases). To get started, watch a few tutorials on *dnSpy* and come back here. After you know the basics of *dnSpy*, you can open in dnSpy the *Assembly-CSharp.dll* inside of the *Crab Game (not obfuscated)* folder in this repository. It contains almost all the game classes and functions of Crab Game. By browsing through the classes you can think of new type of a h@ck. The functions you will probably wanna use inside of your scripts will be all the *mem* functions, *game.GetMethod()*, *game.CallFunc()* and *game.GetClass()*.

Alright, that's all, I hope to see some awesome scripts from you guys! And remember, you will be awarded for sharing the scripts with the community.
