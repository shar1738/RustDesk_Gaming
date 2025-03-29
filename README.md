RustDesk-Gaming
DOWNLOAD AUTOHOT KEY 1.1, MAKE SURE YOUR GAME USES WIN32 API FOR CAPTURING INPUT. 
Hello there,

I wanted to find a way to emulate the in-game camera from my home PC to my remote PC over RustDesk. To challenge myself, I decided to implement a custom solution. If you have ever tried gaming over RustDesk you begin to see the issue real quick. I'm still newer to coding, feel free to point out areas that could be improved feedback is welcome I know its not the best solution. This project was developed in a short time frame with a mix of OpenAI assistance and some manual coding. (Mostly Ai tbh)

If you encounter any issues or have better solutions, please share them, and I'll make sure to incorporate your suggestions or fix any bugs.

Overview
This program allows you to confine your mouse within a specified circular boundary on your screen. Once activated, the mouse is restricted to move inside the circle, preventing it from exiting the defined area. You can adjust the circle’s radius using buttons or hotkeys. The center of the circle is dynamically positioned at the center of your screen, ensuring that the confinement is always centered.

The program features a straightforward, GUI that lets you toggle the confinement on or off, modify the radius, reset the radius, increase and decrease the radius, and type your own value above 0. This tool is perfect for users who need to limit mouse movement to a specific area on their screen and for people who want to game on their home pc through rust desk. This program is great for people tryung to game over a admin restricted laptop as RustDesk is a single exe that dosen't require admin credentials to install. (Play at your own risk if your playing where your not supposed to, be smart about using this program please)

The basic program is GM_UI which is the best option right now.
You should configure your mouse speed through you os settings and find what works with your game, usually slowing it all the way down is the best way to play and also MAKING THE RADIUS SMALLER IS USUALLY BETTER. (I couldn't get autohotkey to control your curser speed if their are any solutions let me know).
RD_Window_Confienment is if you just want to keep your mouse in the RustDesk window (ctrl-t to toggle ctrl-k to stop program)
all other files are explained below.

GM: Game Mouse
RD: RustDesk

Setup Instructions
Before You Begin
Make sure you have AutoHotkey installed.
Install RustDesk on both your home and remote PCs, and set it up before proceeding.
Its optional but if you want you can download antimicro off the microsoft store to use a controller (I added my own input map in the repository but use whatever inputs make sense to you). 

Also it is not required but having vscode installed is the easiest way to get everything working. If vscode isn't viable you can use notepad to run autohotkey. 

Your gonna have to configure the circle for every new game you play as not all game cameras are built equal, (.1 is the good for most games)

THE ISSUE 
Everything runs well except for getting your mouse out of the radius when in rust desk. Since rust desk captures your keyboard in its software, it voids all the autohotkeys in the program. This is bad because now you just have a trapped mouse in the middle of the screen with no where to go. THE FIX FOR NOW use other keys on the keyboard to access your current pc again, find the ones that work for you, if your using windows hit CTRL-ALT-DELETE in order to regain control, hit cancel so you don't shut down or log out your pc, and then you are back in the program. This is the only consistent solution I could find without modifying the rust desk code which is a nightmare. Please if you have a solution, please share, but for now, just do this (I know its not ideal but it is what it is for now) ADDED A NEW SOLUTION, just run the getout.ahk everytime your about to start gaming the first solution is still better though. Potential solution 3, you might be able to use a second key board to by bass the limitation. 

For GM_GUI Users:
Run the GM_GUI file.
Drag the GUI to the top-left corner of your screen if not already there, in order to center the circle.
Use the following hotkeys to control the circle:
(Ctrl + 1: Toggle the Hotkeys)
(Ctrl + W: Toggle the GUI)
(Ctrl + T: Toggle the circle on/off)
(Ctrl + K: Stop the program)
(Ctrl + UP: Increase the radius) SMALLER USUALLY IS BETTER 
(Ctrl + DOWN: Decrease the radius)
(Ctrl + R: Reset the gui)
(Ctrl + S: To Save the radius)
(Ctrl + L: To Load the saved radius)

(You can always manually write in your windows name this is just for people who want to copy and paste, --in GETTING EVERYTHING WORKING I elaborate on this).
For RD_WINDOW_CONFINEMENT Users:
Run the get_win file.
In the code file, copy and paste your window name into the designated section ("").
Adjust the resolution to match your display's resolution.

If You Don’t Know Your Resolution:
Run the getresolution file.
Use the obtained resolution in the RD_Window file.

GETTING EVERYTHING WORKING
If you are under restricted wifi (like school wifi) access I recomend using a hotspot, if you can, use a vpn as well for extra security please do so. Run Rust Desk on your home pc and then run it on your remote computer, connect using the pin from your home computer. If you want audio look into streammyaudio software for windows and use a virtual audio cable as your input device (Virtual audio cable costs $5 but there are other free alternatives). Now with rust desk up in running make a shortcut on your desktop for ethier the GM_GUI or GM. Run the program and line up the radius size with the in the game crosshairs with the radius scale buttons. Full screen Rust desk and select the game you want to play and get to the point where your controlling the game camera. After that minimize RustDesk so you get  back to desktop. Then toggle on the radius and then alt tab back into your game. Use esc if you are stuck in a game menu. Remember to get out of this game state refer to THE ISSUE. That pretty much sums up everything though. Let me know if you have any questions or feedback. Happy Bootleg-Gaming!

GAMES THAT SHOULD WORK 
Half-Life 1

Half-Life 2

Counter-Strike: Source

Counter-Strike: Global Offensive

Team Fortress 2

Left 4 Dead 2

Quake III Arena

Unreal Tournament 2004

Unreal Tournament 3

DOOM 3

Wolfenstein: Enemy Territory

Call of Duty 4: Modern Warfare

Call of Duty: World at War

Battlefield 2

Painkiller

Serious Sam 2

Star Wars: Jedi Knight II – Jedi Outcast

Star Wars: Jedi Knight III – Jedi Academy

Warcraft III

Starcraft II

Diablo III

Halo: Combat Evolved (PC)

Halo 2 (PC)

Prey (2006)

Command & Conquer: Generals

Far Cry 1

Far Cry 2

Battlefield 1942

Battlefield Vietnam

Medal of Honor: Allied Assault

Duke Nukem 3D (EDuke32)

Quake Live

Return to Castle Wolfenstein

Resident Evil 4 (PC)

Max Payne 1

Max Payne 2

Red Faction

No One Lives Forever

Aliens vs. Predator 2

Turok: Dinosaur Hunter

Warhammer 40,000: Dawn of War

Total Annihilation

Medieval: Total War

Commandos: Behind Enemy Lines

Star Wars: Battlefront (2004)

Star Wars: Battlefront II (2005)

Crysis (2007)

Crysis Warhead

The Witcher 2: Assassins of Kings

The Elder Scrolls V: Skyrim

Assassin’s Creed (PC)

Assassin’s Creed II (PC)

Watch Dogs (PC)

Max Payne 3

Bioshock Infinite

DOOM (2016)

DOOM Eternal

Shadow Warrior (2013)

Shadow Warrior 2

Warframe

Overwatch

Paladins

Battleborn

Apex Legends

Fortnite (on PC with raw input mode)

PlayerUnknown’s Battlegrounds (PUBG)

Call of Duty: Warzone

Tom Clancy’s Ghost Recon: Wildlands

Tom Clancy’s Ghost Recon: Breakpoint

Dead Space (2008)

Dead Space 2

Dead Space 3

F.E.A.R. (2005)

F.E.A.R. 2: Project Origin

F.E.A.R. 3

Tomb Raider (2013)

Tomb Raider: The Rise of the Tomb Raider

Mafia (2002)

Mafia II

Mafia III

Battlefield 3

Battlefield 4

Battlefield Hardline

Far Cry 3

Far Cry 4

Far Cry 5

Ghost Recon: Future Soldier

Saints Row: The Third

Saints Row IV

Crackdown 3

Watch Dogs 2

No Man’s Sky

Cyberpunk 2077 (with raw input mode)

The Division

The Division 2

Call of Duty: Black Ops (PC)

Call of Duty: Black Ops II

Call of Duty: Black Ops III

Call of Duty: Modern Warfare (2019)
