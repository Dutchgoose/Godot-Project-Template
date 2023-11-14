extends CanvasLayer

@onready var main_menu_body = %MainMenuBody
@onready var play_button = %PlayButton
@onready var options_button = %OptionsButton
@onready var quit_button = %QuitButton

var loading_scene: PackedScene = preload("res://scenes/ui/loading_screen.tscn")
var options_menu_scene: PackedScene = preload("res://scenes/ui/options_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	play_button.pressed.connect(func(): get_tree().change_scene_to_packed(loading_scene))
	options_button.pressed.connect(on_options_pressed)
	quit_button.pressed.connect(func(): get_tree().quit())


func on_options_pressed():
	var options_menu_instance = options_menu_scene.instantiate()
	options_menu_instance.back_pressed.connect(on_options_back_pressed.bind(options_menu_instance))
	main_menu_body.visible = false
	add_child(options_menu_instance)

func on_options_back_pressed(options_menu: OptionsMenu):
	main_menu_body.visible = true
	options_menu.queue_free()
