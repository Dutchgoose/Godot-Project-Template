extends Resource
class_name Settings

@export var sfx_volume: float = 1.0
@export var music_volume: float = 1.0
@export var window_mode: DisplayServer.WindowMode = DisplayServer.WINDOW_MODE_WINDOWED


func set_window_mode(mode: DisplayServer.WindowMode):
	window_mode = mode


func set_bus_volume_percent(bus_name: String, percent: float):
	match bus_name:
		"Music":
			music_volume = percent
		"SFX":
			sfx_volume = percent
