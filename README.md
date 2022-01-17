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
(8. I don't recommend running unverified scripts because they could be malicious!)

## Create Your OWN Scripts!
To get started, open up the Menu in Crab Game, click on the *Scripts* button in the bottom right. The *Scripts* window should appear, now click on *+ New Script* and choose a template for the script. A *Loop* script will run every tick the script is turned on. A *Toggle* script will only do something when it gets toggled. If you want a combination of these, you can of course do it, but you will learn how to do that later on in this tutorial. If you chose to make *Loop* script, you should see an *Update* function. Whatever code you put in that function, it will get executed every game tick on the main game thread. If you chose the *Toggle* script, you will *OnEnable* and *OnDisable* functions, as you could guess, whatever code you put in the *OnEnable* function, it will get executed once the script is turned on. *OnDisable* will get executed once the script is turned off, simple. And no matter whether you chose *Toggle* or *Loop*, you will see *OnGUI* and *OnRender* functions. *OnGUI* will get executed whenever the user chooses to open the script settings which you can btw access by turning the script on and then pressing on the button near the script that just appered.
