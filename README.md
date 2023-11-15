# Godot-Project-Template

This template removes the repetition and pain of creating the Main Menu, Loading Screen, Pause Menu, and Options Menu for your Godot 4 Project.
Right now there is no UI theme. Feel free to copy this template and apply your own theme to the UI. Hopefully, this can save someone a few hours 
during a Game Jam.

![template-gif-short](https://github.com/Dutchgoose/Godot-Project-Template/assets/5461381/ea1c574f-a1a4-4f49-ac32-972d12b4de16)


## Quickstart

1. Clone this repository
2. Change your Project Name in `Project -> Project Settings -> Application -> Config -> Name Localized` 
4. Click "Play" inside of Godot

## Key Features:
- Main Menu Scene
	- Play Button
	- Options Button
	- Quit Button
- Loading Scene
	- Multithreaded loading of Main scene
	- Loading indicator
- Main Game Scene
	- Simple test animation
- Pause Menu
	- Pause and unpause the game
- Options Menu
	- Sound Effects and Music Audio Bus
	- Windowed / Fullscreen toggle
 - Persistent Game Settings (volume, display settings)
	- Use Godot's ResourceLoader a custom `settings.tres` resource to persist settings.

## Bonus
In addition to being a good starting point for simple projects in Godot, you can also look through the code here for examples of many common patters in Godot 4. These include:
- Threaded resource loading
- UI Node Signals
- Custom Signals
- OnReady variables
- Straightforward project structure
- Audio Buses and Audio Playback

## Directory Structure:
```
scenes/
	ui/
	autoload/
	main.tscn
assets/
	images/
	audio/
resources/
	shaders/
	theme/
	settings/
scripts/
```

Credits:
	- [Ocean Waves Shader](https://godotshaders.com/shader/wind-waker-water-no-textures-needed/)
	- [Ocean Waves Audio](https://freesound.org/people/SNaumann/sounds/708997/)
