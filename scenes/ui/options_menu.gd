extends CanvasLayer
class_name OptionsMenu

signal back_pressed

@onready var window_button = %WindowButton as Button
@onready var sfx_slider = %SFXSlider
@onready var music_slider = $%MusicSlider
@onready var back_button = $%BackButton

var previous_ui: Node

func _ready():
	back_button.pressed.connect(on_back_pressed)
	window_button.pressed.connect(on_window_button_pressed)
	sfx_slider.value_changed.connect(on_audio_slider_changed.bind("SFX"))
	music_slider.value_changed.connect(on_audio_slider_changed.bind("Music"))
	
	update_display()


func update_display():
	window_button.text = "Windowed"
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_button.text = "Fullscreen"

	sfx_slider.value = get_bus_volume_percent("SFX")
	music_slider.value = get_bus_volume_percent("Music")

func get_bus_volume_percent(bus_name: String):
	var bus_index = AudioServer.get_bus_index(bus_name)
	var volume_db = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(volume_db)


func set_bus_volume_percent(bus_name: String, percent: float):
	var bus_index = AudioServer.get_bus_index(bus_name)
	var volume_db = linear_to_db(percent)
	AudioServer.set_bus_volume_db(bus_index, volume_db)
	GameSettings.write_back_volume_setting(bus_name, percent)


func on_window_button_pressed():
	var mode = DisplayServer.window_get_mode()
	if (mode == DisplayServer.WINDOW_MODE_FULLSCREEN):
		GameSettings.set_window_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		GameSettings.set_window_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		
	GameSettings.write_back_display_settings(DisplayServer.window_get_mode())
	update_display()


func on_audio_slider_changed(value: float, bus_name: String):
	set_bus_volume_percent(bus_name, value)


func on_back_pressed():
	back_pressed.emit()
